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
    var path:Path?
    var scene: GameScene?
    var size: CGSize?
    var imagePicker: UIImagePickerController!
    @IBOutlet var popup: PopUp!
    
    //    var reachNextBaseCamp = Bool(false)
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(GameViewController.didFinishGame), name: "GameDidFinishNotification", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(GameViewController.pedometerDidUpdate), name: "PedometerDidUpdateNotification", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(GameViewController.moveToCamp), name: "MoveToCampNotification", object: nil)
    }
    
    @objc func moveToCamp(notification:NSNotification) {
        let info = notification.userInfo
        
        let indexPathOfCurrentCamp = info!["indexOfCurrentCamp"] as! Int
        print("==>> change to current camp \(indexPathOfCurrentCamp)")
        print(indexPathOfCurrentCamp)
        guard let scene = self.scene else {
            print("Cant move the sprite")
            return
        }
        let camp = self.path!.baseCamps[indexPathOfCurrentCamp]
        guard let size = self.size else {
            print("Size:", self.size)
            return
        }
        let point = Utils().getScreenCoordinatesForRelativeCoordinates(camp.campAsRelativePoint, size: size)
        scene.moveGirlToNextCampAtPoint(point)
    }
    
    @objc private func didFinishGame() {
        self.showWinningState()
    }
    
    @objc private func pedometerDidUpdate() {
        print("current height", dataManager.floorTracker.currentHeight)
        path?.currentCampForHeight(self.dataManager.floorTracker.currentHeight)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        self.size = CGSize(width: self.view.frame.size.width, height: self.view.frame.size.height)
     
        
        // set current camp based on current height
        
        // next base camp height
        
        if let scene = GameScene(fileNamed:"GameScene") {
            // Configure the view.
            self.scene = scene
            self.popup.setupPopUp()

            scene.popUp = popup
            
            self.size = self.scene?.size
            guard let size = self.size else {
                return
            }
            self.path = Path(frameSize:size)
            print("Frame size", self.scene!.size)
            self.scene?.path = path
            self.scene!.addTentImages()
            
            let skView = self.view as! SKView
            skView.showsFPS = true
            skView.showsNodeCount = true
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .AspectFill
            
            skView.presentScene(scene)
            
        }
        
        //        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(GameViewController.tapped))
        //        view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    override func viewDidAppear(animated: Bool) {
//        let value = UIInterfaceOrientation.LandscapeLeft.rawValue
//        UIDevice.currentDevice().setValue(value, forKey: "orientation")

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
    //
    //    func checkMoveToNextBaseCamp() {
    //        self.getDistance()
    //
    //        if dataManager.currentBaseCamp!.distance >= dataManager.floorTracker.currentHeight.floatValue {
    //            reachNextBaseCamp = true
    //            GameScene().isReadyToPress = reachNextBaseCamp
    //            //do animation with sprite
    //            //need to call this after they press and move the sprite self.resetCurrentBaseCamp()
    //        }
    //    }
    
    override func shouldAutorotate() -> Bool {
        return true
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return .LandscapeLeft
    }
    
    override func preferredInterfaceOrientationForPresentation() -> UIInterfaceOrientation {
        return .LandscapeLeft
    }
    override func viewDidLayoutSubviews() {
        print("=====>>>>> view frame definitely set \(self.view.frame)")
    }
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    @IBAction func keepMoving(sender: AnyObject) {
        if CGRectContainsPoint(scene!.sprite!.frame, scene!.baseCamp1) {
            scene!.popUp.hidden = true
            scene!.moveFirstToSecondBaseCamp(scene!.baseCamp1, secondBaseCamp: scene!.baseCamp2)
        }
        if CGRectContainsPoint(scene!.sprite!.frame, scene!.baseCamp2) {
            scene!.popUp.hidden = true
            scene!.moveSecondToThirdBaseCamp(scene!.baseCamp2, thirdBaseCamp: scene!.baseCamp3)
        }
        if CGRectContainsPoint(scene!.sprite!.frame, scene!.baseCamp3) {
            scene!.popUp.hidden = true
            scene!.moveThirdToFourthBaseCamp(scene!.baseCamp3, fourthBaseCamp: scene!.baseCamp4)
        }
        if CGRectContainsPoint(scene!.sprite!.frame, scene!.baseCamp4) {
            scene!.popUp.hidden = true
            scene!.moveFourthBaseCampToSummit(scene!.baseCamp4, summit: scene!.summit)
        }
        if CGRectContainsPoint(scene!.sprite!.frame, scene!.summit) {
            scene!.popUp.hidden = true
            scene!.returnToStart(scene!.summit, start: scene!.start)
        }
        if CGRectContainsPoint(scene!.sprite!.frame, scene!.start) {
            scene!.popUp.hidden = true
            
            let fadeIn = SKAction.fadeInWithDuration(5)
            scene!.button.runAction(SKAction.sequence([fadeIn]))
        }
        
    }
    //remove observers when view controller doesnt exist. good practise
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
  }