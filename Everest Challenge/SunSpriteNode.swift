//
//  SunSpriteNode.swift
//  Everest Challenge
//
//  Created by Yasmin Ahmad on 2016-06-20.
//  Copyright © 2016 Rosalyn Kingsmill. All rights reserved.
//

import Foundation
import SpriteKit

class SunSpriteNode: SKSpriteNode {
    
    var sunShine: SKAction!
    var sunSprite: SKSpriteNode!
    
    convenience init(){
        self.init(imageNamed: "sunSprite1.png")
        
        setUpSun()
        run(sunShine)
    }
    
    func setUpSun(){
        sunSprite = SKSpriteNode(imageNamed: "sunSprite1.png")
        
        let atlas1 = SKTextureAtlas(named: "SunSprite")
        
        let animation1 = SKAction.animate(with: [
            atlas1.textureNamed("Sun1"),
            atlas1.textureNamed("Sun2")], timePerFrame: 0.8)
        
        sunShine = SKAction.repeatForever(animation1)
        
        
        
        
    }
        
}
