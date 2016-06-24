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
    var moveCloud2: SKAction!
    var moveCloud3: SKAction!
    var resetCloud: SKAction!
    var resetCloud2: SKAction!
    var resetCloud3: SKAction!
    var cloudSprite1: SKSpriteNode!
    var cloudSprite2: SKSpriteNode!
    var cloudSprite3: SKSpriteNode!
    
    
    override init(){
        super.init()
        
        setUpCloud()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpCloud() {
        cloudSprite1 = SKSpriteNode(imageNamed: "Cloud1")
        cloudSprite2 = SKSpriteNode(imageNamed: "Cloud2")
        cloudSprite3 = SKSpriteNode(imageNamed: "Cloud3")
        
        cloudSprite1.position = CGPointMake(900, 600)
        cloudSprite2.position = CGPointMake(600, 650)
        cloudSprite3.position = CGPointMake(300, 700)
        
        cloudSprite1.zPosition = 1
        cloudSprite2.zPosition = 1
        cloudSprite3.zPosition = 1

        moveCloud = SKAction.moveToX(-cloudSprite1.size.width/2, duration: 30.0)
        resetCloud = SKAction.moveToX(1000, duration: 0.0)
        
        moveCloud2 = SKAction.moveToX(-cloudSprite2.size.width/2, duration: 25.0)
        resetCloud2 = SKAction.moveToX(1000, duration: 0.0)
        
        moveCloud3 = SKAction.moveToX(-cloudSprite3.size.width/2, duration: 40.0)
        resetCloud3 = SKAction.moveToX(1000, duration: 0.0)

        let sequence = SKAction.sequence([moveCloud, resetCloud])
        let sequence2 = SKAction.sequence([moveCloud2, resetCloud2])
        let sequence3 = SKAction.sequence([moveCloud3, resetCloud3])
        cloudSprite1.runAction(SKAction.repeatActionForever(sequence))
        cloudSprite2.runAction(SKAction.repeatActionForever(sequence2))
        cloudSprite3.runAction(SKAction.repeatActionForever(sequence3))
        
        self.addChild(cloudSprite1)
        self.addChild(cloudSprite2)
        self.addChild(cloudSprite3)
  
        
    }
    
}
