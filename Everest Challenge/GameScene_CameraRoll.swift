//
//  GameScene_CameraRoll.swift
//  Everest Challenge
//
//  Created by Rosalyn Kingsmill on 2016-06-20.
//  Copyright © 2016 Rosalyn Kingsmill. All rights reserved.
//

import Foundation
import SpriteKit

extension GameScene {
    
    func getPhotoFromSource(_ source:UIImagePickerControllerSourceType) {
        
        //change photo library to camera
        if UIImagePickerController.isSourceTypeAvailable(source)
        {
        
        let imagePicker = UIImagePickerController()
        //imagePicker.modalPresentationStyle = .CurrentContext
        imagePicker.delegate = self
        imagePicker.sourceType = source
        imagePicker.allowsEditing = true
            
            if (source == .camera) {
        imagePicker.cameraDevice = .front
            }
        
        let vc:UIViewController = self.view!.window!.rootViewController!
        vc.present(imagePicker, animated: true, completion: nil)
    }
}
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if (picker.sourceType == UIImagePickerControllerSourceType.photoLibrary || picker.sourceType == UIImagePickerControllerSourceType.camera) {
            
            //do something with image
            if let cameraRollPicture = info[UIImagePickerControllerEditedImage] as? UIImage {
               
                if let deleteNode:SKNode = self.childNode(withName: "CameraRollPicture") {
                    deleteNode.removeFromParent()
                }
                
                defaultss.set(UIImagePNGRepresentation(cameraRollPicture), forKey: "CameraRollPicture")
                
                if (maskingCameraRollChoice == false) {
                    
                    //if we aren't going to mask it
                    
                    let tex:SKTexture = SKTexture(image: cameraRollPicture)
                    face!.texture = tex
                    
                    /*
                    let newImage:SKSpriteNode = SKSpriteNode(texture: tex)
                    newImage.name = "CameraRollPicture"
                    self.addChild(newImage)
                    
                    if let face = face {
                        newImage.zPosition = face.zPosition
                        //newImage.size = face.size
                        newImage.position = face.position
                    }
                     */
                    
                } else {
                    
                    let newMaskString:String = "{ 0, 0 }"
                    defaultss.set(newMaskString, forKey:"MaskOffset")
                    
                    let wait:SKAction = SKAction.wait(forDuration: 1/60)
                    let run:SKAction = SKAction.run{
                        self.revealMaskedCameraRollImage();
                    }
                    let seq:SKAction = SKAction.sequence([wait, run])
                    self.run(seq)
                }
            }
        }
        
        picker.dismiss(animated: true, completion: nil)
        picker.delegate = nil
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
        picker.delegate = nil
    }
    
    func revealMaskedCameraRollImage() {
        if let imageDataAsDefaults:Data = defaultss.object(forKey: "CameraRollPicture") as? Data {
            let someImage: UIImage = UIImage(data:imageDataAsDefaults)!
            
            if let face = face {
                let texture:SKTexture = SKTexture(image:someImage)
                //face.hidden = false
                
                
                face.texture = texture
                /*
                let newImage: SKSpriteNode = SKSpriteNode(texture: tex)
                newImage.name = "AdjustMask"
                //newImage.size = face.size
                newImage.position = CGPoint(x: 0, y: 0)
                newImage.zPosition = face.zPosition
                
                let cropNode:SKCropNode = SKCropNode()
                
                let actualMask: SKShapeNode = SKShapeNode(circleOfRadius: 50)
                    
                    //SKShapeNode(texture: SKTexture(imageNamed: "FaceMask"), color: SKColor.clearColor())
                cropNode.maskNode = actualMask
                cropNode.addChild(newImage)
                cropNode.zPosition = face.zPosition
                cropNode.position = CGPoint(x: 0, y: 0)
                face.addChild(cropNode)
                cropNode.name = "CameraRollPicture"
                face.alpha = 1
                */
                
            }
        }
    }
}
