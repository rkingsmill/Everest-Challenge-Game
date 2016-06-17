 //
 //  GameViewController.swift
 //  MountEverest
 //
 //  Created by Yasmin Ahmad on 2016-06-13.
 //  Copyright (c) 2016 YasminA. All rights reserved.
 //
 
 import UIKit
 import SpriteKit
 import CoreGraphics
 
 class GameViewController: UIViewController {
    
    var dataManager: DataManager!
    let mountain = Mountain()
    let path = Path()
    
    var reachNextBaseCamp = Bool(false)
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(GameViewController.didFinishGame), name: "GameDidFinishNotification", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(GameViewController.pedometerDidUpdate), name: "PedometerDidUpdateNotification", object: nil)
    }
    
    @objc private func didFinishGame() {
        self.showWinningState()
    }
    
    @objc private func pedometerDidUpdate() {
        print("current height", dataManager.floorTracker.currentHeight)
        self.getDistance()
       // self.checkCurrentBaseCamp(dataManager.floorTracker.currentHeight)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let scene = GameScene(fileNamed:"GameScene") {
            // Configure the view.
            let skView = self.view as! SKView
            skView.showsFPS = true
            skView.showsNodeCount = true
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .AspectFill
            
            skView.presentScene(scene)
        }
        
    }
    
    func viewDidAppear() {
        super.viewDidAppear(true)
        
    }
    
//    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
//        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
//            return .AllButUpsideDown
//        } else {
//            return .All
//        }
//    }
    override func viewDidLayoutSubviews() {
        //print(mountainImageView.
    }
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    //remove observers when view controller doesnt exist. good practise
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    private func showWinningState() {
        // show some confetti
        print(#function)
        self.restartGame()
    }
    
    private func restartGame() {
        // call this after a delay
        dataManager.restartGame()
    }
    
    func checkMoveToNextBaseCamp() {
        self.getDistance()
        //        convert distance
        //        find current index
        self.getCurrentBaseCamp(dataManager.floorTracker.currentHeight)
        //find next index
        
        if dataManager.floorTracker.currentHeight.floatValue <= path.currentCamp!.distance {
            reachNextBaseCamp = true
            //do animation with sprite
        }
    }

    func getCurrentBaseCamp(currentHeight:(NSNumber)) {
        
        if mountain.simulatedMountainHeight.floatValue < path.baseCamps[1].distance {
            path.currentCamp = path.baseCamps[0]
        }
        if mountain.simulatedMountainHeight.floatValue < path.baseCamps[2].distance {
            path.currentCamp = path.baseCamps[1]
        }
        if mountain.simulatedMountainHeight.floatValue < path.baseCamps[3].distance {
            path.currentCamp = path.baseCamps[2]
        }
        if mountain.simulatedMountainHeight.floatValue < path.baseCamps[4].distance {
            path.currentCamp = path.baseCamps[3]
        }
        if mountain.simulatedMountainHeight.floatValue < path.baseCamps[5].distance {
            path.currentCamp = path.baseCamps[4]
        }
        if mountain.simulatedMountainHeight.floatValue < path.baseCamps[5].distance {
            path.currentCamp = path.baseCamps[5]
        }
        else {
            path.currentCamp = path.baseCamps[0]
        }
    }
    
    func getDistance() {
        
        for idx in 0...(path.baseCamps.count - 1) {
            let xDist = CGFloat(path.baseCamps[idx].x - path.baseCamps[0].x)
            let yDist = CGFloat(path.baseCamps[idx].y - path.baseCamps[0].y)
            path.baseCamps[idx].distance = Float(sqrt((xDist * xDist) + (yDist * yDist)))
            //print("BaseCamp Distance (0-5): ", path.baseCamps[idx].distance)
        }
        //let totalDistance = path.baseCamps[5].distance! - path.baseCamps[0].distance!
        //print("Total Distance: ", totalDistance)
    }
    
 }
