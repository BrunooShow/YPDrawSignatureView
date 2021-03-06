// Forked From https://github.com/GJNilsen/YPDrawSignatureView/blob/master/LICENSE (Thank you!)
// This Fork Contais delegate that expose a validator, so you can do your validation as you want
// YPDrawSignatureView is open source
// Version 1.2.0
//
// Copyright (c) 2014 - 2018 The YPDrawSignatureView Project Contributors
// Available under the MIT license
//
// https://github.com/BrunooShow/YPDrawSignatureView/blob/master/LICENSE   License Information

import UIKit

class ViewController: UIViewController, YPSignatureDelegate {
    
    // Connect this Outlet to the Signature View
    @IBOutlet weak var signatureView: YPDrawSignatureView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Setting this view controller as the signature view delegate, so the didStart(_ view: YPDrawSignatureView) and
        // didFinish(_ view: YPDrawSignatureView) methods below in the delegate section are called.
        signatureView.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
            UIImageWriteToSavedPhotosAlbum(signatureImage, nil, nil, nil)
            
            // Since the Signature is now saved to the Photo Roll, the View can be cleared anyway.
            self.signatureView.clear()
        }
    }
    
    // MARK: - Delegate Methods
    
    // The delegate functions gives feedback to the instanciating class. All functions are optional,
    // meaning you just implement the one you need.
    
    // didStart() is called right after the first touch is registered in the view.
    // For example, this can be used if the view is embedded in a scroll view, temporary
    // stopping it from scrolling while signing.
    func didStart(_ view : YPDrawSignatureView) {
        print("Started Drawing")
    }
    
    // didFinish() is called rigth after the last touch of a gesture is registered in the view.
    // Can be used to enabe scrolling in a scroll view if it has previous been disabled.
    func didFinish(_ view : YPDrawSignatureView) {
        print("Finished Drawing")
    }
    
    // when doesContainSignature called and path different than empty, didValidate() is trigged
    // is called rigth after the last touch of a gesture is registered in the view.
    // This example validate if the drawing is bigger than 20x20
    func didValidate(_ view: YPDrawSignatureView, path: UIBezierPath) -> Bool {
        let bounds = path.bounds
        return bounds.height > 20 && bounds.width > 20
    }
}
