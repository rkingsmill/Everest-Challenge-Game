//
//  SpriteNode.swift
//  Everest Challenge
//
//  Created by Yasmin Ahmad on 2016-06-20.
//  Copyright © 2016 Rosalyn Kingsmill. All rights reserved.
//

import Foundation
import SpriteKit

class PlayerSpriteNode: SKSpriteNode {
    
    var spriteWalk: SKAction!
    
    convenience init(){
        self.init(imageNamed: "SpriteR1.png")
        
        setUpSprite()
        runAction(spriteWalk)
        
    }
    
    func setUpSprite(){
        
        let atlas = SKTextureAtlas(named: "PlayerSprite")
        
        let animation = SKAction.animateWithTextures([
            atlas.textureNamed("SpriteR1.png"),
            atlas.textureNamed("SpriteR2.png")], timePerFrame: 0.6)
        
        spriteWalk = SKAction.repeatActionForever(animation)
        
    }
    
    
}
