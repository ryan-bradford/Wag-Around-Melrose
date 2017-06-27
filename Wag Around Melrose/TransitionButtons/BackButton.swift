//
//  BackButton.swift
//  Wag Around Melrose
//
//  Created by Ryan Bradford on 6/19/17.
//  Copyright © 2017 RBradford Studios. All rights reserved.
//

import Foundation
import UIKit

public class BackButton: UIButton {
	
	var superScreen: MainView?
	var toAdd: UIImage?
	
	public init(frame: CGRect, superScreen: MainView, width: Double) {
		super.init(frame: frame)
		let realWidth = width
		self.toAdd = UIImage(named: "backButton.png")
		self.superScreen = superScreen
		self.backgroundColor = UIColor.clear
		self.addTarget(self, action: #selector(BackButton.transitionToLast(_:)), for: .touchUpInside)
		self.toAdd = resizeImage(toAdd!, newWidth: CGFloat(realWidth), newHeight: CGFloat(realWidth))
	}
	
	required public init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	func transitionToLast(_ sender: UIButton!) {
		superScreen?.transitionToLast()
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
