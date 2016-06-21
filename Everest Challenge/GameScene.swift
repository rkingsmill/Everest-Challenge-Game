//
//  GameScene.swift
//  MountEverest
//
//  Created by Yasmin Ahmad on 2016-06-13.
//  Copyright (c) 2016 YasminA. All rights reserved.
//

import SpriteKit
import ScoreboardLabel
import UIKit

class GameScene: SKScene, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var sprite: SKSpriteNode?
    var sunSprite: SKSpriteNode?
    var flagSprite: SKSpriteNode?
    var playerScore: ScoreSpriteNode!
    var scoreLabels: [SKLabelNode] = [SKLabelNode]()
    var label: ScoreboardLabel!
    var face: SKSpriteNode?
    var path: Path!
    let start = CGPoint(x: 30.72, y: 208.1)
    let baseCamp1 = CGPoint(x: 256, y: 345.6)
    let baseCamp2 = CGPoint(x: 422.9, y: 458.5)
    let baseCamp3 = CGPoint(x: 504.8, y: 516.1)
    let baseCamp4 = CGPoint(x: 555, y: 554.4)
    let summit = CGPoint(x: 612.4, y: 600)
    //pop-up stuff
    var popUp: PopUp!

    
    var defaultss:NSUserDefaults = NSUserDefaults.standardUserDefaults()
    var maskingCameraRollChoice:Bool = true
    var maskOffSet:CGPoint = CGPointZero
    
    var button: SKNode! = nil
    
    var moving = false
    
    override func didMoveToView(view: SKView) {
        self.popUp.hidden = true
        
        let background = SKSpriteNode(imageNamed: "Mount-Everest Compressed")
        background.zPosition = 1
        background.position = CGPoint(x:CGRectGetMidX(frame), y:CGRectGetMidY(frame))
        addChild(background)
        
        button = SKSpriteNode(imageNamed: "Button")
        // Put it in the center of the scene
        button.position = CGPoint(x:900, y:100);
        button.zPosition = 4
        self.addChild(button)
        
        scene!.scaleMode = SKSceneScaleMode.AspectFit;
        scene?.anchorPoint = CGPointZero
        
        //CURRENT SCORE BOARD
        playerScore = ScoreSpriteNode()
        playerScore.position = CGPointMake(220,640)
        playerScore!.zPosition = 2
        addChild(playerScore)
        
        
        let font = UIFont(name: "LCD Solid", size: 12)
        let image = UIImage(named: "WhiteBackground.png")
        let color = UIColor.blackColor()
       
        label = ScoreboardLabel(backgroundImage: image! ,text:" ", flipToText: " ", font:font!, textColor:color)
        label.interval = Double(0.2) //each letter flip time
        label.completionHandler = { (finished:Bool) in
            if finished == true {
                //label as finished animating
         
        let labelDistance = ScoreboardLabel(backgroundImage: image! ,text:" ", flipToText: "1,000", font:font!, textColor:color)
                labelDistance.center = CGPoint(x: 265, y: 18)
                view.addSubview(labelDistance)
                labelDistance.flip(true)
                labelDistance.stopFlipping()
                
                
        let labelCamp = ScoreboardLabel(backgroundImage: image! ,text:" ", flipToText: "2,000", font:font!, textColor:color)
                labelCamp.center = CGPoint(x: 197, y: 36)
                view.addSubview(labelCamp)
                labelCamp.flip(true)
                labelCamp.stopFlipping()
                
        let labelSteps = ScoreboardLabel(backgroundImage: image! ,text:" ", flipToText: "3,000", font:font!, textColor:color)
                labelSteps.center = CGPoint(x: 212, y: 54)
                view.addSubview(labelSteps)
                labelSteps.flip(true)
                labelSteps.stopFlipping()
                
                
        let labelCalories = ScoreboardLabel(backgroundImage: image! ,text:" ", flipToText: "4,000", font:font!, textColor:color)
                labelCalories.center = CGPoint(x: 190, y: 74)
                view.addSubview(labelCalories)
                labelCalories.flip(true)
                labelCalories.stopFlipping()
                
        let labelStart = ScoreboardLabel(backgroundImage: image! ,text:" ", flipToText: "JUNE 21", font:font!, textColor:color)
                labelStart.center = CGPoint(x: 217, y: 95)
                view.addSubview(labelStart)
                labelStart.flip(true)
                //labelStart.stopFlipping()
            }
            
        }
        
        
        
        
        label.center = CGPoint(x: 0, y: 0)
        //view.addSubview(label)
        label.flip(true)
        label.stopFlipping()
        
        sprite = PlayerSpriteNode()
        sprite!.xScale = 2
        sprite!.yScale = 2
        sprite!.zPosition = 3
        print("frame on the GameScene \(frame)")
        sprite!.position = CGPointMake(frame.width/2, frame.height/2)
        self.addChild(sprite!)
      
        //add image face
        let cropNode:SKCropNode = SKCropNode()
        let actualMask: SKShapeNode = SKShapeNode(circleOfRadius: 50)
        actualMask.fillColor = UIColor.clearColor()
        cropNode.maskNode = actualMask
        cropNode.zPosition = 4
        cropNode.position = CGPoint(x:0, y:10)
        sprite?.addChild(cropNode)
        
        //make shape oval
        face = SKSpriteNode(color: UIColor .clearColor(), size: CGSize(width: 100, height: 100))
        face!.zPosition = 4
        
        self.moveStartToFirstBaseCamp(start, firstBaseCamp: baseCamp1)

        
        sunSprite = SunSpriteNode()
        sunSprite!.xScale = 1.25
        sunSprite!.yScale = 1.25
        sunSprite!.zPosition = 3
        sunSprite!.position = CGPointMake(902, 680)
        self.addChild(sunSprite!)
        
        flagSprite = FlagSpriteNode()
        flagSprite!.xScale = 1
        flagSprite!.yScale = 1
        flagSprite!.zPosition = 3
        flagSprite!.position = CGPointMake(660, 670)
        self.addChild(flagSprite!)
        
        
        //face!.position = CGPoint(x:0, y:10)
        
        //position and lock to sprite. 
        cropNode.addChild(self.face!)

        if (face != nil) {
            if (maskingCameraRollChoice == true) {
                revealMaskedCameraRollImage()
            }
        }
        
        //add stuff to popup view
         
    }
    
    func moveStartToFirstBaseCamp(start: CGPoint, firstBaseCamp: CGPoint) -> Void {
        moving = true
        
        let path = CGPathCreateMutable()
        CGPathMoveToPoint(path, nil, start.x, start.y)
        CGPathAddLineToPoint(path, nil, firstBaseCamp.x, firstBaseCamp.y)
        let destination = SKAction.followPath(path, asOffset: false, orientToPath: false, duration: 3.0)
        //        let reverseSecondBaseCamp = secondBaseCamp.reversedAction()
        self.sprite!.runAction(SKAction.sequence([destination]))
        {
            self.moving = false
            self.popUp.customizeTitle("First Base Camp")
            self.popUp.customizeFact("CONGRATS on reaching your first Base Camp! Did you know... Mount Everest was first climbed in 1953. The temperature at the summit never rises above freezing, averaging -36˚C in winter and -19˚C in summer. Brrrr.")
            self.popUp.customizeButton("Keep Climbing")
            self.popUp.hidden = false

            //show some pop up
            
//            let alert = UIAlertController(title: "First Base Camp", message: "Congrats on reaching your first Base Camp! Did you know... Mount Everest was first climbed in 1953. The temperature at the summit never rises above freezing, averaging -36˚C in winter and -19˚C in summer. Brrrr.", preferredStyle: UIAlertControllerStyle.Alert)
//        
//            alert.addAction(UIAlertAction(title: "Keep Climbing", style: UIAlertActionStyle.Default, handler: {
//                _ in
//                self.moveFirstToSecondBaseCamp(self.baseCamp1, secondBaseCamp: self.baseCamp2)
//            }))
//            self.view?.window?.rootViewController?.presentViewController(alert, animated: true, completion: nil)
//            
        }
        
    }
    
    func moveFirstToSecondBaseCamp(firstBaseCamp: CGPoint, secondBaseCamp: CGPoint) -> Void {
        moving = true
        let path = CGPathCreateMutable()
        CGPathMoveToPoint(path, nil, firstBaseCamp.x, firstBaseCamp.y)
        CGPathAddLineToPoint(path, nil, secondBaseCamp.x, secondBaseCamp.y)
        let destination = SKAction.followPath(path, asOffset: false, orientToPath: false, duration: 3.0)
        //        let reverseSecondBaseCamp = secondBaseCamp.reversedAction()
        self.sprite!.runAction(SKAction.sequence([destination]))
        {
            self.moving = false
            self.popUp.customizeTitle("Second Base Camp")
            self.popUp.customizeFact("CONGRATS on reaching your second Base Camp. Some motivation: The youngest person to climb Everest is American teenager Jordan Romero, who was 13 years old when he reached the summit on 22 May, 2010.")
            self.popUp.customizeButton("Keep Climbing")
            self.popUp.hidden = false
            
            //Perhaps show some pop up
            //            let alert = UIAlertController(title: "Second Base Camp", message: "Congrats on reaching your second Base Camp. Some motivation: The youngest person to climb Everest is American teenager Jordan Romero, who was 13 years old when he reached the summit on 22 May 2010.", preferredStyle: UIAlertControllerStyle.Alert)
            //            alert.addAction(UIAlertAction(title: "Keep Climbing", style: UIAlertActionStyle.Default, handler: {
            //                _ in
            //
            //                self.moveSecondToThirdBaseCamp(self.baseCamp2, thirdBaseCamp: self.baseCamp3)
            //            }))
            //            self.view?.window?.rootViewController?.presentViewController(alert, animated: true, completion: nil)
            
        }
    }
    
    func moveSecondToThirdBaseCamp(secondBaseCamp: CGPoint, thirdBaseCamp: CGPoint) -> Void {
        moving = true
        let path = CGPathCreateMutable()
        CGPathMoveToPoint(path, nil, secondBaseCamp.x, secondBaseCamp.y)
        CGPathAddLineToPoint(path, nil, thirdBaseCamp.x, thirdBaseCamp.y)
        let destination = SKAction.followPath(path, asOffset: false, orientToPath: false, duration: 2.0)
        //        let reverseSecondBaseCamp = secondBaseCamp.reversedAction()
        self.sprite!.runAction(SKAction.sequence([destination]))
        {
            self.moving = false
            self.popUp.customizeTitle("Third Base Camp")
            self.popUp.customizeFact("GETTING CLOSER! Some more motivation for you: The oldest person to reach the summit of Everest is Miura Yiuchiro from Japan, who climbed the mountain at the age of 80 on 23 May, 2013.")
            self.popUp.customizeButton("Onwards and Upwards")
            self.popUp.hidden = false
            //Perhaps show some pop up
//            let alert = UIAlertController(title: "Third Base Camp", message: "Getting closer! Some more motivation for you: The oldest person to reach the summit of Everest is Miura Yiuchiro from Japan, who climbed the mountain at the age of 80 on 23 May  2013.", preferredStyle: UIAlertControllerStyle.Alert)
//            alert.addAction(UIAlertAction(title: "Onwards and Upwards", style: UIAlertActionStyle.Default, handler: {
//                _ in
//
//            self.moveThirdToFourthBaseCamp(self.baseCamp3, fourthBaseCamp: self.baseCamp4)
//            }))
//            self.view?.window?.rootViewController?.presentViewController(alert, animated: true, completion: nil)
//    
        }
    }
    
    func moveThirdToFourthBaseCamp(thirdBaseCamp: CGPoint, fourthBaseCamp: CGPoint) -> Void {
        moving = true
        let path = CGPathCreateMutable()
        CGPathMoveToPoint(path, nil, thirdBaseCamp.x, thirdBaseCamp.y)
        CGPathAddLineToPoint(path, nil, fourthBaseCamp.x, fourthBaseCamp.y)
        let destination = SKAction.followPath(path, asOffset: false, orientToPath: false, duration: 2.0)
        //        let reverseSecondBaseCamp = secondBaseCamp.reversedAction()
        self.sprite!.runAction(SKAction.sequence([destination]))
        {
             self.moving = false
            self.popUp.customizeTitle("Fourth Base Camp")
            self.popUp.customizeFact("ALMOST THERE! Did you know... Anything above 8,000 metres is known as the Death Zone. Climbers suffer altitude sickness and headaches and risk life-threatening oedemas due to the thin, dry air.")
            self.popUp.customizeButton("Keep Climbing")
             self.popUp.hidden = false
            //Perhaps show some pop up
//            let alert = UIAlertController(title: "Fourth Base Camp", message: "Amost there! Did you know... Anything above 8,000 metres is known as the Death Zone. Climbers suffer altitude sickness and headaches and risk life-threatening oedemas due to the thin, dry air.", preferredStyle: UIAlertControllerStyle.Alert)
//            alert.addAction(UIAlertAction(title: "Keep Climbing", style: UIAlertActionStyle.Default, handler: {
//                _ in
//
//            self.moveFourthBaseCampToSummit(self.baseCamp4, summit: self.summit)
//            }))
//            self.view?.window?.rootViewController?.presentViewController(alert, animated: true, completion: nil)
           
        }
    }
    
    func moveFourthBaseCampToSummit(fourthBaseCamp: CGPoint, summit: CGPoint) -> Void {
        moving = true
        let path = CGPathCreateMutable()
        CGPathMoveToPoint(path, nil, fourthBaseCamp.x, fourthBaseCamp.y)
        CGPathAddLineToPoint(path, nil, summit.x, summit.y)
        let destination = SKAction.followPath(path, asOffset: false, orientToPath: false, duration: 2.0)
        //        let reverseSecondBaseCamp = secondBaseCamp.reversedAction()
        self.sprite!.runAction(SKAction.sequence([destination]))
        {
            self.moving = false
            self.popUp.customizeTitle("The Summit")
            self.popUp.customizeFact("CONGRATULATIONS... You have reached the summit of Mount Everest - the tallest mountain in the world of 8,848 metres high. That’s the height at which passenger aeroplanes fly at!")
            self.popUp.customizeButton("Enjoy the view")
             self.popUp.hidden = false
            //Perhaps show some pop up
//            let alert = UIAlertController(title: "The Summit", message: "Congratulations... You have reached the summit of Mount Everest - the tallest mountain in the world of 8,848 metres high. That’s the height at which passenger aeroplanes fly at!", preferredStyle: UIAlertControllerStyle.Alert)
//            alert.addAction(UIAlertAction(title: "Ready to Slide Home", style: UIAlertActionStyle.Default, handler: {
//                _ in
//
//            self.returnToStart(self.summit, start: self.start)
//            }))
//            self.view?.window?.rootViewController?.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    func returnToStart(summit: CGPoint, start: CGPoint) -> Void {
        
        let path = CGPathCreateMutable()
        CGPathMoveToPoint(path, nil, self.summit.x, self.summit.y)
        CGPathAddLineToPoint(path, nil, self.start.x, self.start.y)
        let destination = SKAction.followPath(path, asOffset: false, orientToPath: false, duration: 5.0)
        self.sprite!.runAction(SKAction.sequence([destination]))
        {
            self.moving = false
             self.popUp.hidden = false
            self.popUp.customizeTitle("Home at Last")
            self.popUp.customizeFact("Did you know... People have skied and snowboarded down Everest!")
            self.popUp.customizeButton("Done")
            //Perhaps show some pop up
//            let alert = UIAlertController(title: "Home at Last", message: "Did you know... People have skied and snowboarded down Everest!", preferredStyle: UIAlertControllerStyle.Alert)
//            alert.addAction(UIAlertAction(title: "Done", style: UIAlertActionStyle.Default, handler: {
//                _ in
//              
//            }))
//            self.view?.window?.rootViewController?.presentViewController(alert, animated: true, completion: nil)

        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        for touch in touches {
            
            let location = touch.locationInNode(self)
            
            if sprite!.containsPoint(location) {
                getPhotoFromSource(UIImagePickerControllerSourceType.Camera)
            }
            
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        // Loop over all the touches in this event
        for touch: AnyObject in touches {
            // Get the location of the touch in this scene
            let location = touch.locationInNode(self)
            // Check if the location of the touch is within the button's bounds
            if button.containsPoint(location) {
                self.moveStartToFirstBaseCamp(start, firstBaseCamp: baseCamp1)
                //fade button off screen
                let fadeAway = SKAction.fadeOutWithDuration(1)
                self.button.runAction(SKAction.sequence([fadeAway]))
          
            }
        }
    }

    func addTentImages(){
        
        let startingSign = SKSpriteNode(imageNamed: "start")
        startingSign.xScale = 0.3
        startingSign.yScale = 0.3
        startingSign.zPosition = 2
        let xValue = path.baseCamps[0].x
        let yValue = path.baseCamps[0].y
        let point = CGPoint(x: xValue, y: yValue)
        let position = Utils().getScreenCoordinatesForRelativeCoordinates(point, size: path.frameSize)
        startingSign.position = position
        addChild(startingSign)
        
        for idx in 1..<path!.baseCamps.count {
            //let tent = SKSpriteNode(imageNamed: "Tent.png")
            let markerSprite = MarkerSpriteNode()
            markerSprite.xScale = 0.3
            markerSprite.yScale = 0.3
            markerSprite.zPosition = 2
            //TODO convert to new distances
            let xValue = path.baseCamps[idx].x
            let yValue = path.baseCamps[idx].y
            let point = CGPoint(x: xValue, y: yValue)
            let position = Utils().getScreenCoordinatesForRelativeCoordinates(point, size: path.frameSize)
            markerSprite.position = position
            addChild(markerSprite)
        }
    }
    
    func moveGirlToNextCampAtPoint(point: CGPoint){
        sprite?.position = point

        //        CGPathMoveToPoint(route, nil, dataManager.currentBaseCamp.x, dataManager.currentBaseCamp.y)
        //        CGPathAddLineToPoint(route, nil, dataManager.[idx].x, path.baseCamps[idx].y)
        //        CGPathMoveToPoint(route, nil, path.baseCamps[0].x, path.baseCamps[0].y)

    }
    

    //get data from y position for labels
    override func update(currentTime: NSTimeInterval) {
        if (moving) {
            // get label text
            print("we are at: ", self.sprite?.position.y)
            
        }
    }
    

}
