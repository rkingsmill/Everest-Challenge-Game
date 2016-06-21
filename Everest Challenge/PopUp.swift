//
//  PopUp.swift
//  Everest Challenge
//
//  Created by Rosalyn Kingsmill on 2016-06-21.
//  Copyright © 2016 Rosalyn Kingsmill. All rights reserved.
//

import UIKit

class PopUp: UIView {
    
    let campImageView = UIImageView (frame: CGRect(x:70, y: 70, width: 300, height: 300))
    let titleLabel = UILabel(frame: CGRect(x: 100, y: 200, width: 100, height: 10))
    let factLabel = UILabel(frame: CGRect(x: 100, y: 215, width: 100, height: 75))
    let okButton = UIButton(frame: CGRect(x: 200, y: 400, width: 50, height: 20))
    
//    override init(frame:CGRect) {
//        
//        //set up self
//        self.frame = frame
//        self.backgroundColor = UIColor.whiteColor()
//        //set up image
//        self.addSubview(campImageView)
//        campImageView.image = UIImage(named: "camping")
//        //set up label
//        self.addSubview(titleLabel)
//        self.addSubview(factLabel)
//        self.addSubview(okButton)
//        
//        customizeButton("Keep Climbing")
//        customizeFact("Congrats on reaching your first Base Camp! Did you know... Mount Everest was first climbed in 1953. The temperature at the summit never rises above freezing, averaging -36˚C in winter and -19˚C in summer. Brrrr.")
//        customizeTitle("First Base Camp")
//        
//    }
    
    func customizeButton(text:String) {
        okButton.titleLabel?.text = text
    }
    
    func customizeTitle(text:String) {
        titleLabel.text = text
    }
    
    func customizeFact(text:String) {
        factLabel.text = text
    }
    
 }