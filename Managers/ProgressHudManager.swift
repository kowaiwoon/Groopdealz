//
//  ProgressHudManager.swift
//  Groopdealz
//
//  Created by Kow Ai Woon on 26.11.15.
//  Copyright © 2015 MobileGenius. All rights reserved.
//

import UIKit
import MBProgressHUD

class ProgressHudManager : NSObject {
    
    static var sharedInstance = ProgressHudManager()
    
    let progressHud = MBProgressHUD()
    var onHudWasHidden: (() -> Void)?
    var continousRequests: Int = 0
    
    override init() {
        super.init()
        
        progressHud.isUserInteractionEnabled = true
        progressHud.backgroundColor = UIColor.groupTableViewBackground.withAlphaComponent(0.6)
        progressHud.color = Constants.GroopdealsPrimaryColor
        progressHud.mode = .indeterminate
        progressHud.detailsLabelText = "Loading..."
        progressHud.removeFromSuperViewOnHide = true
    }
    
    func show() {
        UIApplication.shared.keyWindow?.addSubview(progressHud)
        progressHud.taskInProgress = true
        progressHud.show(true)
    }
    
    func hide() {
        if continousRequests > 0 && continousRequests-- > 1 {
            return
        }
        progressHud.taskInProgress = false
        progressHud.hide(true)
    }
    
    func isLoading() -> Bool {
        return progressHud.taskInProgress
    }
    
    func onCompletion(_ completionBlock: MBProgressHUDCompletionBlock?, executeOnceOnly: Bool) {
        if !executeOnceOnly {
            progressHud.completionBlock = completionBlock
        } else {
            progressHud.completionBlock = {
                if let completionBlock = completionBlock {
                    completionBlock()
                }
                self.progressHud.completionBlock = nil
            }
        }
    }
    
    func disableForNextRequest() {
        if let manager = GroopdealzApiManager.API.manager as? GroopdealzRequestOperationManager {
            manager.disableHudForNextRequest = true
        }
    }
    
}
