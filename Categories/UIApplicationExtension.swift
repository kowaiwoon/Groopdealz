//
//  UIApplicationExtension.swift
//  Groopdealz
//
//  Created by Kow Ai Woon on 11.11.15.
//  Copyright © 2015 MobileGenius. All rights reserved.
//

import UIKit

extension UIApplication {
    
    func registerForPushNotifications() {
        // TODO: remove debug print
        print("registerForPushNotification")
        if #available(iOS 8.0, *) {
            let notificationSettings = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            registerUserNotificationSettings(notificationSettings)
            registerForRemoteNotifications()
        } else {
            let notificationTypes : UIRemoteNotificationType = [.alert, .badge, .sound]
            registerForRemoteNotifications(matching: notificationTypes)
        }
    }
    
    func isRegisteredForPushNotifications() -> Bool {
        if #available(iOS 8.0, *) {
            return isRegisteredForRemoteNotifications
        } else {
            return (enabledRemoteNotificationTypes() != UIRemoteNotificationType())
        }
    }
}
