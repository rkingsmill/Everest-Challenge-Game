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
//        self.getDistance()
       // self.checkCurrentBaseCamp(dataManager.floorTracker.currentHeight)
    }
    
    var scene: GameScene?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set current camp based on current height
        
        // next base camp height
       
        if let scene = GameScene(fileNamed:"GameScene") {
            // Configure the view.
            self.scene = scene
            let skView = self.view as! SKView
            skView.showsFPS = true
            skView.showsNodeCount = true
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .AspectFill
            
            skView.presentScene(scene)
        }
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(GameViewController.tapped))
        view.addGestureRecognizer(tapGestureRecognizer)
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
        
        if dataManager.currentBaseCamp!.distance >= dataManager.floorTracker.currentHeight.floatValue {
            reachNextBaseCamp = true
            GameScene().isReadyToPress = reachNextBaseCamp
            //do animation with sprite
            //need to call this after they press and move the sprite self.resetCurrentBaseCamp()
        }
    }

    @objc func tapped(sender: UITapGestureRecognizer){
//        if isReadyToPress == true {
//            
//            self.createPath()
//            //make paths for each current base camp
//            let followLine = SKAction.followPath(route, asOffset: false, orientToPath: false, duration: 10.0)
//            sprite!.runAction(SKAction.sequence([followLine]))
//            
//            //reset current base camp and save in NSDefaults
//            dataManager.resetCurrentBaseCamp()
//            print("tapped")
//        }
    }
    
    func getPaths() {
        
        
    }
    
    
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
    
 }
