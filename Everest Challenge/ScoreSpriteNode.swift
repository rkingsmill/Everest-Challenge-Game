//
//  ScoreSpriteNode.swift
//  Everest Challenge
//
//  Created by Yasmin Ahmad on 2016-06-20.
//  Copyright © 2016 Rosalyn Kingsmill. All rights reserved.
//

import Foundation
import SpriteKit



class ScoreSpriteNode: SKNode {

    var scoreBoard : SKShapeNode
    var scoreLabels = [SKLabelNode]()
    
    
    override init() {
        
        scoreBoard = SKShapeNode(rectOfSize: CGSize(width: 500, height: 220))
        //scoreBoard = SKShapeNode!(fileNamed: "OrangeBackground.png")
        scoreBoard.strokeColor = UIColor.clearColor()
        scoreBoard.fillColor = UIColor.clearColor()
        
        super.init()

        addChild(scoreBoard)
        
        scoreLabels.append(SKLabelNode(fontNamed: "LCD Solid"))
        scoreLabels[0].text = "DISTANCE TRAVELLED:"
        scoreLabels[0].fontColor = UIColor.whiteColor()
        scoreLabels[0].fontSize = 25
        scoreLabels[0].position = CGPoint(x: -205, y: 80)
        scoreLabels[0].horizontalAlignmentMode = .Left
        scoreBoard.addChild(scoreLabels[0])
        
        scoreLabels.append(SKLabelNode(fontNamed: "LCD Solid"))
        scoreLabels[1].text = "NEXT CAMP:"
        scoreLabels[1].fontColor = UIColor.whiteColor()
        scoreLabels[1].fontSize = 25
        scoreLabels[1].position = CGPoint(x: -205, y: 40)
        scoreLabels[1].horizontalAlignmentMode = .Left
        scoreBoard.addChild(scoreLabels[1])
        
        scoreLabels.append(SKLabelNode(fontNamed: "LCD Solid"))
        scoreLabels[2].text = "TOTAL STEPS:"
        scoreLabels[2].fontColor = UIColor.whiteColor()
        scoreLabels[2].fontSize = 25
        scoreLabels[2].position = CGPoint(x: -205, y: 0)
        scoreLabels[2].horizontalAlignmentMode = .Left
        scoreBoard.addChild(scoreLabels[2])
        
        scoreLabels.append(SKLabelNode(fontNamed: "LCD Solid"))
        scoreLabels[3].text = "CALORIES:"
        scoreLabels[3].fontColor = UIColor.whiteColor()
        scoreLabels[3].fontSize = 25
        scoreLabels[3].position = CGPoint(x: -205, y: -40)
        scoreLabels[3].horizontalAlignmentMode = .Left
        scoreBoard.addChild(scoreLabels[3])
        
        scoreLabels.append(SKLabelNode(fontNamed: "LCD Solid"))
        scoreLabels[4].text = "START DATE:"
        scoreLabels[4].fontColor = UIColor.whiteColor()
        scoreLabels[4].fontSize = 25
        scoreLabels[4].position = CGPoint(x: -205, y: -80)
        scoreLabels[4].horizontalAlignmentMode = .Left
        scoreBoard.addChild(scoreLabels[4])
        
        //        scoreLabels.append(SKLabelNode(fontNamed: "LCD Solid"))
        //        scoreLabels[5].text = "Total Days: 5"
        //        scoreLabels[5].fontColor = UIColor.blueColor()
        //        scoreLabels[5].fontSize = 30
        //        scoreLabels[5].position = CGPoint(x: -120, y: -105)
        //        scoreboard.addChild(scoreLabels[5])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}