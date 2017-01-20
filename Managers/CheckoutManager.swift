//
//  CheckoutManager.swift
//  Groopdealz
//
//  Created by Kow Ai Woon on 11/19/15.
//  Copyright © 2015 MobileGenius. All rights reserved.
//

import UIKit

class CheckoutManager: NSObject {
    static let sharedInstance = CheckoutManager()
    
    /*
    device_id:
    cart_items:
    s_first_name:
    s_last_name:
    s_addr_1:
    s_addr_2:
    s_city:
    s_state_province:
    s_zip_postal:
    s_country:
    
    b_first_name:
    b_last_name:
    b_addr_1:
    b_addr_2:
    b_city:S
    b_state_province:
    b_zip_postal:
    b_country:
    full_card_number:
    card_exp_m:
    card_exp_y:
    card_code:
    
    conf_email:
    
    new_account_password: (optional)
    new_account_password_confirm: (optional)
    */
    
    var cartItems:String = String()
/*
    if user is not signed in and there is no available shippingAddressId and paymentProfileId then it is possible to send the shipping info and payment info as paramenters in the call
*/
    var paymentEntry:PaymentEntry?
    var shippingAddress:AddressEntry?
    // OR
    var paymentProfileId:String?
    var shippingAddressId:String?
    
    var couponCode = String()
    var creditToApply:Double = Double()
    
    var confirmationEmail = String()
    
    var newAccountPassword = String()
    var newAccountPasswordConfirm = String()
    
    var locale:String?
    var totalMSRP:String?
    var totalShipping:String?
    var subtotal:String?
    var couponDiscount:String?
    var appliedCredit:String?
    var total:String?
    var amountSaved:String?
    var percentSaved:String?
    
    /*
    "locale": "USA",
    "total_msrp": "334.92",
    "total_shipping": "35.41",
    "subtotal": "138.90",
    "coupon_discount": "0.00",
    "applied_credit": "0.00",
    "total": "174.31",
    "amount_saved": "196.02",
    "percent_saved": "41"
    */
    
    func resetCheckoutManager(){
        paymentEntry = nil
        shippingAddress = nil
        
        paymentProfileId = nil
        shippingAddressId = nil
        
        couponCode = String()
        creditToApply = Double()
        
        confirmationEmail = String()
        
        newAccountPassword = String()
        newAccountPasswordConfirm = String()
        
        creditToApply = Double()
        
        locale = nil
        totalMSRP = nil
        totalShipping = nil
        subtotal = nil
        couponDiscount = nil
        appliedCredit = nil
        total = nil
        amountSaved = nil
        percentSaved = nil
        
    }
}
