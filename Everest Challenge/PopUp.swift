//
//  PopUp.swift
//  Everest Challenge
//
//  Created by Rosalyn Kingsmill on 2016-06-21.
//  Copyright © 2016 Rosalyn Kingsmill. All rights reserved.
//

import UIKit

class PopUp: UIView {
    
    @IBOutlet var campImageView: UIImageView!
    @IBOutlet var titleLabel : UILabel!
    @IBOutlet var factLabel : UILabel!
    @IBOutlet var okButton : UIButton!
    @IBOutlet var fireImageView: UIImageView!
    @IBOutlet var personImageView: UIImageView!
    
//    override init(frame:CGRect) {
//        super.init(frame: frame)
//        //set up self
//        self.frame = frame
//        
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    func setupPopUp() {
        
        self.backgroundColor = UIColor.clear

        //round pop up corners
//        self.layer.cornerRadius = 2.0
//        self.clipsToBounds = true
        //set shadow and round it
        self.layer.shadowColor = UIColor.white.cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowRadius = 15
        self.layer.masksToBounds = false
        self.customizeImages()
    }
    
    func customizeButton(_ text:String) {
        //okButton.titleLabel?.text = text
        //self.layoutIfNeeded()
        okButton.setTitle(text, for: UIControlState())
        okButton.titleLabel?.font = UIFont(name: "LCD Solid", size: 14)
    }
    
    func customizeTitle(_ text:String) {
        titleLabel.text = text
        titleLabel.font = UIFont(name: "LCD Solid", size: 14)
    }
    
    func customizeFact(_ text:String) {
        factLabel.text = text
        factLabel.font = UIFont(name: "LCD Solid", size: 10)
    }
    
    func customizeImages() {
        //set image
        campImageView.image = UIImage(named: "PixelatedTent")
        //round image corners
//        campImageView.layer.cornerRadius = 8.0
//        campImageView.clipsToBounds = true
        fireImageView.image = UIImage(named: "PixelatedFire")
        personImageView.image = UIImage(named: "newwalkingsprite")
        
    }
 }
