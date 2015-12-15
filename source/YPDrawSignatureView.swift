//
//  YPDrawSignatureView.swift
//  Draw a signature into an UIView
//
//  Created by Geert-Jan Nilsen on 06/11/14.
//  Copyright (c) 2014 Yuppielabel.com All rights reserved.
//

import UIKit

@IBInspectable
public class YPDrawSignatureView: UIView {
    
    // MARK: - IBInspectable Properties
    @IBInspectable public var lineWidth: CGFloat = 2.0 {
        didSet {
            self.path.lineWidth = lineWidth
        }
    }
    @IBInspectable public var strokeColor: UIColor = UIColor.blackColor()
    @IBInspectable public var signatureBackgroundColor: UIColor = UIColor.whiteColor()
    
    // MARK: - Properties
    private var path = UIBezierPath()
    private var pts = [CGPoint](count: 5, repeatedValue: CGPoint())
    private var ctr = 0
    
    // MARK: - Init
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.backgroundColor = self.signatureBackgroundColor
        self.path.lineWidth = self.lineWidth
    }
    
    // MARK: - Draw
    override public func drawRect(rect: CGRect) {
        self.strokeColor.setStroke()
        self.path.stroke()
    }
    
    // MARK: - Gesture Recognizers
    override public func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let firstTouch = touches.first{
            let touchPoint = firstTouch.locationInView(self)
            self.ctr = 0
            self.pts[0] = touchPoint
        }
    }
    
    override public func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let firstTouch = touches.first{
            let touchPoint = firstTouch.locationInView(self)
            self.ctr++
            self.pts[self.ctr] = touchPoint
            if (self.ctr == 4) {
                self.pts[3] = CGPointMake((self.pts[2].x + self.pts[4].x)/2.0, (self.pts[2].y + self.pts[4].y)/2.0)
                self.path.moveToPoint(self.pts[0])
                self.path.addCurveToPoint(self.pts[3], controlPoint1:self.pts[1], controlPoint2:self.pts[2])
                
                self.setNeedsDisplay()
                self.pts[0] = self.pts[3]
                self.pts[1] = self.pts[4]
                self.ctr = 1
            }
            
            self.setNeedsDisplay()
        }
    }
    
    override public func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if self.ctr == 0{
            let touchPoint = self.pts[0]
            self.path.moveToPoint(CGPointMake(touchPoint.x-1.0,touchPoint.y))
            self.path.addLineToPoint(CGPointMake(touchPoint.x+1.0,touchPoint.y))
            self.setNeedsDisplay()
        } else {
            self.ctr = 0
        }
    }
    
    // MARK: - Helpers
    
    // MARK: Clear the Signature View
    func public clearSignature() {
        self.path.removeAllPoints()
        self.setNeedsDisplay()
    }
    
    // MARK: Save the Signature as an UIImage
    func public getSignature() ->UIImage {
        UIGraphicsBeginImageContext(CGSizeMake(self.bounds.size.width, self.bounds.size.height))
        self.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let signature: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return signature
    }
}
