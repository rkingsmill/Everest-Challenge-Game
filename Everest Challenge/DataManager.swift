//
//  DataManager.swift
//  MountEverest
//
//  Created by steve on 2016-06-15.
//  Copyright © 2016 YasminA. All rights reserved.
//

import Foundation

class DataManager: NSObject {
    
    var defaults = UserDefaults.standard
    
    let floorTracker:FloorTracker
    
    override init() {
        self.floorTracker = FloorTracker()
    }
    
    func saveUserDefaults() {
        self.defaults.setValue(Date(), forKey: "LastDate")
        self.defaults.setValue(self.floorTracker.currentHeight, forKey: "Height")
        print("current height before saving", self.floorTracker.currentHeight)
    }
    
    func fetchDefaults() {
        let lastLogoutDate = defaults.value(forKey: "LastDate") as? Date ?? Date()
        let lastSavedHeight = self.defaults.value(forKey: "Height") as? Double ?? 0.0
        print("last logout", lastLogoutDate)
        print("last saved", lastSavedHeight)
        self.floorTracker.lastLoginDate = lastLogoutDate
        self.floorTracker.lastSavedHeight = lastSavedHeight
    }
    
    func getStartDate() {
        guard let startDate = self.defaults.object(forKey: "StartDate") else {
            print("initial startdate set")
            self.defaults.set(Date(), forKey: "StartDate")
            return
        }
        print("start Date already set as:", startDate)
    }

    func restartGame() {
        self.defaults.setValue(NSNumber(value: 0.0 as Float), forKey: "Height")
        self.floorTracker.currentHeight = 0
        self.resetStartDate()
    }
    
    func resetStartDate() {
        self.defaults.setValue(Date(), forKey: "StartDate")
    }
    
}
