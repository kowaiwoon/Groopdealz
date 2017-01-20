//
//  FacebookManager.swift
//  Groopdealz
//
//  Created by Kow Ai Woon on 17.12.15.
//  Copyright © 2015 MobileGenius. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class FacebookManager : NSObject {
    
    static var loginManager = {
        return FBSDKLoginManager()
    }()
    
    static var userId: String? {
        if let token = FBSDKAccessToken.current() {
            return token.userID
        } else {
            return nil
        }
    }
    
    static var isLoggedIn: Bool {
        return (FBSDKAccessToken.current() != nil)
    }
    
    static var firstName: String?
    static var lastName: String?
    
    static var generatedPassword: String? {
        if var stringToHash = self.userId {
            stringToHash = stringToHash + "\(Constants.Salt)"
            print("string to hash: \(stringToHash)")
            let md5String = stringToHash.md5
            print("md5 generated password: \(md5String)")
            return md5String
        }
        else{
            return nil
        }
    }
    
    static func getUserInfo(_ success: (() -> ())?) {
        guard let _ = FBSDKAccessToken.current() else {
            return
        }
        
        FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "first_name, last_name, email"])
            .start(completionHandler: {
                (connection, result, error) -> Void in
                if error == nil {
                    firstName = (result as AnyObject).object(forKey: "first_name") as? String
                    lastName = (result as AnyObject).object(forKey: "last_name") as? String
                    if let email = (result as AnyObject).object(forKey: "email") as? String {
                        SessionManager.sharedInstance.email = email
                    }
                    
                    if let success = success {
                        success()
                    }
                }
                ProgressHudManager.sharedInstance.hide()
            })
    }
    
    static func logIn(_ fromViewController: UIViewController, success: (() -> ())?) {
        ProgressHudManager.sharedInstance.show()
        
        DispatchQueue.main.async {
            loginManager.logIn(
                withReadPermissions: ["public_profile", "email"],
                from: fromViewController,
                handler: {
                    (result, error) in
                    if error != nil {
                        //print("FBLogin error: \(error)")
                        ProgressHudManager.sharedInstance.hide()
                    }
                    else if (result?.isCancelled)! {
                        //print("FBLogin cancelled, token=\(result.token)")
                        ProgressHudManager.sharedInstance.hide()
                    }
                    else {
                        //print("FBLogin: success");
                        //SessionManager.sharedInstance.token = result.token.tokenString
                        getUserInfo(success)
                    }
            })
        }
    }
    
}
