//
//  GameScene.swift
//  MountEverest
//
//  Created by Yasmin Ahmad on 2016-06-13.
//  Copyright (c) 2016 YasminA. All rights reserved.
//

import SpriteKit
import ScoreboardLabel

class GameScene: SKScene {
    var sprite: SKSpriteNode?
    var sunSprite: SKSpriteNode?
    var flagSprite: SKSpriteNode?
    var playerScore: ScoreSpriteNode!
    var scoreLabels: [SKLabelNode] = [SKLabelNode]()
    var label: ScoreboardLabel!
    var path: Path!
    let start = CGPoint(x: 30.72, y: 208.1)
    let baseCamp1 = CGPoint(x: 256, y: 345.6)
    let baseCamp2 = CGPoint(x: 422.9, y: 458.5)
    let baseCamp3 = CGPoint(x: 504.8, y: 516.1)
    let baseCamp4 = CGPoint(x: 555, y: 554.4)
    let summit = CGPoint(x: 612.4, y: 600)
    
    override func didMoveToView(view: SKView) {
  
        let background = SKSpriteNode(imageNamed: "Mount-Everest Compressed")
        background.zPosition = 1
        background.position = CGPoint(x:CGRectGetMidX(frame), y:CGRectGetMidY(frame))
        addChild(background)
        
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
        
        
        
        
    }
    
    func moveStartToFirstBaseCamp(start: CGPoint, firstBaseCamp: CGPoint) -> Void {
        
        let path = CGPathCreateMutable()
        CGPathMoveToPoint(path, nil, start.x, start.y)
        CGPathAddLineToPoint(path, nil, firstBaseCamp.x, firstBaseCamp.y)
        let destination = SKAction.followPath(path, asOffset: false, orientToPath: false, duration: 3.0)
        //        let reverseSecondBaseCamp = secondBaseCamp.reversedAction()
        self.sprite!.runAction(SKAction.sequence([destination]))
        {
            //Perhaps show some pop up
            self.moveFirstToSecondBaseCamp(self.baseCamp1, secondBaseCamp: self.baseCamp2)
            
        }
    }
    
    func moveFirstToSecondBaseCamp(firstBaseCamp: CGPoint, secondBaseCamp: CGPoint) -> Void {
        
        let path = CGPathCreateMutable()
        CGPathMoveToPoint(path, nil, firstBaseCamp.x, firstBaseCamp.y)
        CGPathAddLineToPoint(path, nil, secondBaseCamp.x, secondBaseCamp.y)
        let destination = SKAction.followPath(path, asOffset: false, orientToPath: false, duration: 3.0)
        //        let reverseSecondBaseCamp = secondBaseCamp.reversedAction()
        self.sprite!.runAction(SKAction.sequence([destination]))
        {
            //Perhaps show some pop up
            self.moveSecondToThirdBaseCamp(self.baseCamp2, thirdBaseCamp: self.baseCamp3)
        }
    }
    
    func moveSecondToThirdBaseCamp(secondBaseCamp: CGPoint, thirdBaseCamp: CGPoint) -> Void {
        
        let path = CGPathCreateMutable()
        CGPathMoveToPoint(path, nil, secondBaseCamp.x, secondBaseCamp.y)
        CGPathAddLineToPoint(path, nil, thirdBaseCamp.x, thirdBaseCamp.y)
        let destination = SKAction.followPath(path, asOffset: false, orientToPath: false, duration: 2.0)
        //        let reverseSecondBaseCamp = secondBaseCamp.reversedAction()
        self.sprite!.runAction(SKAction.sequence([destination]))
        {
            //Perhaps show some pop up
            self.moveThirdToFourthBaseCamp(self.baseCamp3, fourthBaseCamp: self.baseCamp4)
        }
    }
    
    func moveThirdToFourthBaseCamp(thirdBaseCamp: CGPoint, fourthBaseCamp: CGPoint) -> Void {
        
        let path = CGPathCreateMutable()
        CGPathMoveToPoint(path, nil, thirdBaseCamp.x, thirdBaseCamp.y)
        CGPathAddLineToPoint(path, nil, fourthBaseCamp.x, fourthBaseCamp.y)
        let destination = SKAction.followPath(path, asOffset: false, orientToPath: false, duration: 2.0)
        //        let reverseSecondBaseCamp = secondBaseCamp.reversedAction()
        self.sprite!.runAction(SKAction.sequence([destination]))
        {
            //Perhaps show some pop up
            self.moveFourthBaseCampToSummit(self.baseCamp4, summit: self.summit)
        }
    }
    
    func moveFourthBaseCampToSummit(fourthBaseCamp: CGPoint, summit: CGPoint) -> Void {
        
        let path = CGPathCreateMutable()
        CGPathMoveToPoint(path, nil, fourthBaseCamp.x, fourthBaseCamp.y)
        CGPathAddLineToPoint(path, nil, summit.x, summit.y)
        let destination = SKAction.followPath(path, asOffset: false, orientToPath: false, duration: 2.0)
        //        let reverseSecondBaseCamp = secondBaseCamp.reversedAction()
        self.sprite!.runAction(SKAction.sequence([destination]))
        {
            //Perhaps show some pop up
            self.returnToStart(self.summit, start: self.start)
        }
    }
    
    func returnToStart(summit: CGPoint, start: CGPoint) -> Void {
        
        let path = CGPathCreateMutable()
        CGPathMoveToPoint(path, nil, self.summit.x, self.summit.y)
        CGPathAddLineToPoint(path, nil, self.start.x, self.start.y)
        let destination = SKAction.followPath(path, asOffset: false, orientToPath: false, duration: 5.0)
        //        let reverseSecondBaseCamp = secondBaseCamp.reversedAction()
        self.sprite!.runAction(SKAction.sequence([destination]))
            
        }
    
//    func animate(initialCoord: CGPoint, secondCoord: CGPoint, completion:() -> Void)  {
//        let path = CGPathCreateMutable()
//        CGPathMoveToPoint(path, nil, initialCoord.x, initialCoord.y)
//        CGPathAddLineToPoint(path, nil, secondCoord.x, secondCoord.y)
//        let destination = SKAction.followPath(path, asOffset: false, orientToPath: false, duration: 3.0)
//        //        let reverseSecondBaseCamp = secondBaseCamp.reversedAction()
//        self.sprite!.runAction(SKAction.sequence([destination]))
//        {
//            //Perhaps show some pop up
//            
//        }
//    }
    
//    func moveStartToFirstBaseCamp(start: CGPoint, firstBaseCamp: CGPoint) -> Void {
//        
//        self.animate(start, secondCoord: firstBaseCamp, completion: ({
//            self.moveFirstToSecondBaseCamp(self.baseCamp1, secondBaseCamp: self.baseCamp2)
//        })
//            
//        )}
//    
//    func moveFirstToSecondBaseCamp(firstBaseCamp: CGPoint, secondBaseCamp: CGPoint) -> Void {
//        
//        self.animate(firstBaseCamp, secondCoord: secondBaseCamp, completion: ({
//            self.moveSecondToThirdBaseCamp(self.baseCamp2, thirdBaseCamp: self.baseCamp3)
//        })
//        )}
    
//    func moveSecondToThirdBaseCamp(secondBaseCamp: CGPoint, thirdBaseCamp: CGPoint) -> Void {
//        
//        self.animate(secondBaseCamp, secondCoord: thirdBaseCamp, completion: ({
//            self.moveThirdToFourthBaseCamp(self.baseCamp3, fourthBaseCamp: self.baseCamp4)
//            
//        })
//        )}
    
//    func moveThirdToFourthBaseCamp(thirdBaseCamp: CGPoint, fourthBaseCamp: CGPoint) -> Void {
//        
//        self.animate(thirdBaseCamp, secondCoord: fourthBaseCamp, completion: ({
//            
//            self.moveFourthBaseCampToSummit(self.baseCamp4, summit: self.summit)
//        })
//        )}
    
//    func moveFourthBaseCampToSummit(fourthBaseCamp: CGPoint, summit: CGPoint) -> Void {
//        
//        self.animate(fourthBaseCamp, secondCoord: summit, completion: ({
//            
//            self.returnToStart(self.summit, start: self.start)
//        })
//        )}

   
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
            let tent = SKSpriteNode(imageNamed: "Tent.png")
            tent.xScale = 0.4
            tent.yScale = 0.4
            tent.zPosition = 2
            //TODO convert to new distances
            let xValue = path.baseCamps[idx].x
            let yValue = path.baseCamps[idx].y
            let point = CGPoint(x: xValue, y: yValue)
            let position = Utils().getScreenCoordinatesForRelativeCoordinates(point, size: path.frameSize)
            tent.position = position
            addChild(tent)
        }
    }
    
    func moveGirlToNextCampAtPoint(point: CGPoint){
        sprite?.position = point

        //        CGPathMoveToPoint(route, nil, dataManager.currentBaseCamp.x, dataManager.currentBaseCamp.y)
        //        CGPathAddLineToPoint(route, nil, dataManager.[idx].x, path.baseCamps[idx].y)
        //        CGPathMoveToPoint(route, nil, path.baseCamps[0].x, path.baseCamps[0].y)

    }

//    func tapped(sender: UITapGestureRecognizer){
        //        if isReadyToPress == true {
                   // self.createPath()
                    //make paths for each current base camp
//                    let followLine = SKAction.followPath(route, asOffset: false, orientToPath: false, duration: 10.0)
//                    sprite!.runAction(SKAction.sequence([followLine]))
//                    //reset current base camp and save in NSDefaults
//                    dataManager.resetCurrentBaseCamp()
//                    print("tapped")
//                }
//    }
    
//}
    

    
    
    //ADD SCOREBOARD AS A VIEW
    

}
