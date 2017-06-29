//
//  SubmitButton.swift
//  Wag Around Melrose
//
//  Created by Ryan Bradford on 6/19/17.
//  Copyright © 2017 RBradford Studios. All rights reserved.
//

import Foundation
import UIKit

public class SubmitButton: UIButton {
	
	var superScreen: MainView?
	var submitGif: UIImageView?
	var width: Double?
	var height: Double?
	var pressed = false
	public init(frame: CGRect, superScreen: MainView) {
		super.init(frame: frame)
		self.superScreen = superScreen
		self.backgroundColor = UIColor.red
		self.addTarget(self, action: #selector(SubmitButton.submit(_:)), for: .touchUpInside)
		initGif()
	}
	
	required public init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	override public func draw(_ rect: CGRect) {
		
	}
	
	func submit(_ sender: UIButton!) {
		if(!pressed) {
			pressed = true
			superScreen?.removeBackButton()
			submitGif?.startAnimatingGif()
			self.superScreen?.submit()
			DispatchQueue.global(qos: .background).async {
				sleep(4)
				DispatchQueue.main.async {
					self.superScreen?.transitionToFinalStage()
				}
			}
		}
		
	}
	
	func resizeImage(_ image: UIImage, newWidth: CGFloat, newHeight: CGFloat) -> UIImage {
		
		UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
		image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
		let newImage = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
		
		return newImage!
	}
	
	func initGif() {
		//let gifmanager = SwiftyGifManager(memoryLimit:40)
		let gif = UIImage(gifName: "submitButton.gif")
		submitGif = UIImageView(gifImage: gif, loopCount: 1)
		submitGif?.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
		self.addSubview(submitGif!)
		submitGif?.stopAnimatingGif()
		
	}
	
	
	
}

