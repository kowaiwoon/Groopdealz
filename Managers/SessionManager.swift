//
//  SessionManager.swift
//  Groopdealz
//
//  Created by Kow Ai Woon on 9/12/15.
//  Copyright (c) 2015 MobileGenius. All rights reserved.
//

import UIKit
import SimpleKeychain

class SessionManager: NSObject {
    
    static let sharedInstance = SessionManager()
    
    fileprivate let TokenKey = "user-token"
    fileprivate let EmailKey = "user-email"
    fileprivate let DeviceIdKey = "device-id"
    fileprivate let DeviceTokenKey = "device-token" // meant for push notifications
    
    let keychain = A0SimpleKeychain()
    
    
    var token: String {
        get {
            return keychain.string(forKey: TokenKey) ?? ""
        }
        set {
            keychain.setString(newValue, forKey: TokenKey)
        }
    }
    
    var email: String {
        get {
            return keychain.string(forKey: EmailKey) ?? ""
        }
        set {
            keychain.setString(newValue, forKey: EmailKey)
        }
    }
    
    var deviceToken: String? {
        get {
            return keychain.string(forKey: DeviceTokenKey) ?? ""
        }
        set {
            keychain.setString(newValue!, forKey: DeviceTokenKey)
        }
    }
    
    fileprivate var deviceIdentifier: String {
        get {
            var value = keychain.string(forKey: DeviceIdKey) ?? ""
            if value == "" {
                value = UUID().uuidString
                keychain.setString(value, forKey: DeviceIdKey)
            }
            return value
        }
        set {
            keychain.setString(newValue, forKey: DeviceIdKey)
        }
    }
    
    var deviceId: String {
        get {
            return deviceIdentifier
        }
    }
    
    var user: User?

    var useCredit: Bool = true
    
    func removeToken() {
        if keychain.hasValue(forKey: TokenKey) {
            keychain.deleteEntry(forKey: TokenKey)
        }
    }
    
    func isLoggedIn() -> Bool {
        return token != "" && email != ""
    }
}
