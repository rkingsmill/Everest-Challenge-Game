//
//  FlagSpriteNode.swift
//  Everest Challenge
//
//  Created by Yasmin Ahmad on 2016-06-20.
//  Copyright © 2016 Rosalyn Kingsmill. All rights reserved.
//

import Foundation
import SpriteKit

class FlagSpriteNode: SKSpriteNode {
    
    var waveFlag: SKAction!
    var flagSprite: SKSpriteNode!
    
    convenience init(){
        self.init(imageNamed: "redflag.png")
        
        setUpFlag()
        runAction(waveFlag)
    }
    
    func setUpFlag(){
        flagSprite = SKSpriteNode(imageNamed: "RedFlag1")
        
        let atlas1 = SKTextureAtlas(named: "FlagSprite")
        
        let animation1 = SKAction.animateWithTextures([
            atlas1.textureNamed("RedFlag1"),
            atlas1.textureNamed("RedFlag2"),
            atlas1.textureNamed("RedFlag3")], timePerFrame: 0.5)
        
        waveFlag = SKAction.repeatActionForever(animation1)
        
    }
    
}



