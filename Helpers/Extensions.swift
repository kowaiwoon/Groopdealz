//
//  Extensions.swift
//  APEX
//
//  Created by Kow Ai Woon on 11/21/15.
//  Copyright © 2015 MobileGenius. All rights reserved.
//

import Foundation
import UIKit

extension Dictionary{

}

func + <K,V>(left: Dictionary<K,V>, right: Dictionary<K,V>) -> Dictionary<K,V> {
    
    var map = Dictionary<K,V>()
    for (k, v) in left {
        map[k] = v
    }
    for (k, v) in right {
        map[k] = v
    }
    return map
}


func += <KeyType, ValueType> (left: inout Dictionary<KeyType, ValueType>, right: Dictionary<KeyType, ValueType>) {
    for (k, v) in right {
        left.updateValue(v, forKey: k)
    }
}


extension UIView{
    
    func addBackgroundTapKeyboardDismiss(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(UIView.hideKeyboard))
        tapGesture.cancelsTouchesInView = true
        self.addGestureRecognizer(tapGesture)
    }
    
    func hideKeyboard() {
        self.endEditing(true)
    }
    
}

extension UINavigationController{
    
    func setupCustomBackButton ()
    {
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .bordered, target: nil, action: nil)
    }
    
    func popToRoot(_ sender:UIBarButtonItem){
        self.popToRootViewController(animated: true)
    }
}

extension UIViewController{
    

}

extension UITableViewController{
    
    func addPullToRefresh(_ action:Selector){
        self.refreshControl = UIRefreshControl()
        self.refreshControl!.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl!.addTarget(self, action: action, for: UIControlEvents.valueChanged)
    }
    
}

extension NSObject {
    class func checkObjectType(_ object:AnyObject){
        switch object {
        case is String: print("I'm a string")
        case is [String:AnyObject]: print("I'm a dictionary = [String:AnyObject]")
        case is NSObject: print("I'm a NSObject")
        case is [AnyObject]: print("I'm an Array")
        default: print("I'm not a string")
        }
    }
}

extension String  {
    var md5: String! {
        let str = self.cString(using: String.Encoding.utf8)
        let strLen = CC_LONG(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        
        CC_MD5(str!, strLen, result)
        
        let hash = NSMutableString()
        for i in 0..<digestLen {
            hash.appendFormat("%02x", result[i])
        }
        
        result.deallocate(capacity: digestLen)
        
        return String(format: hash as String)
    }
}
