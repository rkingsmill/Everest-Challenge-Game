//
//  Path.swift
//  MountEverest
//
//  Created by Rosalyn Kingsmill on 2016-06-16.
//  Copyright © 2016 YasminA. All rights reserved.
//

import UIKit

class Path {
    
    var baseCamps = [BaseCamp]()
    private var totalDistanceForScreenSize : Double?
    let frameSize: CGSize
    
    var currentBaseCamp:Int = 0 {
        didSet {
            print("current basecamp was set \(currentBaseCamp)")
            // do something here to notify the viewcontroller that you need to move to the appropriate base camp
            NSNotificationCenter.defaultCenter().postNotificationName("MoveToCampNotification", object: nil, userInfo: ["indexOfCurrentCamp": currentBaseCamp ])
        }
    }
    
    init(frameSize:CGSize){
        self.frameSize = frameSize
        let baseCamp0 = BaseCamp(x: 0.03, y: 1 - 0.729)
        let baseCamp1 = BaseCamp(x: 0.25, y: 1 - 0.55)
        let baseCamp2 = BaseCamp(x: 0.413, y: 1 - 0.403)
        //        let baseCamp2 = BaseCamp(x: 0.438, y: 1 - 0.375)
        let baseCamp3 = BaseCamp(x: 0.493, y: 1 - 0.328)
        let baseCamp4 = BaseCamp(x: 0.542, y: 1 - 0.278)
        let baseCamp5 = BaseCamp(x: 0.598, y: 1 - 0.219)
        
        baseCamps += [baseCamp0, baseCamp1, baseCamp2, baseCamp3, baseCamp4, baseCamp5]
        self.getTotalDistanceOfBaseCamps()
    }
    
    var nextCampHeight: Float?
    
    func currentCampForHeight(currentHeight:Double) {
        
        var total:Double = 0.0
        
//        let currentDistanceAsScreenHeight = Utils.convertDistanceClimbedToScreenClimbed(totalDistanceForScreenSize!, currentHeight: currentHeight)
//        print("currentDistanceAsScreenHeight:", currentDistanceAsScreenHeight)
        
        for i in 1..<baseCamps.count {
            // compare currentHeight to current camp distance from base
            let previousCamp = baseCamps[i-1]
            total += baseCamps[i].calculateDistanceWithPreviousCamp(previousCamp, frameSize:self.frameSize)
            
            // if currentHeight is less than the camp[i]'s distance from base, then stay at the previous camp
            if currentHeight < total {
                self.currentBaseCamp = i-1
                break
            }
            //if not move to next camp
            self.currentBaseCamp = i
        }
    }
    
    private func getTotalDistanceOfBaseCamps() {
        var total:Double = 0.0
        for i in 1..<baseCamps.count {
            let previousCamp = baseCamps[i-1]
            total += baseCamps[i].calculateDistanceWithPreviousCamp(previousCamp, frameSize:self.frameSize)
        }
        totalDistanceForScreenSize = total
    }
    
//    func pathUpTheMountain()->CGMutablePath {
//        
//  
//    
//        return path
//    }
//    
}
