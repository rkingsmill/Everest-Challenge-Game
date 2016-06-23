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
        self.init(imageNamed: "NewSprite1.png")
        
        setUpSprite()
        runAction(spriteWalk)
    }
    
    func setUpSprite(){
        
        let atlas = SKTextureAtlas(named: "PlayerSprite")
        
        let animation = SKAction.animateWithTextures([
            atlas.textureNamed("NewSprite1.png"),
            atlas.textureNamed("NewSprite2.png"),
            atlas.textureNamed("NewSprite3.png"),
            atlas.textureNamed("NewSprite4.png"),
            atlas.textureNamed("NewSprite5.png"),
            atlas.textureNamed("NewSprite6.png"),
            atlas.textureNamed("NewSprite7.png"),
            atlas.textureNamed("NewSprite8.png")], timePerFrame: 0.2)
        
        spriteWalk = SKAction.repeatActionForever(animation)
        
    }
    
    
}
