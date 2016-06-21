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
        
        self.backgroundColor = UIColor.clearColor()
  
        campImageView.image = UIImage(named: "camping")
        
        self.layer.shadowColor = UIColor.whiteColor().CGColor
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = CGSizeZero
        self.layer.shadowRadius = 10
    }
    
    func customizeButton(text:String) {
        //okButton.titleLabel?.text = text
        //self.layoutIfNeeded()
        okButton.setTitle(text, forState: UIControlState.Normal)
    }
    
    func customizeTitle(text:String) {
        titleLabel.text = text
    }
    
    func customizeFact(text:String) {
        factLabel.text = text
    }
    
 }