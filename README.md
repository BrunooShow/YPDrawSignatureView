# YPDrawSignatureView
![Image of Swift Version Badge](https://img.shields.io/badge/Swift-4.2-lightgrey.svg)
Simple class for capturing signatures, with custom validator.

## Swift 4

The class is compatible with Swift 4.2.

## Legacy Support

The class is not backwards compatible. Please download previous releases if you need support for earlier versions of Swift. Legacy versions will not be updated.


## Usage

Add a new `UIView` where you want the signature capture field. Set its class to `YPDrawSignatureView`, and connect it to an `@IBOutlet` property in your `UIViewController`. For saving and clearing the signature, add two buttons to your view controller. Hook each button up to an `@IBAction` function.

![ScreenShot](ibss.png?raw=true "Interface Builder Attributes Inspector panel")

With the view selected, choose the IB Attributes Inspector panel to set custom values, or set them in code where you initialise the signature view.


## New Feature

On ground of popular demand, added signature export as Vector Path in PDF Data Format.


#### Methods

* `clear()`

Clears signature

* `getSignature()`

Returns signature with bounds of YPDrawSignatureView instance

* `getCroppedSignature()`

Returns signature with bounds of signature

* `getPDFSignature()`
Returns signature as Vector Path PDF Data Format

#### Properties

* `doesContainSignature: Bool`

This is a computed read-only property returning `true` if the view actually contains a signature

* `strokeWidth: CGFloat`

Sets the width of the signature stroke

* `strokeColor: UIColor`

Sets the UIColor of the signature stroke


#### Optional Protocol Methods

* `didStart(_ view: YPDrawSignatureView)`

Notifies the delegate when someone starts a stroke in the view. 

* `didFinish(_ view: YPDrawSignatureView)`

Notifies the delegate when someone finishes a stroke in the view

* `didValidate(_ view: YPDrawSignatureView, path: UIBezierPath) -> Bool`

Use the the defined validation when call doesContainSignature property

#### Example Code

The following sample code checks if there is a signature in the view before getting it.

```
class ViewController: UIViewController, YPSignatureDelegate {
    
    // Connect this Outlet to the Signature View
    @IBOutlet weak var signatureView: YPDrawSignatureView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Setting this view controller as the signature view delegate, so the didStart(),
        // didFinish() and didValidate() methods below in the delegate section are called.
        signatureView.delegate = self
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

    // when doesContainSignature called and path different than empty, didValidate() is trigged
    // is called rigth after the last touch of a gesture is registered in the view.
    // This example validate if the drawing is bigger than 20x20
    func didValidate(_ view: YPDrawSignatureView, path: UIBezierPath) -> Bool {
        let bounds = path.bounds
        return bounds.height > 20 && bounds.width > 20
    }
}
```

## Example Project

Check out the example project for more information on how to save signatures and how to clear the signature view.

## Installation

Add YPDrawSignature.swift to your project

## Support and Issues

GitHub Issues are for filing **bug reports** and **feature requests** only. Get support from the community over at [StackOverflow](http://stackoverflow.com/search?q=YPDrawSignatureView), or contact the author directly for paid support.

## Original Author

[Geert-Jan Zwart](mailto:gj.zwart@appfact.com) [Appfact](http://appfact.no)

## Contributors

* [TyrantFox](https://github.com/TyrantFox).
* [gingofthesouth](https://github.com/gingofthesouth).
* [AndreasLey](https://github.com/andreasley).
* [Andrew Carvajal](https://github.com/andrewcar).
* [Steve Botello](https://github.com/xsteviex).

## License

YPDrawSignatureView is available under the MIT license. See the [LICENSE](LICENSE) file for more info. Feel free to fork and modify.

## Update history

### v1.3 - 3/12/19

* Added support for custom validator.

### v1.2 - 7/4/18

* Added support for multiple signature views.

#### v1.1.3 - 3/30/18

* Minor bugfix.

#### v1.1.2 - 6/16/17

* Minor bugfix.

#### v1.1.1 - 5/23/17

* Bugfix

#### v1.1 - 5/3/17

* Added PDF support for exporting signature as high resolution vector graphics
* Deprecated methods and properties are properly marked
* Cleaning up method naming
* Delegate methods are now optional
* Sample project updated to latest settings

#### v1.0.1 - 5/2/17

* Minor bugfix

#### v1.0 - 9/12/16

* More Swifty API
* Supports Swift 3
