//
//  BaseCamp.swift
//  MountEverest
//
//  Created by Rosalyn Kingsmill on 2016-06-15.
//  Copyright © 2016 YasminA. All rights reserved.
//

import Foundation
import CoreGraphics
import UIKit

class BaseCamp {
    
    //relative x and y
    let x : CGFloat
    let y : CGFloat
//    var distance: Float?

    var realX: CGFloat?
    var realY: CGFloat?
    
    let firstBaseCampPoint: CGPoint = CGPoint(x: 0.0033, y: 1 - 0.729)
    
    
    init (x: CGFloat, y: CGFloat){
        self.x = x
        self.y = y
//        self.distance = self.getDistance()
    }
    
    var campAsRelativePoint:CGPoint {
        return CGPoint(x: self.x, y: self.y)
    }
    
    func calculateDistanceWithPreviousCamp(previousCamp:BaseCamp, frameSize:CGSize) -> Double {
            //convert coordinates to screen size
            let screenSizePreviousX = previousCamp.x * frameSize.width
            let screenSizePreviousY = previousCamp.y * frameSize.height
            let screenSizeCurrentX = self.x * frameSize.width
            let screenSizeCurrentY = self.y * frameSize.height
        
            let xDist = CGFloat(screenSizeCurrentX - screenSizePreviousX)
            let yDist = CGFloat(screenSizeCurrentY - screenSizePreviousY)
            let distance = Double(sqrt((xDist * xDist) + (yDist * yDist)))
            print("Distance", distance)
            return distance
    }    
}

