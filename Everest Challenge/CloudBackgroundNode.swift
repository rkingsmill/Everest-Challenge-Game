//
//  CloudSpriteNode.swift
//  Everest Challenge
//
//  Created by Yasmin Ahmad on 2016-06-21.
//  Copyright © 2016 Rosalyn Kingsmill. All rights reserved.
//

import Foundation
import SpriteKit

class CloudBackgroundNode: SKNode {
    
    var moveCloud: SKAction!
    var cloudSprite1: SKNode!
    
    convenience override init(){
        self.init(fileNamed:"Cloud1")!
//        self.init(imageNamed:"Cloud2")
//        self.init(imageNamed:"Cloud3")
        
        setUpCloud()
        runAction(moveCloud)
    }
    
    func setUpCloud() {
        cloudSprite1 = SKNode(fileNamed: "Cloud1")
        //cloudSprite2 = SKNode(fileNamed: "Cloud2")
        //cloudSprite3 = SKNode(fileNamed: "Cloud3")
        
        cloudSprite1.position = CGPointMake (self.frame.size.width/2, self.frame.size.height/2)
        cloudSprite1.zPosition = 3
        cloudSprite1.physicsBody!.affectedByGravity = false

        let moveCloud = SKAction.moveToX(self.frame.size.width, duration: 1.0)
        cloudSprite1.runAction(moveCloud)
        
        self.addChild(cloudSprite1)
        
        
    }
    
    
    
    //    func setUpSun(){
    //        sunSprite = SKSpriteNode(imageNamed: "sunSprite1.png")
    //
    //        let atlas1 = SKTextureAtlas(named: "SunSprite")
    //
    //        let animation1 = SKAction.animateWithTextures([
    //            atlas1.textureNamed("Sun1"),
    //            atlas1.textureNamed("Sun2")], timePerFrame: 0.8)
    //
    //        sunShine = SKAction.repeatActionForever(animation1)
    //
    //
    //
    //
    //    }
    
}
