//
//  Utils.swift
//  Everest Challenge
//
//  Created by Rosalyn Kingsmill on 2016-06-17.
//  Copyright © 2016 Rosalyn Kingsmill. All rights reserved.
//

import UIKit

class Utils {
    
    static let actualMountainHeight : Double = 8848
    //need to change if top or bottom points change
    static func flightsOfStairsToMeters(flights: Double) -> Double {
        return flights*4.7
    }
    
    static func convertDistanceClimbedToScreenClimbed(totalScreenMountainHeight: Double, currentHeight: Double) -> Double {
        
        return totalScreenMountainHeight * (currentHeight / actualMountainHeight)
    }
    
    static func getScreenCoordinatesForRelativeCoordinates(relativePoint:CGPoint, size:CGSize) ->CGPoint {
       
        let width = size.width
        let height = size.height
        
        let realX = relativePoint.x*width
        let realY = relativePoint.y*height
        return CGPoint(x:realX, y:realY)
        
    }
    
}