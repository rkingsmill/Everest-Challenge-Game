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
        self.multiplyRelativeCoordinates()
        self.createPath()
        self.addTentImages()
        
        let followLine = SKAction.followPath(route, asOffset: false, orientToPath: false, duration: 10.0)
        
        sprite!.runAction(SKAction.sequence([followLine]))
    }
    
    func createPath() {

        CGPathMoveToPoint(route, nil, path.baseCamps[0].x, path.baseCamps[0].y)
        print("x: \(path.baseCamps[0].x) y: \(path.baseCamps[0].x)")
        for idx in 1...(path.baseCamps.count - 1) {
            print("x: \(path.baseCamps[idx].x) y: \(path.baseCamps[idx].x)")
            CGPathAddLineToPoint(route, nil, path.baseCamps[idx].x, path.baseCamps[idx].y)
        }
    }
    
    func addTentImages() {
        
        for idx in 1...(path.baseCamps.count - 1) {
            let tent = SKSpriteNode(imageNamed: "tent")
            tent.xScale = 0.2
            tent.yScale = 0.2
            tent.zPosition = 2
            tent.position = CGPoint(x:path.baseCamps[idx].x, y:path.baseCamps[idx].y)
            addChild(tent)
        }
    }
    
    func multiplyRelativeCoordinates() {
        let width = CGRectGetWidth(frame)
        let height = CGRectGetHeight(frame)
        for idx in 0...(path.baseCamps.count - 1) {
            path.baseCamps[idx].x = path.baseCamps[idx].x*width
            path.baseCamps[idx].y = path.baseCamps[idx].y*height
        }
        
    }
    
}

