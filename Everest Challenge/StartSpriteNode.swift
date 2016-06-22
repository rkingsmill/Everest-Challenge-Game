//
//  File.swift
//  Everest Challenge
//
//  Created by Yasmin Ahmad on 2016-06-21.
//  Copyright © 2016 Rosalyn Kingsmill. All rights reserved.
//

import Foundation
import SpriteKit


class StartSpriteNode: SKSpriteNode {
    
    var startButton : SKSpriteNode = SKSpriteNode(imageNamed: "StartButton1")
    var startLabel : SKLabelNode = SKLabelNode()
    var buttonFlash: SKAction!
//    var restartButton: SKSpriteNode = SKSpriteNode(imageNamed: "StartButton2")
//    var restartLabel: SKLabelNode = SKLabelNode()
//    var restartFlash: SKAction!
    
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        self.setUpButton()
        startButton.runAction(buttonFlash)
        
//        self.setUpRestart()
//        restartButton.runAction(restartFlash)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpButton(){
        
        let atlas = SKTextureAtlas(named: "StartButtonSprite")
        
        let animation = SKAction.animateWithTextures([
            atlas.textureNamed("StartButton1"),
            atlas.textureNamed("StartButton2")], timePerFrame: 0.6)
        
        buttonFlash = SKAction.repeatActionForever(animation)
        
        startButton.xScale = 1
        startButton.yScale = 1
        addChild(startButton)
        
        startLabel.text = ""
        startLabel.fontColor = UIColor.greenColor()
        startLabel.fontName = "LCD Solid"
        startLabel.fontSize = 20
        startLabel.position = CGPointMake(self.frame.width/2, self.frame.height/2)
        startButton.addChild(startLabel)
    }
    
//    func setUpRestart(){
//        
//        let atlas = SKTextureAtlas(named: "StartButtonSprite")
//        
//        let animationRestart = SKAction.animateWithTextures([
//            atlas.textureNamed("StartButton1"),
//            atlas.textureNamed("StartButton2")], timePerFrame: 0.6)
//        
//        restartFlash = SKAction.repeatActionForever(animationRestart)
//        
//        restartButton.xScale = 1
//        restartButton.yScale = 1
//        addChild(restartButton)
//        
//        restartLabel.text = ""
//        restartLabel.fontColor = UIColor.greenColor()
//        restartLabel.fontName = "LCD Solid"
//        restartLabel.fontSize = 20
//        restartLabel.position = CGPointMake(self.frame.width/2, self.frame.height/2)
//        restartButton.addChild(restartLabel)
//        
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
}



