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
    let route = CGPathCreateMutable()
    let path = Path()
        
    override func didMoveToView(view: SKView) {
        //sprite setup
        
        let background = SKSpriteNode(imageNamed: "Mount-Everest Compressed")
        background.zPosition = 1
        background.position = CGPoint(x:CGRectGetMidX(frame), y:CGRectGetMidY(frame))
        addChild(background)
        scene!.scaleMode = SKSceneScaleMode.AspectFit;
        scene?.anchorPoint = CGPointZero
        
        sprite = SKSpriteNode(imageNamed: "Spaceship")
        sprite!.xScale = 0.2
        sprite!.yScale = 0.2
        sprite!.zPosition = 10
        sprite!.position = CGPointMake(frame.width/2, frame.height/2)
        self.addChild(sprite!)
        
        //create path - need to change to our mountain path
        self.createPath()
        
        let followLine = SKAction.followPath(route, asOffset: false, orientToPath: false, duration: 10.0)
        
        sprite!.runAction(SKAction.sequence([followLine]))
    }
    
    func createPath() {
        
        let width = CGRectGetWidth(frame)
        let height = CGRectGetHeight(frame)
        print("width:", width)
        print("height:", height)
        CGPathMoveToPoint(route, nil, path.baseCamps[0].x*width, path.baseCamps[0].y*height)
        print("x: \(path.baseCamps[0].x*width) y: \(path.baseCamps[0].x*height)")
        for idx in 1...(path.baseCamps.count - 1) {
            print("x: \(path.baseCamps[idx].x*width) y: \(path.baseCamps[idx].x*height)")
            CGPathAddLineToPoint(route, nil, path.baseCamps[idx].x*width, path.baseCamps[idx].y*height)
        }
    }
    
}

