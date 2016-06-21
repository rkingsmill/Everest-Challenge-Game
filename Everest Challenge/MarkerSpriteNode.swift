//
//  MarkerSprite.swift
//  Everest Challenge
//
//  Created by Yasmin Ahmad on 2016-06-21.
//  Copyright © 2016 Rosalyn Kingsmill. All rights reserved.
//

import Foundation
import SpriteKit

class MarkerSpriteNode: SKSpriteNode {
    
    var markerWave: SKAction!
    var markerSprite: SKSpriteNode!
    
    convenience init(){
        self.init(imageNamed: "PinkFlag1")
        
        setUpMarker()
        runAction(markerWave)
    }
    
    func setUpMarker(){
        markerSprite = SKSpriteNode(imageNamed: "PinkFlag1.png")
        
        let atlas3 = SKTextureAtlas(named: "PinkFlagSprite")
        
        let animationMarker = SKAction.animateWithTextures([
            atlas3.textureNamed("PinkFlag1"),
            atlas3.textureNamed("PinkFlag2"),
            atlas3.textureNamed("PinkFlag3")], timePerFrame: 0.5)
        
        markerWave = SKAction.repeatActionForever(animationMarker)
        
        
        
        
    }
    
}
