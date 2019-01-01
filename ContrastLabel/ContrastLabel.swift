//
//  ContrastLabel.swift
//  ContrastLabel
//
//  Created by Slavenko on 1/1/19.
//  Copyright © 2019 Slavenko. All rights reserved.
//

import Foundation
import UIKit

class ContrastLabel: UILabel
{
    public var contrastView: UIView?
    
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        
        //by default, make the contrast start right in the middle of the label
        var half = CGRect(x: rect.midX, y: 0, width: rect.width/2, height: rect.height)
        
        //if we want to create contrast on the label
        //in regards to some other view below it
        if let mask = contrastView
        {
            let dot = mask.convert(mask.bounds.origin, to: self)
            
            var y = dot.y
            if y < 0
            {
                y = 0
            }
            
            half = CGRect(x: dot.x, y: y, width: mask.frame.size.width, height: mask.frame.size.height + dot.y)
        }
        
        //By default make contrast black/white
        context?.setFillColor(UIColor.white.cgColor)
        context?.fill(rect)
        
        context?.setFillColor(UIColor.black.cgColor)
        context?.fill(half)
        
        context?.setBlendMode(.difference)
        
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
    }
}
