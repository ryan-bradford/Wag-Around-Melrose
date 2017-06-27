//
//  TimeSelector.swift
//  bork!
//
//  Created by Ryan Bradford on 4/18/17.
//  Copyright © 2017 RBradford Studios. All rights reserved.
//

import Foundation
import UIKit

public class TimeSelector: UIView {
	
	var selector: UIDatePicker!
	var height = CGFloat(200*GlobalVariables.Y_SCALE)
	
	public override init(frame: CGRect) {
		super.init(frame: frame)
		self.initSelector()
		initInfoLine()
	}
	
	required public init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
		
	func initSelector() {
		let width = CGFloat(300*GlobalVariables.X_SCALE)
		let rect = CGRect(x: 0, y: 0, width: width, height: height)
		selector = UIDatePicker(frame: rect)
		
		selector.minuteInterval = 15
		
		selector.minimumDate = Date(timeIntervalSinceNow: 1800)

		self.addSubview(selector)
	}
	
	func getDateAndTime() -> String {
		return String(describing: selector.date)
	}
	
	func initInfoLine() {
		let textBox = CGRect(x: 10, y: height + 25, width: self.frame.width - 20, height: 30)
		
		let textDisplay = InfoLine(frame: textBox, text: "Select The Walk Time", editable: false)
		
		self.addSubview(textDisplay)
	}
	
}
