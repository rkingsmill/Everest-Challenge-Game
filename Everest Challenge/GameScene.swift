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
    var slidingSprite = SKSpriteNode(imageNamed: "SnowboardSprite")
    var sunSprite: SKSpriteNode?
    var flagSprite: SKSpriteNode?
    var playerScore: ScoreSpriteNode!
    var cloudSprite: SKNode?
    var startSprite: SKSpriteNode?
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
    var time: Int = 0
    //label variables
    var distanceTotal: Int = 0
    var previousDistanceTotal: Int = 0
    
    var distanceToCamp: Int?
    
    var previousPosition: Double = 0
    var totalSteps: Int = 0
    var previousSteps: Int = 0
    
    var remainingSteps: Int = 0
    var previousRemainingSteps: Int = 0
    
    var calories: Int = 0
    var previousCalories: Int = 0
    
    var labelDistance : ScoreboardLabel?
    var labelCamp : ScoreboardLabel?
    var labelCalories : ScoreboardLabel?
    var labelSteps : ScoreboardLabel?
    
    let font = UIFont(name: "LCD Solid", size: 12)
    let image = UIImage(named: "WhiteBackground.png")
    let color = UIColor.blackColor()
    
    var defaultss:NSUserDefaults = NSUserDefaults.standardUserDefaults()
    var maskingCameraRollChoice:Bool = true
    var maskOffSet:CGPoint = CGPointZero
    
    var button: SKNode! = nil
    
    var moving = false
    var background : SKSpriteNode?
    var burstNode : SKEmitterNode?
    var burstNode2 : SKEmitterNode?
    
    override func didMoveToView(view: SKView) {
        self.popUp.hidden = true
        
        self.background = SKSpriteNode(imageNamed: "Mount-Everest Compressed")
        background!.zPosition = 1
        background!.position = CGPoint(x:CGRectGetMidX(frame), y:CGRectGetMidY(frame))
        addChild(background!)
        
        scene!.scaleMode = SKSceneScaleMode.AspectFit;
        scene?.anchorPoint = CGPointZero
        
        //CURRENT SCORE BOARD
        playerScore = ScoreSpriteNode()
        playerScore.position = CGPointMake(220,640)
        playerScore!.zPosition = 2
        addChild(playerScore)

        cloudSprite = CloudBackgroundNode()
        cloudSprite!.xScale = 0.8
        cloudSprite!.yScale = 0.8
        addChild(cloudSprite!)
        
        let font = UIFont(name: "LCD Solid", size: 12)
        let image = UIImage(named: "WhiteBackground.png")
        let color = UIColor.blackColor()
       
        label = ScoreboardLabel(backgroundImage: image! ,text:" ", flipToText: " ", font:font!, textColor:color)
        label.interval = Double(0.2) //each letter flip time
        label.completionHandler = { (finished:Bool) in
            if finished == true {
                //label as finished animating
         
        self.labelDistance = ScoreboardLabel(backgroundImage: self.image!, text:" ", flipToText:"0", font:self.font!, textColor:self.color)
                self.labelDistance!.center = CGPoint(x: 190, y: 18)
                view.addSubview(self.labelDistance!)
                self.labelDistance!.flip(false)
                self.labelDistance!.stopFlipping()
                
        self.labelCamp = ScoreboardLabel(backgroundImage: self.image! ,text:" ", flipToText:"0", font:self.font!, textColor:self.color)
                self.labelCamp!.center = CGPoint(x: 190, y: 36)
                view.addSubview(self.labelCamp!)
                self.labelCamp!.flip(true)
                self.labelCamp!.stopFlipping()
                
        self.labelSteps = ScoreboardLabel(backgroundImage: self.image! ,text:" ", flipToText:"0", font:self.font!, textColor:self.color)
                self.labelSteps!.center = CGPoint(x: 190, y: 54)
                view.addSubview(self.labelSteps!)
                self.labelSteps!.flip(false)
                self.labelSteps!.stopFlipping()
                
        self.labelCalories = ScoreboardLabel(backgroundImage: self.image! ,text:" ", flipToText:"0", font:self.font!, textColor:self.color)
                self.labelCalories!.center = CGPoint(x: 190, y: 74)
                view.addSubview(self.labelCalories!)
                self.labelCalories!.flip(false)
                self.labelCalories!.stopFlipping()
                
        let labelStart = ScoreboardLabel(backgroundImage: self.image! ,text:" ", flipToText: "06/23", font:self.font!, textColor:self.color)
                labelStart.center = CGPoint(x: 190, y: 95)
                view.addSubview(labelStart)
                labelStart.flip(false)
                //labelStart.stopFlipping()
            }
        }
        
        
        label.center = CGPoint(x: 0, y: 0)
        //view.addSubview(label)
        label.flip(true)
        label.stopFlipping()
        
        sprite = PlayerSpriteNode()
        sprite!.xScale = 1.5
        sprite!.yScale = 1.5
        sprite!.zPosition = 3
        print("frame on the GameScene \(frame)")
        //sprite!.position = CGPointMake(frame.width/2, frame.height/2)
        self.addChild(sprite!)
        
        face = SKSpriteNode(imageNamed: "face")
        face!.zPosition = 4
        face!.xScale = 0.3
        face!.yScale = 0.3
        face!.zPosition = 4
        face!.position = CGPoint(x:6, y:35)
        sprite!.addChild(face!)
        //add image face
        let cropNode:SKCropNode = SKCropNode()
    
        let actualMask = SKSpriteNode(color: UIColor.clearColor(), size: CGSize(width: 30, height: 30))
        actualMask.xScale = 1
        actualMask.yScale = 1
        actualMask.zPosition = 4
        actualMask.position = CGPoint(x:0, y:0)
        face!.addChild(actualMask)
        //let actualMask: SKShapeNode = SKShapeNode(circleOfRadius: 15)
        //actualMask.fillColor = UIColor.whiteColor()
        cropNode.maskNode = actualMask
        cropNode.zPosition = 4
        cropNode.position = CGPoint(x:0, y:0)
        //actualMask.addChild(cropNode)
        
        //make shape oval
     
        //face!.position = CGPoint(x:0, y:10)
        
        //position and lock to sprite. 
        //cropNode.addChild(self.face!)

        if (face != nil) {
            if (maskingCameraRollChoice == true) {
                revealMaskedCameraRollImage()
            }
        }
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
        
        startSprite = StartSpriteNode()
        startSprite?.position = CGPointMake(900, 100)
        startSprite?.zPosition = 99
        //button = startSprite
        self.addChild(startSprite!)
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
            self.performSelector(#selector(self.showPopUp), withObject: nil, afterDelay: 1)
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
            self.performSelector(#selector(self.showPopUp), withObject: nil, afterDelay: 1)
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
            self.performSelector(#selector(self.showPopUp), withObject: nil, afterDelay: 1)
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
             self.performSelector(#selector(self.showPopUp), withObject: nil, afterDelay: 1)
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
            self.performSelector(#selector(self.showPopUp), withObject: nil, afterDelay: 2)
            
            //baby im a firework
            let burstPath = NSBundle.mainBundle().pathForResource("Spark",
                                                                  ofType: "sks")
            self.burstNode = NSKeyedUnarchiver.unarchiveObjectWithFile(burstPath!)
                as? SKEmitterNode
            self.burstNode!.position = CGPointMake(200, 400)
            self.burstNode!.zPosition = 6
            self.burstNode!.name = "firework"
            self.burstNode!.targetNode = self.scene
            self.background!.addChild(self.burstNode!)
            
            self.burstNode2 = NSKeyedUnarchiver.unarchiveObjectWithFile(burstPath!)
                as? SKEmitterNode
            self.burstNode2!.position = CGPointMake(100, 400)
            self.burstNode2!.zPosition = 6
            self.burstNode2!.name = "firework"
            self.burstNode2!.targetNode = self.scene
            self.background!.addChild(self.burstNode2!)
            //burstNode2.removeFromParent()
            
            
             //self.popUp.hidden = false
        }
    }

    func returnToStart(summit: CGPoint, start: CGPoint) -> Void {
        //REMOVE NORMAL SPRITE AND ADD SLIDING SPRITE 
        
        self.sprite!.removeFromParent()
        self.slidingSprite.xScale = 1.5
        self.slidingSprite.yScale = 1.5
        self.slidingSprite.zPosition = 3
        self.slidingSprite.position = summit
        self.addChild(self.slidingSprite)
        
        let path = CGPathCreateMutable()
        CGPathMoveToPoint(path, nil, self.summit.x, self.summit.y)
        CGPathAddLineToPoint(path, nil, self.start.x, self.start.y)
        let destination = SKAction.followPath(path, asOffset: false, orientToPath: false, duration: 5.0)
        //CHANGE TO SLIDING SPRITE
        self.slidingSprite.runAction(SKAction.sequence([destination]))
        {
            //REMOVE SLIDING SPRITE AND ADD NORMAL SPRITE. might have to move just above curly bracket
            self.slidingSprite.removeFromParent()
            self.addChild(self.sprite!)
            self.sprite!.xScale = 1.5
            self.sprite!.yScale = 1.5
            self.sprite!.zPosition = 3
            self.sprite!.position = start
            
            self.moving = false
            self.popUp.customizeTitle("Home at Last")
            self.popUp.customizeFact("Did you know... People have skied and snowboarded down Everest!")
            self.popUp.customizeButton("Done")
            self.performSelector(#selector(self.showPopUp), withObject: nil, afterDelay: 1)
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
            if startSprite!.containsPoint(location) {
                if self.sprite!.containsPoint(start) {
                    self.moveStartToFirstBaseCamp(start, firstBaseCamp: baseCamp1)
                    //fade button off screen
                    let fadeAway = SKAction.fadeOutWithDuration(1)
                    self.startSprite!.runAction(SKAction.sequence([fadeAway]))
                }
                if self.sprite!.containsPoint(summit) {
                    self.returnToStart(summit, start: start)
                    let fadeAway = SKAction.fadeOutWithDuration(1)
                    self.startSprite!.runAction(SKAction.sequence([fadeAway]))
                }
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
        
        for idx in 1...(path!.baseCamps.count-2) {
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
//    NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: #selector(updateData), userInfo: nil, repeats: true)
            
            //distance
            self.previousDistanceTotal = self.distanceTotal
            let a = Double(self.sprite!.position.y - 208)*22.62
            self.distanceTotal = Int(a)

            setDistance(self.previousDistanceTotal.description, distanceTotal: self.distanceTotal.description)
            
            //steps to next camp
            self.previousRemainingSteps = self.remainingSteps
            let distanceToNextBaseCamp = getNextBaseCampPoint()
            //change to go down
            let steps = distanceToNextBaseCamp - Double(sprite!.position.y)
            self.remainingSteps = Int(steps)
            self.setStepsToNextCamp()
            
            self.previousPosition = Double(sprite!.position.y)
            //steps
            self.previousSteps = self.totalSteps
            //steps to mount everest
            let b = Double(self.sprite!.position.y - 208)*148.897
            self.totalSteps = Int(b)
            
            setSteps(self.previousSteps.description, totalSteps: self.totalSteps.description)
            
            //calories
            self.previousCalories = self.calories
            //calories to mount everest
            let c = Double(self.sprite!.position.y - 208) * 148.897 * 0.17
            self.calories = Int(c)
            // get label text
            setCalories(self.previousCalories.description, totalCalories: self.calories.description)
            
            print("we are at: ", self.sprite?.position.y)
            
        }
    }
    
//    @objc private func updateData(){
//        self.time = self.time + 1
//    }
    
    func setDistance(previousDistanceTotal: String, distanceTotal: String) {
        self.labelDistance!.removeFromSuperview()
        self.labelDistance = ScoreboardLabel(backgroundImage: self.image!, text:previousDistanceTotal, flipToText: distanceTotal, font:self.font!, textColor:self.color)
        self.labelDistance!.center = CGPoint(x: 190, y: 18)
        view!.addSubview(self.labelDistance!)
        self.labelDistance!.flip(true)
        self.labelDistance!.stopFlipping()
    
    }
    
    func setStepsToNextCamp() {
        self.labelCamp!.removeFromSuperview()
        self.labelCamp = ScoreboardLabel(backgroundImage: self.image! ,text:self.previousRemainingSteps.description, flipToText:self.remainingSteps.description, font:self.font!, textColor:self.color)
        self.labelCamp!.center = CGPoint(x: 190, y: 36)
        view!.addSubview(self.labelCamp!)
        self.labelCamp!.flip(true)
        self.labelCamp!.stopFlipping()
    }
    
    func setSteps(previousSteps: String, totalSteps: String) {
        self.labelSteps!.removeFromSuperview()
        self.labelSteps = ScoreboardLabel(backgroundImage: self.image! ,text:previousSteps, flipToText:totalSteps, font:self.font!, textColor:self.color)
        self.labelSteps!.center = CGPoint(x: 190, y: 54)
        view!.addSubview(self.labelSteps!)
        self.labelSteps!.flip(true)
        self.labelSteps!.stopFlipping()

    }
    
    func setCalories(previousCalories: String, totalCalories: String) {
        self.labelCalories!.removeFromSuperview()
        self.labelCalories = ScoreboardLabel(backgroundImage: self.image! ,text:previousCalories, flipToText:totalCalories, font:self.font!, textColor:self.color)
        self.labelCalories!.center = CGPoint(x: 190, y: 74)
        view!.addSubview(self.labelCalories!)
        self.labelCalories!.flip(true)
        self.labelCalories!.stopFlipping()
    }
    
    func getNextBaseCampPoint()-> Double {
        
        var minX = CGFloat(30.72)
        var maxX = CGFloat(256)
        
        if (self.sprite!.position.x > minX && self.sprite!.position.x < maxX) {
            let distance = getCampDistance(start, nextCamp: baseCamp1)
            return distance
        }
        
        minX = CGFloat(256)
        maxX = CGFloat(422.9)
        
        if (self.sprite!.position.x > minX && self.sprite!.position.x < maxX) {
            let distance = getCampDistance(baseCamp1, nextCamp: baseCamp2)
            return distance
        }

        minX = CGFloat(422.9)
        maxX = CGFloat(504.8)
        
        if (self.sprite!.position.x > minX && self.sprite!.position.x < maxX) {
            let distance = getCampDistance(baseCamp2, nextCamp: baseCamp3)
            return distance
        }
        
        minX = CGFloat(504.8)
        maxX = CGFloat(555)
        
        if (self.sprite!.position.x > minX && self.sprite!.position.x < maxX) {
            let distance = getCampDistance(baseCamp3, nextCamp: baseCamp4)
            return distance
        }
        
        minX = CGFloat(555)
        maxX = CGFloat(612.4)
        
        if (self.sprite!.position.x > minX && self.sprite!.position.x < maxX) {
            let distance = getCampDistance(baseCamp4, nextCamp: summit)
            return distance
        }
        return 0.0
    }
    
    func getCampDistance(previousCamp:(CGPoint), nextCamp:(CGPoint)) -> Double {
        //convert coordinates to screen size
        
        //let xDist = CGFloat(nextCamp.x - previousCamp.x)
        //let yDist = CGFloat(nextCamp.y - previousCamp.y)
        //print("Distance", distance)
        return Double(nextCamp.y)
    }
    
    func showPopUp() {
        self.popUp.hidden = false
    }
    
    
}
