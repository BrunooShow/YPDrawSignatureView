//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

class MyViewController : UIViewController, YPSignatureDelegate {
    let signature = YPDrawSignatureView()
    
    override func viewDidLoad() {
        setView()
        signature.delegate = self
    }
    
    private func setView() {
        let view = UIView()
        view.backgroundColor = .gray
        addSignatureViewTo(view)
        addClearButtonTo(view)
        addImageButtonTo(view)
        self.view = view
    }
    
    private func addSignatureViewTo(_ view: UIView) {
        signature.frame = CGRect(x: 20, y: 200, width: 340, height: 200)
        
        signature.strokeWidth = 2
        signature.strokeColor = .red
        signature.backgroundColor = .white
        view.addSubview(signature)
    }
    
    private func addClearButtonTo(_ view: UIView) {
        let clearButton = UIButton(frame: CGRect(x: 20, y: 450, width: 100, height: 40))
        clearButton.backgroundColor = .red
        clearButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(clear)))
        view.addSubview(clearButton)
    }
    
    private func addImageButtonTo(_ view: UIView) {
        let imageButton = UIButton(frame: CGRect(x: 140, y: 450, width: 100, height: 40))
        imageButton.backgroundColor = .blue
        imageButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(getImage)))
        view.addSubview(imageButton)
    }
    
    @objc func clear() {
        signature.clear()
        view.backgroundColor = .gray
    }
    
    @objc func getImage() {
        if signature.doesContainSignature {
            view.backgroundColor = .green
        } else {
            view.backgroundColor = .red
        }
    }
    
    func didStart(_ view : YPDrawSignatureView) {
        print("Start")
    }
    func didFinish(_ view : YPDrawSignatureView) {
        print("Finish")
    }
    
    func didValidate(_ view: YPDrawSignatureView, path: UIBezierPath) -> Bool {
        let bounds = path.bounds
        return bounds.height > 20 && bounds.width > 20
    }
    
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
