//
//  AppDelegate.swift
//  Everest Challenge
//
//  Created by Rosalyn Kingsmill on 2016-06-16.
//  Copyright © 2016 Rosalyn Kingsmill. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var dataManager:DataManager!
    
    
//    func application(application: UIApplication, supportedInterfaceOrientationsForWindow window: UIWindow?) -> UIInterfaceOrientationMask {
//        if let presentedViewController = window?.rootViewController?.presentedViewController {
//            if (presentedViewController.isKindOfClass(UIImagePickerController) && !presentedViewController.isBeingDismissed() ){
//                
//                return UIInterfaceOrientationMask.Portrait
//            }
//        }
//        
//        return UIInterfaceOrientationMask.LandscapeLeft
//    }
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
                self.dataManager = DataManager()
                self.dataManager.getStartDate()
                let gameViewController = window?.rootViewController as! GameViewController
                gameViewController.dataManager = self.dataManager
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        self.dataManager.saveUserDefaults()
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
         self.dataManager.fetchDefaults()
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

