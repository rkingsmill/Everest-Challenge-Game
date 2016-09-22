//
//  ScoreboardLabelLetter.swift
//  Outscore
//
//  Created by Noam on 9/8/15.
//  Copyright (c) 2015 ICOgroup. All rights reserved.
//

import Foundation
import UIKit
import pop

enum Section {
    case upper
    case lower
}

protocol ScoreboardLabelLetterProtocol {
    
    func didFinishAnimatingLetter(_ letter: ScoreboardLabelLetter)
}

open class ScoreboardLabelLetter: UIView {
    
    var theNextLetter = ""
    var font : UIFont!
    var letterIndex = 0
    var delegate : ScoreboardLabelLetterProtocol?
    
    fileprivate var theFirstLetter = ""
    fileprivate var imageViewUpperHalf = UIImageView()
    fileprivate var imageViewLowerHalf = UIImageView()
    fileprivate var imageViewUpperHalfNextLetter = UIImageView()
    fileprivate var imageViewLowerHalfNextLetter = UIImageView()
    fileprivate var bottomShadowLayer = CAGradientLayer()
    fileprivate var topShadowLayer = CAGradientLayer()
    
    fileprivate var label = UILabel()
    fileprivate var imageview = UIImageView()
    
    //frames
    fileprivate var rectUpperHalf = CGRect.zero
    fileprivate var rectLowerHalf = CGRect.zero
    fileprivate var originUpperHalf = CGPoint.zero
    fileprivate var originLowerHalf = CGPoint.zero
    
    
    override init(frame:CGRect) {
        
        super.init(frame: frame)
        
        //frames
        rectUpperHalf = CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height * 0.5)
        rectLowerHalf = CGRect(x: 0, y: frame.size.height * 0.5, width: frame.size.width, height: frame.size.height * 0.5)
        
        originUpperHalf = CGPoint(x: 0, y: frame.size.height * -0.01)
        originLowerHalf = CGPoint(x: 0, y: frame.size.height * 0.51)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func renderScoreboardLabelLetters(_ backgroundImage:UIImage, textColor:UIColor, letter:String, nextLetter:String) {
        
        backgroundColor = UIColor.clear
        
        label.frame = bounds
        label.font = font
        label.textAlignment = NSTextAlignment.center
        label.textColor = textColor
        
        label.text = letter
        
        imageview.frame = label.frame
        imageview.contentMode = UIViewContentMode.scaleAspectFit
        imageview.image = backgroundImage
        imageview.clipsToBounds = true
        imageview.layer.borderColor = UIColor.black.cgColor
        imageview.layer.borderWidth = 0.1
        
        imageview.addSubview(label)
        
        
        
        theNextLetter = nextLetter
        theFirstLetter = letter
        
        renderNextLetterImages()
        renderCurrentLetterImages()
    }
    
    
    /**
    life cycle:
    
    imageviews with next/empty letter
    
    imageviews with current letter
    
    set next letter to imageviews underneeth
    perform flip animation
    
    flip complete: remove current letter image views
    
    add Imageviews with currentLetter
    */
    
    
    
    
    
    func renderCurrentLetterImages() {
        
        imageViewUpperHalf = UIImageView(frame: rectUpperHalf)
        imageViewUpperHalf.layer.anchorPoint = CGPoint(x: 0.5, y: 1.02);
        imageViewUpperHalf.layer.position = CGPoint(x: imageViewUpperHalf.frame.width * 0.5, y: imageViewUpperHalf.frame.height * 0.5)
        imageViewUpperHalf.layer.mask = maskForRectInSection(Section.upper, rect: imageViewUpperHalf.bounds)
        imageViewUpperHalf.frame.origin = originUpperHalf
        
        imageViewUpperHalf.contentMode = UIViewContentMode.center
        imageViewUpperHalf.backgroundColor = UIColor.white

        imageViewUpperHalf.layer.transform = transform3D()
        
        let imageTop = imageHalfForSection(Section.upper, theView:imageview)
        imageViewUpperHalf.image = imageTop
        
        
        //top Shadow
        topShadowLayer.frame = imageViewUpperHalf.bounds
        topShadowLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        topShadowLayer.opacity = 0
        
        imageViewUpperHalf.layer.addSublayer(topShadowLayer)

        
        
        imageViewLowerHalf = UIImageView(frame: rectLowerHalf)
        imageViewLowerHalf.frame.origin = originLowerHalf
        imageViewLowerHalf.layer.mask = maskForRectInSection(Section.lower, rect: imageViewLowerHalf.bounds)
        
        imageViewLowerHalf.contentMode = UIViewContentMode.center
        imageViewLowerHalf.backgroundColor = UIColor.white

        let imageBottom = imageHalfForSection(Section.lower, theView:imageview)
        imageViewLowerHalf.image = imageBottom
        
        //bottom Shadow
        bottomShadowLayer.frame = imageViewLowerHalf.bounds
        bottomShadowLayer.colors = [UIColor.black.cgColor, UIColor.clear.cgColor]
        bottomShadowLayer.opacity = 0
        
        imageViewLowerHalf.layer.addSublayer(bottomShadowLayer)
        
        addSubview(imageViewLowerHalf)
        addSubview(imageViewUpperHalf)
    }
    
    
    func renderNextLetterImages() {
        
        imageViewUpperHalfNextLetter.frame = rectUpperHalf
        imageViewUpperHalfNextLetter.frame.origin = originUpperHalf
        imageViewUpperHalfNextLetter.contentMode = UIViewContentMode.center
        imageViewUpperHalfNextLetter.backgroundColor = UIColor.white
        imageViewUpperHalfNextLetter.layer.mask = maskForRectInSection(Section.upper, rect: imageViewUpperHalfNextLetter.bounds)
        
        imageViewLowerHalfNextLetter.frame = rectLowerHalf
        imageViewLowerHalfNextLetter.frame.origin = originLowerHalf
        imageViewLowerHalfNextLetter.contentMode = UIViewContentMode.center
        imageViewLowerHalfNextLetter.backgroundColor = UIColor.white
        imageViewLowerHalfNextLetter.layer.mask = maskForRectInSection(Section.lower, rect: imageViewLowerHalfNextLetter.bounds)

        addSubview(imageViewUpperHalfNextLetter)
        addSubview(imageViewLowerHalfNextLetter)
    }
    
    
    func prepareForNextLetter() {
        
        label.text = theNextLetter
        
        let imageTop = imageHalfForSection(Section.upper, theView:imageview)
        imageViewUpperHalfNextLetter.image = imageTop

        let imageBottom = imageHalfForSection(Section.lower, theView:imageview)
        imageViewLowerHalfNextLetter.image = imageBottom
    }
    
    func flipLetterAfterWait(_ wait:CFTimeInterval) {
        
        flipToLetterAfterWait(theNextLetter, wait: wait)
    }
    
    func flipToLetterAfterWait(_ letter:String, wait:CFTimeInterval)  {
        
        theNextLetter = letter
        
        prepareForNextLetter()
        
        let rotationAnimation = POPSpringAnimation(propertyNamed: kPOPLayerRotationX)
        rotationAnimation?.springBounciness = 5.0
        rotationAnimation?.dynamicsMass = 2.0
        rotationAnimation?.dynamicsTension = 200
        
        
        rotationAnimation?.toValue = 2.8
        rotationAnimation?.delegate = self;
        rotationAnimation?.beginTime = CACurrentMediaTime() + wait
//        print("\nbeginTime = \(rotationAnimation.beginTime)")
        rotationAnimation?.completionBlock = {(animation, finished) in
            
            if (finished == true) {
                
                self.imageViewUpperHalf.layer.pop_removeAllAnimations()
                self.prepareForNextLetter()
                self.renderCurrentLetterImages()
            }
        }

        imageViewUpperHalf.layer.pop_add(rotationAnimation, forKey: "rotationAnimation")
    }
    
    
    func pop_animationDidApply(_ anim: POPAnimation!) {
        
        
        if let currentValue = (anim.value(forKey: "currentValue") as AnyObject).floatValue {
            
            if (currentValue < 1.4) {
                
                CATransaction.begin()
                CATransaction.setValue(kCFBooleanTrue, forKey: kCATransactionDisableActions)
                self.bottomShadowLayer.opacity = Float(currentValue)/Float(2.8)
                self.topShadowLayer.opacity = Float(currentValue)/Float(2.8)
                CATransaction.commit()
            }else if (currentValue > 1.4 && currentValue < 1.7) {
                
                imageViewLowerHalf.removeFromSuperview()


            }else {
                CATransaction.begin()
                CATransaction.setValue(kCFBooleanTrue, forKey: kCATransactionDisableActions)
                self.bottomShadowLayer.opacity = 1 - Float(currentValue)/Float(2.8)
                self.topShadowLayer.opacity = 1 - Float(currentValue)/Float(2.8)
                CATransaction.commit()
            }
        }
        
    }
    
    func removeImageViews() {
        
        imageViewUpperHalf.removeFromSuperview()
    }
    
    func pop_animationDidReachToValue(_ anim: POPAnimation!) {
        
        self.label.text = theNextLetter
        removeImageViews()
        delegate?.didFinishAnimatingLetter(self)
    }
    
    func imageHalfForSection(_ section:Section ,theView:UIView) -> UIImage {
        
        //taking a snapShot
        UIGraphicsBeginImageContext(theView.frame.size)
        theView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let screenShot = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        //returning only upper half
        let rect = (section == Section.upper) ? CGRect(x: 0, y: 0, width: theView.frame.size.width, height: theView.frame.size.height * 0.5) : CGRect(x: 0, y: theView.frame.size.height * 0.5, width: theView.frame.size.width, height: theView.frame.size.height * 0.5)
        
        
        let imageRef = screenShot!.cgImage!.cropping(to: rect)
        let half = UIImage(cgImage: imageRef!)
        
        return half
    }
    
    
    
    func transform3D() ->CATransform3D {
        
        var transform = CATransform3DIdentity
        transform.m34 = CGFloat(2.5) / CGFloat(500)
        return transform
    }
    
    
    func maskForRectInSection(_ section:Section ,rect:CGRect) -> CAShapeLayer {
        
        let layerMask = CAShapeLayer()
        let corners = (section == Section.upper) ? UIRectCorner.topLeft.union(UIRectCorner.topRight) : UIRectCorner.bottomLeft.union(UIRectCorner.bottomRight)
        layerMask.path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: 5, height: 5)).cgPath
        
        return layerMask
    }
    
}

















