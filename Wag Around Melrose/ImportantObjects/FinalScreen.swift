//
//  FinalScreen.swift
//  Wag Around Melrose
//
//  Created by Ryan Bradford on 6/20/17.
//  Copyright © 2017 RBradford Studios. All rights reserved.
//

import Foundation
import UIKit

public class FinalScreen: UIView {
	
	var superScreen: MainView!
	
	public init(frame: CGRect, superScreen: MainView) {
		super.init(frame: frame)
		self.superScreen = superScreen
		self.backgroundColor = UIColor.clear
		initRestart()
	}
	
	required public init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	override public func draw(_ rect: CGRect) {
		let message = "Expect a Call From One of Our Walkers to Confirm Your Walk"
		let _ = super.drawTextWithNoBox(x: 0, y: 0, width: self.frame.width, toDraw: message, fontSize: 22, bold: false, centered: true)
	}
	
	func initRestart() {
		superScreen.infoObjects = Array<UIView>()
		
		let width = CGFloat(250*GlobalVariables.X_SCALE)
		let height = CGFloat(250*GlobalVariables.Y_SCALE)
		let rect = CGRect(x: (self.frame.width/2 - width/2), y: 120 + self.frame.height/2 - height/2, width: width, height: height)
		superScreen.startButton = StartButton(frame: rect, superScreen: superScreen, text: "Schedule Another")
		self.addSubview(superScreen.startButton)
		superScreen.infoObjects.append(self)
	}
	
}
