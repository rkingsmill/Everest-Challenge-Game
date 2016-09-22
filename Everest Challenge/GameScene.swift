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
    let color = UIColor.black
    
    var defaultss:UserDefaults = UserDefaults.standard
    var maskingCameraRollChoice:Bool = true
    var maskOffSet:CGPoint = CGPoint.zero
    
    var button: SKNode! = nil
    
    var moving = false
    var background : SKSpriteNode?
    var burstNode : SKEmitterNode?
    var burstNode2 : SKEmitterNode?
    
    override func didMove(to view: SKView) {
        self.popUp.isHidden = true
        
        self.background = SKSpriteNode(imageNamed: "Mount-Everest Compressed")
        background!.zPosition = 1
        background!.position = CGPoint(x:frame.midX, y:frame.midY)
        addChild(background!)
        
        scene!.scaleMode = SKSceneScaleMode.aspectFit;
        scene?.anchorPoint = CGPoint.zero
        
        //CURRENT SCORE BOARD
        playerScore = ScoreSpriteNode()
        playerScore.position = CGPoint(x: 220,y: 640)
        playerScore!.zPosition = 2
        addChild(playerScore)

        cloudSprite = CloudBackgroundNode()
        cloudSprite!.xScale = 0.8
        cloudSprite!.yScale = 0.8
        addChild(cloudSprite!)
        
        let font = UIFont(name: "LCD Solid", size: 12)
        let image = UIImage(named: "WhiteBackground.png")
        let color = UIColor.black
       
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
                
        let labelStart = ScoreboardLabel(backgroundImage: self.image! ,text:" ", flipToText: "09/22", font:self.font!, textColor:self.color)
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
        sprite!.xScale = 1
        sprite!.yScale = 1
        sprite!.zPosition = 3
        print("frame on the GameScene \(frame)")
        //sprite!.position = CGPointMake(frame.width/2, frame.height/2)
        self.addChild(sprite!)
        
     
        //add image face
        let cropNode:SKCropNode = SKCropNode()
    
        let actualMask = SKShapeNode(circleOfRadius: 5 )
        actualMask.xScale = 0.5
        actualMask.yScale = 1.2
        actualMask.zPosition = 4
        actualMask.lineWidth = 0
        actualMask.position = CGPoint(x:0, y:0)
        actualMask.fillColor = UIColor(red: 240.0/255.0, green: 184.0/255.0, blue: 160.0/255.0, alpha: 1)
        cropNode.maskNode = actualMask
        cropNode.zPosition = 4
        cropNode.position = CGPoint(x:1, y:18)
        sprite!.addChild(cropNode)
        //cropNode.hidden = true
        
        face = SKSpriteNode(imageNamed: "testface")
        face!.zPosition = 5
        face!.xScale = 0.2
        face!.yScale = 0.4
        face!.position = CGPoint(x:0, y:0)
        cropNode.addChild(face!)
        //face?.hidden = true
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
        sunSprite!.position = CGPoint(x: 902, y: 680)
        self.addChild(sunSprite!)
        
        flagSprite = FlagSpriteNode()
        flagSprite!.xScale = 1
        flagSprite!.yScale = 1
        flagSprite!.zPosition = 3
        flagSprite!.position = CGPoint(x: 660, y: 670)
        self.addChild(flagSprite!)
        
        startSprite = SKSpriteNode(imageNamed: "sign")
        startSprite?.position = CGPoint(x: 900, y: 100)
        startSprite?.zPosition = 6
        startSprite!.xScale = 0.35
        startSprite!.yScale = 0.35
        //button = startSprite
        self.addChild(startSprite!)
    }
    
    func moveStartToFirstBaseCamp(_ start: CGPoint, firstBaseCamp: CGPoint) -> Void {
        moving = true
        
        let path = CGMutablePath()
        path.move(to: CGPoint(x: start.x, y: start.y))
        path.addLine(to: CGPoint(x: firstBaseCamp.x, y: firstBaseCamp.y))
        
        //CGPathMoveToPoint(path, nil, start.x, start.y)
        //CGPathAddLineToPoint(path, nil, firstBaseCamp.x, firstBaseCamp.y)
        let destination = SKAction.follow(path, asOffset: false, orientToPath: false, duration: 3.0)
        //        let reverseSecondBaseCamp = secondBaseCamp.reversedAction()
        self.sprite!.run(SKAction.sequence([destination]), completion: {
            self.moving = false
            self.popUp.customizeTitle("First Base Camp")
            self.popUp.customizeFact("CONGRATS on reaching your first Base Camp! Did you know... Mount Everest was first climbed in 1953. Some of the benefits of climbing include exercising bones and muscles, improving strength, bone density and muscle tone. Good job. ")
            self.popUp.customizeButton("Keep Climbing")
            self.perform(#selector(self.showPopUp), with: nil, afterDelay: 1)
        })
        
    }
    
    func moveFirstToSecondBaseCamp(_ firstBaseCamp: CGPoint, secondBaseCamp: CGPoint) -> Void {
        moving = true
        let path = CGMutablePath()
        path.move(to: CGPoint(x: firstBaseCamp.x, y: firstBaseCamp.y))
        path.addLine(to: CGPoint(x: secondBaseCamp.x, y: secondBaseCamp.y))
        //CGPathMoveToPoint(path, nil, firstBaseCamp.x, firstBaseCamp.y)
        //CGPathAddLineToPoint(path, nil, secondBaseCamp.x, secondBaseCamp.y)
        let destination = SKAction.follow(path, asOffset: false, orientToPath: false, duration: 3.0)
        //        let reverseSecondBaseCamp = secondBaseCamp.reversedAction()
        self.sprite!.run(SKAction.sequence([destination]), completion: {
            self.moving = false
            self.popUp.customizeTitle("Second Base Camp")
            self.popUp.customizeFact("CONGRATS on reaching your second Base Camp. Some motivation: The youngest person to climb Everest is American teenager Jordan Romero, who was 13 years old when he reached the summit on 22 May, 2010.")
            self.popUp.customizeButton("Keep Climbing")
            self.perform(#selector(self.showPopUp), with: nil, afterDelay: 1)
        })
        
    }
    
    func moveSecondToThirdBaseCamp(_ secondBaseCamp: CGPoint, thirdBaseCamp: CGPoint) -> Void {
        moving = true
        let path = CGMutablePath()
        path.move(to: CGPoint(x: secondBaseCamp.x, y: secondBaseCamp.y))
        path.addLine(to: CGPoint(x: thirdBaseCamp.x, y: thirdBaseCamp.y))
        //CGPathMoveToPoint(path, nil, secondBaseCamp.x, secondBaseCamp.y)
        //CGPathAddLineToPoint(path, nil, thirdBaseCamp.x, thirdBaseCamp.y)
        let destination = SKAction.follow(path, asOffset: false, orientToPath: false, duration: 3.0)
        //        let reverseSecondBaseCamp = secondBaseCamp.reversedAction()
        self.sprite!.run(SKAction.sequence([destination]), completion: {
            self.moving = false
            self.popUp.customizeTitle("Third Base Camp")
            self.popUp.customizeFact("GETTING CLOSER! The oldest person to reach the summit of Everest is Miura Yiuchiro from Japan, at the age of 80 years old. Good thing climbing gets you into shape without putting too much pressure on your knees and feet!")
            self.popUp.customizeButton("Onwards and Upwards")
            self.perform(#selector(self.showPopUp), with: nil, afterDelay: 1)
        })
        
    }
    
    func moveThirdToFourthBaseCamp(_ thirdBaseCamp: CGPoint, fourthBaseCamp: CGPoint) -> Void {
        moving = true
        let path = CGMutablePath()
        path.move(to: CGPoint(x: thirdBaseCamp.x, y: thirdBaseCamp.y))
        path.addLine(to: CGPoint(x: fourthBaseCamp.x, y: fourthBaseCamp.y))
        //CGPathMoveToPoint(path, nil, thirdBaseCamp.x, thirdBaseCamp.y)
        //CGPathAddLineToPoint(path, nil, fourthBaseCamp.x, fourthBaseCamp.y)
        let destination = SKAction.follow(path, asOffset: false, orientToPath: false, duration: 3.0)
        //        let reverseSecondBaseCamp = secondBaseCamp.reversedAction()
        self.sprite!.run(SKAction.sequence([destination]), completion: {
            self.moving = false
            self.popUp.customizeTitle("Fourth Base Camp")
            self.popUp.customizeFact("ALMOST THERE! Did you know... Anything above 8,000 metres is known as the Death Zone. Climbers suffer altitude sickness and headaches and risk life-threatening oedemas due to the thin, dry air.")
            self.popUp.customizeButton("Keep Climbing")
             self.perform(#selector(self.showPopUp), with: nil, afterDelay: 1)
        })
        
    }
    
    func moveFourthBaseCampToSummit(_ fourthBaseCamp: CGPoint, summit: CGPoint) -> Void {
        moving = true
        let path = CGMutablePath()
        path.move(to: CGPoint(x: fourthBaseCamp.x, y: fourthBaseCamp.y))
        path.addLine(to: CGPoint(x: summit.x, y: summit.y))
        //CGPathMoveToPoint(path, nil, fourthBaseCamp.x, fourthBaseCamp.y)
        //CGPathAddLineToPoint(path, nil, summit.x, summit.y)
        let destination = SKAction.follow(path, asOffset: false, orientToPath: false, duration: 3.0)
        //        let reverseSecondBaseCamp = secondBaseCamp.reversedAction()
        self.sprite!.run(SKAction.sequence([destination]), completion: {
            self.moving = false
            self.popUp.customizeTitle("The Summit")
            self.popUp.customizeFact("CONGRATULATIONS... You have reached the summit of Mount Everest - the tallest mountain in the world of 8,848 metres high. That’s the height at which passenger aeroplanes fly at!")
            self.popUp.customizeButton("Enjoy the view")
            self.perform(#selector(self.showPopUp), with: nil, afterDelay: 4)
            
            //baby im a firework
            let burstPath = Bundle.main.path(forResource: "Spark",
                                                                  ofType: "sks")
            self.burstNode = NSKeyedUnarchiver.unarchiveObject(withFile: burstPath!)
                as? SKEmitterNode
            self.burstNode!.position = CGPoint(x: 200, y: 400)
            self.burstNode!.zPosition = 6
            self.burstNode!.name = "firework"
            self.burstNode!.targetNode = self.scene
            self.background!.addChild(self.burstNode!)
            
            self.burstNode2 = NSKeyedUnarchiver.unarchiveObject(withFile: burstPath!)
                as? SKEmitterNode
            self.burstNode2!.position = CGPoint(x: 100, y: 400)
            self.burstNode2!.zPosition = 6
            self.burstNode2!.name = "firework"
            self.burstNode2!.targetNode = self.scene
            self.background!.addChild(self.burstNode2!)
            //burstNode2.removeFromParent()
             //self.popUp.hidden = false
        })
        
    }

    func returnToStart(_ summit: CGPoint, start: CGPoint) -> Void {
        //REMOVE NORMAL SPRITE AND ADD SLIDING SPRITE 
        
        self.sprite!.removeFromParent()
        self.slidingSprite.xScale = 1.5
        self.slidingSprite.yScale = 1.5
        self.slidingSprite.zPosition = 3
        self.slidingSprite.position = summit
        self.addChild(self.slidingSprite)
        
        let path = CGMutablePath()
        path.move(to: CGPoint(x: self.summit.x, y: self.summit.y))
        path.addLine(to: CGPoint(x: self.start.x, y: self.start.y))
        //CGPathMoveToPoint(path, nil, self.summit.x, self.summit.y)
        //CGPathAddLineToPoint(path, nil, self.start.x, self.start.y)
        let destination = SKAction.follow(path, asOffset: false, orientToPath: false, duration: 6.0)
        //CHANGE TO SLIDING SPRITE
        self.slidingSprite.run(SKAction.sequence([destination]), completion: {
            //REMOVE SLIDING SPRITE AND ADD NORMAL SPRITE. might have to move just above curly bracket
            self.slidingSprite.removeFromParent()
            self.addChild(self.sprite!)
            self.sprite!.xScale = 1
            self.sprite!.yScale = 1
            self.sprite!.zPosition = 3
            self.sprite!.position = start
            
            self.moving = false
            self.popUp.customizeTitle("Home at Last")
            self.popUp.customizeFact("You have now joined a group of over 4000 people that have climbed Mount Everest")
            self.popUp.customizeButton("Done")
            self.perform(#selector(self.showPopUp), with: nil, afterDelay: 1)
        })
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            
            let location = touch.location(in: self)
            
            if sprite!.contains(location) {
                getPhotoFromSource(UIImagePickerControllerSourceType.camera)
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Loop over all the touches in this event
        for touch: AnyObject in touches {
            // Get the location of the touch in this scene
            let location = touch.location(in: self)
            // Check if the location of the touch is within the button's bounds
            if startSprite!.contains(location) {
                if self.sprite!.contains(start) {
                    self.moveStartToFirstBaseCamp(start, firstBaseCamp: baseCamp1)
                    //fade button off screen
                    let fadeAway = SKAction.fadeOut(withDuration: 1)
                    self.startSprite!.run(SKAction.sequence([fadeAway]))
                }
                if self.sprite!.contains(summit) {
                    self.returnToStart(summit, start: start)
                    let fadeAway = SKAction.fadeOut(withDuration: 1)
                    self.startSprite!.run(SKAction.sequence([fadeAway]))
                }
            }
        }
    }

    func addTentImages(){
        
//        let startingSign = SKSpriteNode(imageNamed: "sign")
//        startingSign.xScale = 0.2
//        startingSign.yScale = 0.2
//        startingSign.zPosition = 2
//        let xValue = path.baseCamps[0].x
//        let yValue = path.baseCamps[0].y
//        let point = CGPoint(x: xValue, y: yValue)
//        let position = Utils().getScreenCoordinatesForRelativeCoordinates(point, size: path.frameSize)
//        startingSign.position = position
//        addChild(startingSign)
        
        for idx in 0...(path!.baseCamps.count-2) {
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
    
    func moveGirlToNextCampAtPoint(_ point: CGPoint){
        sprite?.position = point

        //        CGPathMoveToPoint(route, nil, dataManager.currentBaseCamp.x, dataManager.currentBaseCamp.y)
        //        CGPathAddLineToPoint(route, nil, dataManager.[idx].x, path.baseCamps[idx].y)
        //        CGPathMoveToPoint(route, nil, path.baseCamps[0].x, path.baseCamps[0].y)
    }
    

    //get data from y position for labels
    override func update(_ currentTime: TimeInterval) {
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
            
            if self.remainingSteps >= 0 {
            self.setStepsToNextCamp()
            }
            
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
    
    func setDistance(_ previousDistanceTotal: String, distanceTotal: String) {
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
    
    func setSteps(_ previousSteps: String, totalSteps: String) {
        self.labelSteps!.removeFromSuperview()
        self.labelSteps = ScoreboardLabel(backgroundImage: self.image! ,text:previousSteps, flipToText:totalSteps, font:self.font!, textColor:self.color)
        self.labelSteps!.center = CGPoint(x: 190, y: 54)
        view!.addSubview(self.labelSteps!)
        self.labelSteps!.flip(true)
        self.labelSteps!.stopFlipping()

    }
    
    func setCalories(_ previousCalories: String, totalCalories: String) {
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
    
    func getCampDistance(_ previousCamp:(CGPoint), nextCamp:(CGPoint)) -> Double {
        //convert coordinates to screen size
        
        //let xDist = CGFloat(nextCamp.x - previousCamp.x)
        //let yDist = CGFloat(nextCamp.y - previousCamp.y)
        //print("Distance", distance)
        return Double(nextCamp.y)
    }
    
    func showPopUp() {
        self.popUp.isHidden = false
    }
    
    
}
