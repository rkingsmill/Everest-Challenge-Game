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
    
    func getDistance() -> Float {
        
            let xDist = CGFloat(self.x - firstBaseCampPoint.x)
            let yDist = CGFloat(self.y - firstBaseCampPoint.y)
            let distance = Float(sqrt((xDist * xDist) + (yDist * yDist)))
            return distance
            //print("BaseCamp Distance (0-5): ", path.baseCamps[idx].distance)

        //let totalDistance = path.baseCamps[5].distance! - path.baseCamps[0].distance!
        //print("Total Distance: ", totalDistance)
    }
    
    
}

