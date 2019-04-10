//
//  ViewController.swift
//  Signature Demo
//
//  Created by Ganesh Balaji Pawar on 24/03/19.
//  Copyright © 2019 Ganesh Balaji Pawar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet var signatureView: YPDrawSignatureView!
    @IBOutlet var signatureImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signatureView.delegate =  self
    }

    // Function for clearing the content of signature view
    @IBAction func clearSignature(_ sender: UIButton) {
        // This is how the signature gets cleared
        self.signatureView.clear()
    }
    
    // Function for saving signature
    @IBAction func saveSignature(_ sender: UIButton) {
        // Getting the Signature Image from self.drawSignatureView using the method getSignature().
        if let signatureImage = self.signatureView.getSignature(scale: 10) {
            
            // Saving signatureImage from the line above to the Photo Roll.
            // The first time you do this, the app asks for access to your pictures.
            //UIImageWriteToSavedPhotosAlbum(signatureImage, nil, nil, nil)
            signatureImageView.image = signatureImage
            
            let imageData = signatureImage.jpegData(compressionQuality: 1)
            let imageSize = imageData?.count
            print("imageSize : \(imageSize!)")
            print("imageSize /1024 : \((imageSize! / 1024) / 1024)")
            let base64Image = imageData?.base64EncodedString()
            print("base64Image size : \(base64Image?.count)")
            // Since the Signature is now saved to the Photo Roll, the View can be cleared anyway.
//            self.signatureView.clear()
        }
    }
}

extension ViewController: YPSignatureDelegate{
    
    // MARK: - Delegate Methods
    
    // The delegate functions gives feedback to the instanciating class. All functions are optional,
    // meaning you just implement the one you need.
    
    // didStart(_ view: YPDrawSignatureView) is called right after the first touch is registered in the view.
    // For example, this can be used if the view is embedded in a scroll view, temporary
    // stopping it from scrolling while signing.
    func didStart(_ view: YPDrawSignatureView) {
        print("Started Drawing")
    }
    
    // didFinish(_ view: YPDrawSignatureView) is called rigth after the last touch of a gesture is registered in the view.
    // Can be used to enabe scrolling in a scroll view if it has previous been disabled.
    func didFinish(_ view: YPDrawSignatureView) {
        print("Finished Drawing")
    }
}

