//
//  GameScene.swift
//  MountEverest
//
//  Created by Yasmin Ahmad on 2016-06-13.
//  Copyright (c) 2016 YasminA. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    var sprite: SKSpriteNode?
    
    var path:Path!
    
    override func didMoveToView(view: SKView) {
        //sprite setup
        let background = SKSpriteNode(imageNamed: "Mount-Everest Compressed")
        background.zPosition = 1
        background.position = CGPoint(x:CGRectGetMidX(frame), y:CGRectGetMidY(frame))
        
        addChild(background)
        scene!.scaleMode = SKSceneScaleMode.AspectFit;
//        scene?.anchorPoint = CGPointZero
        
        sprite = SKSpriteNode(imageNamed: "Spaceship")
        sprite!.xScale = 0.2
        sprite!.yScale = 0.2
        sprite!.zPosition = 10
        print("frame on the GameScene \(frame)")
        sprite!.position = CGPointMake(frame.width/2, frame.height/2)
        self.addChild(sprite!)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(GameScene.tapped(_:)))
        view.addGestureRecognizer(tapGestureRecognizer)
        
    }
    
    func addTentImages(){
        
        let startingSign = SKSpriteNode(imageNamed: "start")
        startingSign.xScale = 0.3
        startingSign.yScale = 0.3
        startingSign.zPosition = 2
        let xValue = path.baseCamps[0].x
        let yValue = path.baseCamps[0].y
        let point = CGPoint(x: xValue, y: yValue)
        let position = Utils.getScreenCoordinatesForRelativeCoordinates(point, size: path.frameSize)
        startingSign.position = position
        addChild(startingSign)

        
        for idx in 1..<path!.baseCamps.count {
            let tent = SKSpriteNode(imageNamed: "tentfilled")
            tent.xScale = 0.3
            tent.yScale = 0.3
            tent.zPosition = 2
            //TODO convert to new distances
            let xValue = path.baseCamps[idx].x
            let yValue = path.baseCamps[idx].y
            let point = CGPoint(x: xValue, y: yValue)
            let position = Utils.getScreenCoordinatesForRelativeCoordinates(point, size: path.frameSize)
            tent.position = position
            addChild(tent)
        }
    }
    
    func moveGirlToNextCampAtPoint(point: CGPoint){
        sprite?.position = point
        
        //        CGPathMoveToPoint(route, nil, dataManager.currentBaseCamp.x, dataManager.currentBaseCamp.y)
        //        CGPathAddLineToPoint(route, nil, dataManager.[idx].x, path.baseCamps[idx].y)
        //
        //        CGPathMoveToPoint(route, nil, path.baseCamps[0].x, path.baseCamps[0].y)
    }
    
    @objc func tapped(sender: UITapGestureRecognizer){
        //        if isReadyToPress == true {
        //
                   // self.createPath()
                    //make paths for each current base camp
//        
//                    let followLine = SKAction.followPath(route, asOffset: false, orientToPath: false, duration: 10.0)
//                    sprite!.runAction(SKAction.sequence([followLine]))
//        
//                    //reset current base camp and save in NSDefaults
//                    dataManager.resetCurrentBaseCamp()
//                    print("tapped")
//                }
//    }
    
}

}
