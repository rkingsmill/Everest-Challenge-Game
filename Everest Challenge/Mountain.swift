//
//  Person.swift
//  Altitude
//
//  Created by Rosalyn Kingsmill on 2016-06-13.
//  Copyright © 2016 Rosalyn Kingsmill. All rights reserved.
//

import Foundation
import CoreGraphics

class Mountain {
    
    var actualClimbedHeight = NSNumber()
    let actualMountainHeight = NSNumber(float: 8848)
    //need to change if top or bottom points change
    let simulatedMountainHeight = NSNumber(float: 0.783433)
    var simulatedClimbedHeight: NSNumber {
        get {
            return simulatedMountainHeight.floatValue * (actualClimbedHeight.floatValue / actualMountainHeight.floatValue)
        }
    }
    
  
    
}

