//
//  Utils.swift
//  Everest Challenge
//
//  Created by Rosalyn Kingsmill on 2016-06-17.
//  Copyright © 2016 Rosalyn Kingsmill. All rights reserved.
//

import UIKit

class Utils {
    
    static let actualMountainHeight : Float = 8848
    //need to change if top or bottom points change
    static let simulatedMountainHeight : Float = 0.783433

    
    static func flightsOfStairsToMeters(flights: Float) -> Float {
        return flights*4.7
    }
    
    static func convertDistanceClimbedToScreenClimbed(distanceClimbed: Float) -> Float {
        
        return simulatedMountainHeight * (distanceClimbed / actualMountainHeight)
    }
    
    static func multiplyRelativeCoordinates(point:CGPoint, frame:CGRect) ->CGPoint {
        let width = CGRectGetWidth(frame)
        let height = CGRectGetHeight(frame)
        let realX = point.x*width
        let realY = point.y*height
        return CGPoint(x:realX, y:realY)
        
        
        ////        for idx in 0...(path.baseCamps.count - 1) {
        //            path.baseCamps[idx].x = path.baseCamps[idx].x*width
        //            path.baseCamps[idx].y = path.baseCamps[idx].y*height
        //        }
    }
    
}