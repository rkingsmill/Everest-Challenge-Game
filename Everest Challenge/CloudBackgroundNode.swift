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
        
        cloudSprite1.position = CGPoint(x: 900, y: 600)
        cloudSprite2.position = CGPoint(x: 600, y: 650)
        cloudSprite3.position = CGPoint(x: 300, y: 700)
        
        cloudSprite1.zPosition = 1
        cloudSprite2.zPosition = 1
        cloudSprite3.zPosition = 1

        moveCloud = SKAction.moveTo(x: -cloudSprite1.size.width/2, duration: 30.0)
        resetCloud = SKAction.moveTo(x: 1000, duration: 0.0)
        
        moveCloud2 = SKAction.moveTo(x: -cloudSprite2.size.width/2, duration: 25.0)
        resetCloud2 = SKAction.moveTo(x: 1000, duration: 0.0)
        
        moveCloud3 = SKAction.moveTo(x: -cloudSprite3.size.width/2, duration: 40.0)
        resetCloud3 = SKAction.moveTo(x: 1000, duration: 0.0)

        let sequence = SKAction.sequence([moveCloud, resetCloud])
        let sequence2 = SKAction.sequence([moveCloud2, resetCloud2])
        let sequence3 = SKAction.sequence([moveCloud3, resetCloud3])
        cloudSprite1.run(SKAction.repeatForever(sequence))
        cloudSprite2.run(SKAction.repeatForever(sequence2))
        cloudSprite3.run(SKAction.repeatForever(sequence3))
        
        self.addChild(cloudSprite1)
        self.addChild(cloudSprite2)
        self.addChild(cloudSprite3)
  
        
    }
    
}
