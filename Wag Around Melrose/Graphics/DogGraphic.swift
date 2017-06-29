//
//  MGraphic.swift
//  MHSStats
//
//  Created by Ryan on 3/11/16.
//  Copyright © 2016 ryanb3. All rights reserved.
//

import Foundation
import UIKit

open class DogGraphic : UIView {
    
    var toAdd: UIImage?

    public init(screenWidth: Double, y: Double) {
        self.toAdd = UIImage(named: "dog.png")
        let realWidth = Double(150*GlobalVariables.X_SCALE)
        let halfScreenWidth = Double(screenWidth / 2)
        let halfWidth = Double(realWidth) / 2.0
        super.init(frame: CGRect(x: (halfScreenWidth - halfWidth), y: y, width: (realWidth), height: (realWidth)))
        self.toAdd = resizeImage(toAdd!, newWidth: CGFloat(realWidth), newHeight: CGFloat(realWidth))
        self.backgroundColor = UIColor.clear
    }
    
    required public init(coder aDecoder: NSCoder) {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    }
    
    override open func draw(_ rect: CGRect) {
        toAdd?.draw(in: CGRect(x: 0, y: 0, width: toAdd!.size.width, height: toAdd!.size.height))
    }

    func resizeImage(_ image: UIImage, newWidth: CGFloat, newHeight: CGFloat) -> UIImage {
        
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
}
