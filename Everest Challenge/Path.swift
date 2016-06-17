//
//  Path.swift
//  MountEverest
//
//  Created by Rosalyn Kingsmill on 2016-06-16.
//  Copyright © 2016 YasminA. All rights reserved.
//

import Foundation

class Path {
    
    var baseCamps = [BaseCamp]()
    
    init(){
        let baseCamp0 = BaseCamp(x: 0.0033, y: 1 - 0.729)
        let baseCamp1 = BaseCamp(x: 0.413, y: 1 - 0.403)
        let baseCamp2 = BaseCamp(x: 0.438, y: 1 - 0.375)
        let baseCamp3 = BaseCamp(x: 0.493, y: 1 - 0.328)
        let baseCamp4 = BaseCamp(x: 0.542, y: 1 - 0.278)
        let baseCamp5 = BaseCamp(x: 0.598, y: 1 - 0.219)
        
        baseCamps += [baseCamp0, baseCamp1, baseCamp2, baseCamp3, baseCamp4, baseCamp5]
    }
    
    var nextCampHeight: Float?
    
    func currentCampForHeight(height:Float) -> Int {
        for i in 0..<baseCamps.count {
            let camp = self.baseCamps[i]
            
            if camp.getDistance() < 
            
            
        }
        
    }
    
   
    
}
