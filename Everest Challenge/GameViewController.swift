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
    var currentCamp: Int = 0
    var imagePicker: UIImagePickerController!
    @IBOutlet var popup: PopUp!
    
    //    var reachNextBaseCamp = Bool(false)
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        NotificationCenter.default.addObserver(self, selector: #selector(GameViewController.didFinishGame), name: NSNotification.Name(rawValue: "GameDidFinishNotification"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(GameViewController.pedometerDidUpdate), name: NSNotification.Name(rawValue: "PedometerDidUpdateNotification"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(GameViewController.moveToCamp), name: NSNotification.Name(rawValue: "MoveToCampNotification"), object: nil)
    }
    
    @objc func moveToCamp(_ notification:Notification) {
        let info = (notification as NSNotification).userInfo
        
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
    
    @objc fileprivate func didFinishGame() {
        self.showWinningState()
    }
    
    @objc fileprivate func pedometerDidUpdate() {
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
            self.popup.layer.zPosition = 1
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
            scene.scaleMode = .aspectFill
            
            skView.presentScene(scene)
            
        }
        
        //        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(GameViewController.tapped))
        //        view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        let value = UIInterfaceOrientation.LandscapeLeft.rawValue
//        UIDevice.currentDevice().setValue(value, forKey: "orientation")

    }
    
    fileprivate func showWinningState() {
        // show some confetti
        print(#function)
        self.restartGame()
    }
    
    fileprivate func restartGame() {
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
    
    override var shouldAutorotate : Bool {
        return true
    }
    
    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        return .landscapeLeft
    }
    
    override var preferredInterfaceOrientationForPresentation : UIInterfaceOrientation {
        return .landscapeLeft
    }
    override func viewDidLayoutSubviews() {
    }
    override var prefersStatusBarHidden : Bool {
        return true
    }
    //for demo day
    @IBAction func keepMoving(_ sender: AnyObject) {
        if currentCamp == 0 {
            scene!.popUp.isHidden = true
            currentCamp += 1
            scene!.moveFirstToSecondBaseCamp(scene!.baseCamp1, secondBaseCamp: scene!.baseCamp2)
        } else if currentCamp == 1 {
            scene!.popUp.isHidden = true
            currentCamp += 1
            scene!.moveSecondToThirdBaseCamp(scene!.baseCamp2, thirdBaseCamp: scene!.baseCamp3)
        } else if currentCamp == 2 {
            scene!.popUp.isHidden = true
            currentCamp += 1
            scene!.moveThirdToFourthBaseCamp(scene!.baseCamp3, fourthBaseCamp: scene!.baseCamp4)
        } else if currentCamp == 3 {
            scene!.popUp.isHidden = true
            currentCamp += 1
            scene!.moveFourthBaseCampToSummit(scene!.baseCamp4, summit: scene!.summit)
        } else if currentCamp == 4 {
            scene!.popUp.isHidden = true
            currentCamp += 1
            scene!.burstNode!.resetSimulation()
            scene!.burstNode!.removeFromParent()
            scene!.burstNode2!.resetSimulation()
            scene!.burstNode2?.removeFromParent()
            let fadeIn = SKAction.fadeIn(withDuration: 5)
            scene!.startSprite!.run(SKAction.sequence([fadeIn]))
        } else if currentCamp == 5 {
            scene!.popUp.isHidden = true
            let fadeIn = SKAction.fadeIn(withDuration: 5)
            scene!.startSprite!.run(SKAction.sequence([fadeIn]))
            currentCamp = 0
        }
    }
    //remove observers when view controller doesnt exist. good practise
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
   
    
  }
