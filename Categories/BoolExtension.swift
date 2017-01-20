//
//  BoolExtension.swift
//  Groopdealz
//
//  Created by Kow Ai Woon on 26.10.15.
//  Copyright © 2015 MobileGenius. All rights reserved.
//

import UIKit

// To use 'someBoolValue &= otherBoolValue' as a short form of:
// someBoolValue = someBoolValue && otherBoolValue
func &=(lhs: inout Bool, rhs: Bool) {
    lhs = lhs && rhs
}
