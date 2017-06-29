//
//  SubmitView.swift
//  Wag Around Melrose
//
//  Created by Ryan Bradford on 6/20/17.
//  Copyright © 2017 RBradford Studios. All rights reserved.
//

import Foundation
import UIKit

public class SubmitView: UIView {
	
	var superScreen: MainView!
	var feesLine: InfoLine!
	var lengthLine: InfoLine!
	var paymentLine: InfoLine!
	
	public init(frame: CGRect, superScreen: MainView) {
		super.init(frame: frame)
		self.superScreen = superScreen
		initSubmitButton()
		initLines()
		self.backgroundColor = UIColor.clear
	}
	
	required public init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	func initSubmitButton() {
		let width = CGFloat(300*GlobalVariables.X_SCALE)
		let height = CGFloat(170*GlobalVariables.Y_SCALE)
		let rect = CGRect(x: 0, y: self.frame.height - height, width: width, height: height)
		let submitButton = SubmitButton(frame: rect, superScreen: superScreen)
		self.addSubview(submitButton)
	}
	
	func initLines() {
		var frame = CGRect(x: 0, y: 0, width: self.frame.width, height: 30)
		feesLine = InfoLine(frame: frame, text: "The walk will cost $", editable: false)
		frame.origin.y += 30
		frame = CGRect(x: 0, y: frame.origin.y, width: frame.width, height: 50)
		lengthLine = InfoLine(frame: frame, text: "This Walk Will Last \n Minutes", editable: false)
		frame.origin.y += 50
		frame = CGRect(x: 0, y: frame.origin.y, width: frame.width, height: 50)
		paymentLine = InfoLine(frame: frame, text: "Cash Must Be Paid \nUp Front", editable: false)
		self.addSubview(feesLine)
		self.addSubview(lengthLine)
		self.addSubview(paymentLine)
	}
	
	func setCost(cost: Int) {
		feesLine.setText(toSet: "The walk will cost $" + String(cost))
	}
	
	func setLength(length: Int) {
		lengthLine.setText(toSet: "This Walk Will Last \n" + String(length) + " Minutes")
	}
	
	func hideText() {
		UIView.animate(withDuration: 0.5, animations: {
			self.feesLine.frame.origin.x -= self.frame.width*2
			self.lengthLine.frame.origin.x -= self.frame.width*2
			self.paymentLine.frame.origin.x -= self.frame.width*2
		})
	}
	
	
}
