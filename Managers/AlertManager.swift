//
//  ErrorAlertManager.swift
//  Groopdealz
//
//  Created by Kow Ai Woon on 9/13/15.
//  Copyright (c) 2015 MobileGenius. All rights reserved.
//

import UIKit

enum BlockButtonType {
    case `default`
    case destructive
    case cancel
}

typealias ActionHandlerType = () -> ()

class BlockActionSheet : UIActionSheet, UIActionSheetDelegate {
    var handlers:[Int:ActionHandlerType] = [Int:ActionHandlerType]()
    
    init() {
        super.init(title: nil, delegate:nil, cancelButtonTitle:nil, destructiveButtonTitle:nil)
        delegate = self
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func addButton(_ title:String, buttonType:BlockButtonType, handler:ActionHandlerType?) {
        let index = self.addButton(withTitle: title)
        
        handlers[index] = handler
        
        switch buttonType {
            case .destructive:
                self.destructiveButtonIndex = index;
                break;
                
            case .cancel:
                self.cancelButtonIndex = index;
                break;
                
            default:
                break;
        }
    }
    
    func actionSheet(_ actionSheet: UIActionSheet, didDismissWithButtonIndex buttonIndex: Int) {
        if let handler = handlers[buttonIndex] {
            handler()
        }
    }
    
}

class BlockAlertView : UIAlertView, UIAlertViewDelegate {
    var handlers:[Int:ActionHandlerType] = [Int:ActionHandlerType]()
    
    init() {
        super.init(frame: CGRect.zero)
        delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func addButton(_ title:String, buttonType:BlockButtonType, handler:ActionHandlerType?) {
        let index = self.addButton(withTitle: title)
        
        handlers[index] = handler
        
        switch buttonType {
            case .cancel:
                self.cancelButtonIndex = index;
                break;
                
            default:
                break;
        }
    }
    
    func alertView(_ alertView: UIAlertView, didDismissWithButtonIndex buttonIndex: Int) {
        if let handler = handlers[buttonIndex] {
            handler()
        }
    }
}



class AlertManager: NSObject {
    
    class func displaySignOutAlert(_ viewController: UIViewController) {
        // TODO: make this work
    }
    
    class func displayAlertWithError(_ error: String, viewController: UIViewController) {
        if #available(iOS 8.0, *) {
            let alertController = UIAlertController(title: nil, message: error, preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(cancelAction)
            alertController.view.tintColor = Constants.GroopdealsPrimaryColor
            
            viewController.present(alertController, animated: true, completion: nil)
        } else {
            // Fallback on earlier versions
            let alertView = UIAlertView(title: nil, message: error, delegate: nil, cancelButtonTitle: "OK")
            alertView.show()
        }
    }
    
    class func displayAlertView(_ title:String?, message:String?, cancelButtonTitle:String, cancelAction:ActionHandlerType?, destructiveButtonTitle:String?, destructiveAction:ActionHandlerType?, otherActions:[(String, ActionHandlerType)], viewController: UIViewController) {
        
        if #available(iOS 8.0, *) {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            
            // TODO: tint color gets "forgotten" once user touches a button (on touchesBegan)
            alertController.view.tintColor = Constants.GroopdealsPrimaryColor
            
            if let destructiveButtonTitle = destructiveButtonTitle {
                alertController.addAction(UIAlertAction(title: destructiveButtonTitle, style: .destructive) {
                        action -> Void in
                        if let destructiveAction = destructiveAction {
                            destructiveAction()
                    }
                    })
            }
            
            for (buttonTitle, buttonAction) in otherActions {
                alertController.addAction(UIAlertAction(title: buttonTitle, style: .default) {
                        action -> Void in
                        buttonAction()
                    })
            }
            
            
            alertController.addAction(UIAlertAction(title: cancelButtonTitle, style: .cancel) {
                    action -> Void in
                    if let cancelAction = cancelAction {
                        cancelAction()
                    }
                })
            
            viewController.present(alertController, animated: true, completion: nil)
        } else {
            // Fallback on earlier versions
            let alertView = BlockAlertView()
            if let title = title {
                alertView.title = title
            }
            alertView.message = message
            
            // destructive actions are not visible on old alert views
            if let destructiveButtonTitle = destructiveButtonTitle {
                alertView.addButton(destructiveButtonTitle, buttonType: .destructive, handler: destructiveAction)
            }
            
            for (buttonTitle, buttonAction) in otherActions {
                alertView.addButton(buttonTitle, buttonType: .default, handler: buttonAction)
            }
            
            
            alertView.addButton(cancelButtonTitle, buttonType: .cancel, handler: cancelAction)
            
            alertView.show()
        }
    }
    
    
    class func displayActionSheet(_ cancelButtonTitle:String, cancelAction:ActionHandlerType?, destructiveButtonTitle:String?, destructiveAction:ActionHandlerType?, otherActions:[(String, ActionHandlerType)], viewController: UIViewController) {
        if #available(iOS 8.0, *) {
            let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            
            // TODO: tint color gets "forgotten" once user touches a button (on touchesBegan)
            alertController.view.tintColor = Constants.GroopdealsPrimaryColor
            
            if let destructiveButtonTitle = destructiveButtonTitle {
                alertController.addAction(UIAlertAction(title: destructiveButtonTitle, style: .destructive) {
                    action -> Void in
                    if let destructiveAction = destructiveAction {
                        destructiveAction()
                    }
                })
            }
            
            for (buttonTitle, buttonAction) in otherActions {
                alertController.addAction(UIAlertAction(title: buttonTitle, style: .default) {
                    action -> Void in
                    buttonAction()
                })
            }
            
            
            alertController.addAction(UIAlertAction(title: cancelButtonTitle, style: .cancel) {
                action -> Void in
                if let cancelAction = cancelAction {
                    cancelAction()
                }
            })
            
            viewController.present(alertController, animated: true, completion: nil)
        } else {
            // Fallback on earlier versions
            let actionSheet = BlockActionSheet()

            // this won't work anyway
            //actionSheet.tintColor = Constants.GroopdealsPrimaryColor
            
            if let destructiveButtonTitle = destructiveButtonTitle {
                actionSheet.addButton(destructiveButtonTitle, buttonType: .destructive, handler: destructiveAction)
            }
            
            for (buttonTitle, buttonAction) in otherActions {
                actionSheet.addButton(buttonTitle, buttonType: .default, handler: buttonAction)
            }

            
            actionSheet.addButton(cancelButtonTitle, buttonType: .cancel, handler: cancelAction)
            
            actionSheet.show(in: viewController.view)
            
        }
    }
    
   
    fileprivate class func messageForError(_ error: String) -> String {
        switch error {
            case "Invalid Request":
            return "Invalid Request"
        default:
            return "Hmmm... No!"
        }
    }
}
