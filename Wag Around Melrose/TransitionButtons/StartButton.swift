//
//  StartButton.swift
//  Wag Around Melrose
//
//  Created by Ryan Bradford on 6/19/17.
//  Copyright © 2017 RBradford Studios. All rights reserved.
//

import Foundation
import UIKit

public class StartButton: UIButton {
	
	var superScreen: MainView?
	var text: String!
	
	public init(frame: CGRect, superScreen: MainView, text: String) {
		super.init(frame: frame)
		self.text = text
		self.superScreen = superScreen
		self.addTarget(self, action: #selector(StartButton.transitionToNext(_:)), for: .touchUpInside)
	}
	
	required public init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	override public func draw(_ rect: CGRect) {
		let start = CGFloat(4)
		let width = self.frame.width-2*start
		let height = self.frame.height-2*start
		
		let aPath = UIBezierPath()
		
		aPath.move(to: CGPoint(x:start, y:start+height/2))
		aPath.addLine(to: CGPoint(x:start+width/2, y:start))
		aPath.addLine(to: CGPoint(x:start+width, y:start+height/2))
		aPath.addLine(to: CGPoint(x:start+width/2, y:start+height))
		
		aPath.close()
		aPath.lineWidth = 10
		//If you want to stroke it with a red color
		
		UIColor(colorLiteralRed: 255.0/255.0, green: 194.0/255.0, blue: 150.0/255.0, alpha: 1).set()
		
		aPath.stroke()
		//If you want to fill it as well
		
		let _ = self.drawCenteredTextInRect(6, y: 0, width: self.frame.width-12, height: self.frame.height-12, toDraw: text, fontSize: 25)
	}
	
	func transitionToNext(_ sender: UIButton!) {
		superScreen?.transitionToNext()
	}
	
	
	
}
