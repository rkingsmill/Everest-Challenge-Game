//
//  DataManager.swift
//  MountEverest
//
//  Created by steve on 2016-06-15.
//  Copyright © 2016 YasminA. All rights reserved.
//

import Foundation

class DataManager: NSObject {
    
    var defaults = NSUserDefaults.standardUserDefaults()
//    var currentBaseCamp = BaseCamp?()
    
    let floorTracker:FloorTracker
    
    override init() {
        self.floorTracker = FloorTracker()
    }
    
    func saveUserDefaults() {
        self.defaults.setValue(NSDate(), forKey: "LastDate")
        self.defaults.setValue(self.floorTracker.currentHeight, forKey: "Height")
        print("current height before saving", self.floorTracker.currentHeight)
//        self.saveCurrentCampUserDefaults()
    }
    
//    func saveCurrentCampUserDefaults() {
//        self.defaults.setObject(self.currentBaseCamp, forKey: "CurrentCamp")
//    }
    
    func fetchDefaults() {
        let lastLogoutDate = defaults.valueForKey("LastDate") as? NSDate ?? NSDate()
        let lastSavedHeight = self.defaults.valueForKey("Height") as? NSNumber ?? NSNumber(float:0.0)
//        let lastSavedCamp = self.defaults.objectForKey("CurrentCamp") as! BaseCamp
        print("last logout", lastLogoutDate)
        print("last saved", lastSavedHeight)
        self.floorTracker.lastLoginDate = lastLogoutDate
        self.floorTracker.lastSavedHeight = Float(lastSavedHeight)
//        self.currentBaseCamp = lastSavedCamp
    }
    
    func getStartDate() {
        guard let startDate = self.defaults.objectForKey("StartDate") else {
            print("initial startdate set")
            self.defaults.setObject(NSDate(), forKey: "StartDate")
//            self.currentBaseCamp = BaseCamp(x: 0.0033, y: 1 - 0.729)
//            self.defaults.setObject(self.currentBaseCamp, forKey: "CurrentCamp")
            return
        }
        print("start Date already set as:", startDate)
    }

    func restartGame() {
        self.defaults.setValue(NSNumber(float:0.0), forKey: "Height")
        self.floorTracker.currentHeight = 0
        self.resetStartDate()
    }
    
    func resetStartDate() {
        self.defaults.setValue(NSDate(), forKey: "StartDate")
    }
    
//    func resetCurrentBaseCamp() {
//        
//        for idx in 0...(path.baseCamps.count - 1) {
//            if dataManager.currentBaseCamp!.x == path.baseCamps[idx].x {
//                dataManager.currentBaseCamp = path.baseCamps[idx + 1]
//            }
//        }
//    }
    
}
