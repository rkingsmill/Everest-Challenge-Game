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
    let pedometerData = CMPedometerData()
    var currentHeight = 0.0 {
        didSet {
            if currentHeight >= mountainHeightInFlights {
                // fix this
                pedometer.stopUpdates()
                NotificationCenter.default.post(name: Notification.Name(rawValue: "GameDidFinishNotification"), object: nil)
            } else {
                NotificationCenter.default.post(name: Notification.Name(rawValue: "PedometerDidUpdateNotification"), object: nil)
            }
        }
    }
    
    var lastLoginDate: Date?
    
    //comment out self.pedometerDidUpdate and add startFakePedometerUpdate for demo
    
    var lastSavedHeight: Double? {
        didSet {
            //self.pedometerDidUpdate()
            self.startFakePedometerUpdate()
        }
    }
    
    func pedometerDidUpdate() {
        /* pedometer.startUpdates(from: lastLoginDate!) { (data: CMPedometerData?, error: NSError?) in
            
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
           
        } as! CMPedometerHandler as! CMPedometerHandler as! CMPedometerHandler as! CMPedometerHandler as! CMPedometerHandler as! CMPedometerHandler as! CMPedometerHandler as! CMPedometerHandler as! CMPedometerHandler as! CMPedometerHandler as! CMPedometerHandler as! CMPedometerHandler
 */
    }
    
    //simulated data for demo
    
    func startFakePedometerUpdate(){
        self.update()
      //  NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: #selector(FloorTracker.update), userInfo: nil, repeats: true)
    }
    
    @objc fileprivate func update(){
        self.currentHeight = self.currentHeight + 1.0
    }
}
