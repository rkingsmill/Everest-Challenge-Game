//
//  AltitudeTracker.swift
//  Altitude
//
//  Created by Rosalyn Kingsmill on 2016-06-13.
//  Copyright © 2016 Rosalyn Kingsmill. All rights reserved.
//

import Foundation
import CoreMotion

class FloorTracker: NSObject {
    //mountain height is in flights
    let mountainHeightInFlights = 8848/4.7
    let pedometer = CMPedometer()
    var currentHeight = 0.0 {
        didSet {
            if currentHeight >= mountainHeightInFlights {
                // fix this
                pedometer.stopPedometerUpdates()
                NSNotificationCenter.defaultCenter().postNotificationName("GameDidFinishNotification", object: nil)
            } else {
                NSNotificationCenter.defaultCenter().postNotificationName("PedometerDidUpdateNotification", object: nil)
            }
        }
    }
    
    var lastLoginDate: NSDate?
    
    //comment out self.pedometerDidUpdate and add startFakePedometerUpdate for demo
    
    var lastSavedHeight: Double? {
        didSet {
            //self.pedometerDidUpdate()
            self.startFakePedometerUpdate()
        }
    }
    
    func pedometerDidUpdate() {
        pedometer.startPedometerUpdatesFromDate(lastLoginDate!) { (data: CMPedometerData?, error: NSError?) in
            
            guard CMPedometer.isFloorCountingAvailable() else {
                print("No Floor counting, sorry")
                return
            }
            guard error == nil else {
                print("error", error?.localizedDescription)
                return
            }
            guard let data = data else {
                print("No data")
                return
            }
            let floorsAscended = Double(data.floorsAscended!)
            self.currentHeight = floorsAscended + self.lastSavedHeight!
            print("current height", self.currentHeight)
        }
    }
    
    //simulated data for demo
    
    func startFakePedometerUpdate(){
        self.update()
        NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: #selector(FloorTracker.update), userInfo: nil, repeats: true)
    }
    
    @objc private func update(){
        self.currentHeight = self.currentHeight + 1.0
    }
}