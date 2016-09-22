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
        self.init(imageNamed: "test1.png")
        
        setUpSprite()
        run(spriteWalk)
    }
    
    func setUpSprite(){
        
        let atlas = SKTextureAtlas(named: "PlayerSprite")
        
        let animation = SKAction.animate(with: [
            atlas.textureNamed("test1.png"),
            atlas.textureNamed("test2.png"),
            atlas.textureNamed("test3.png"),
            atlas.textureNamed("test4.png"),
            atlas.textureNamed("test5.png"),
            atlas.textureNamed("test6.png"),
            atlas.textureNamed("test7.png")], timePerFrame: 0.2)
        
        spriteWalk = SKAction.repeatForever(animation)
        
    }
    
    
}
