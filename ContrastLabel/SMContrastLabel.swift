//
//  SMContrastLabel.swift
//  SMContrastLabel
//
//  Created by Slavenko on 12/30/18.
//  Copyright © 2018 Slavenko. All rights reserved.
//

import Foundation
import UIKit

class SMContrastLabel: UILabel
{
	public var contrastView: Any?
    
//    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
//        super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
//
//        print("\(keyPath): \(change?[.newKey])")
//        return
//    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
		let displayLink = CADisplayLink(target: self, selector: #selector(update))
		displayLink.add(to: .current, forMode: .common)
    }
    
    @objc func update() {
		//print(contrastView?.layer.presentation()?.frame.origin.x)
		self.setNeedsDisplay()
        //self.draw(self.frame)
    }
    
    override func draw(_ rect: CGRect) {
        //self.addObserver(contrastView!, forKeyPath: "center", options: NSKeyValueObservingOptions.new, context: nil)


        
        //if we want to create contrast on the label
        //in regards to some other view below
        if let mask = contrastView as? UIView
        {
			let context = UIGraphicsGetCurrentContext()

			//by default, make the contrast start right in the middle of the label
			var half = CGRect(x: rect.midX, y: 0, width: rect.width/2, height: rect.height)


            var point = mask.bounds.origin
            if (mask.layer.presentation() != nil) {
                point = (mask.layer.presentation()?.bounds.origin)!
			} else {
				print("SUUUUUPPPPP")
			}
            var dot = mask.convert(point, to: self)

			dot.x = mask.layer.presentation()?.frame.origin.x ?? dot.x

            var y = dot.y
            if y < 0
            {
                y = 0
            }
            
            half = CGRect(x: dot.x, y: y, width: mask.frame.size.width, height: mask.frame.size.height + dot.y)

			//By default make contrast black/white
			context?.setFillColor(UIColor.white.cgColor)
			context?.fill(rect)

			context?.setFillColor(mask.backgroundColor?.cgColor ?? UIColor.clear.cgColor)
			context?.fill(half)

			context?.setBlendMode(CGBlendMode.difference)

			let text = self.text

			let paragraph = NSMutableParagraphStyle()
			paragraph.alignment = .center

			let textStyle = NSMutableParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
			textStyle.alignment = self.textAlignment

			let attributeDict: [NSAttributedString.Key : Any] = [
				.font: self.font!,
				.foregroundColor: UIColor.white,
				.paragraphStyle: textStyle
			]

			text?.draw(in: self.bounds, withAttributes: attributeDict)
		} else {
			super.draw(rect)
		}
    }
}
