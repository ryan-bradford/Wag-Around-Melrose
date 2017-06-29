//
//  CheckBoxScreen.swift
//  Wag Around Melrose
//
//  Created by Ryan Bradford on 6/20/17.
//  Copyright © 2017 RBradford Studios. All rights reserved.
//

import Foundation
import UIKit

public class CheckBoxScreen: UIView {
	
	var superScreen: MainView!
	var walkOneCheckBox: CheckBox!
	var walkTwoCheckBox: CheckBox!
	var walkThreeCheckBox: CheckBox!
	var allCheckBoxes = Array<CheckBox?>()
	var infoLine: InfoLine!
	
	public init(frame: CGRect, superScreen: MainView) {
		super.init(frame: frame)
		self.superScreen = superScreen

		initWalkOne()
		initWalkTwo()
		initWalkThree()
		initInfoLine()
		
		allCheckBoxes.append(walkOneCheckBox)
		allCheckBoxes.append(walkTwoCheckBox)
		allCheckBoxes.append(walkThreeCheckBox)
		
		walkOneCheckBox.otherCheckBoxes = allCheckBoxes
		walkTwoCheckBox.otherCheckBoxes = allCheckBoxes
		walkThreeCheckBox.otherCheckBoxes = allCheckBoxes
	}
	
	required public init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	func initWalkOne() {
		walkOneCheckBox = CheckBox(frame: CGRect(x: 0, y: 0, width: 50, height: 50), otherCheckBoxes: allCheckBoxes)
		walkOneCheckBox.backgroundColor = UIColor.clear
		self.addSubview(walkOneCheckBox)
		
		
		let frame = CGRect(x: 60, y: 17, width: self.frame.width-60, height: 30)
		let textInfo = InfoLine(frame: frame, text: String(GlobalVariables.LENGTH_ONE) + " Minute Walk at $" + String(GlobalVariables.COST_ONE), editable: false)
		self.addSubview(textInfo)
	}
	
	func initWalkTwo() {
		walkTwoCheckBox = CheckBox(frame: CGRect(x: 0, y: 50, width: 50, height: 50), otherCheckBoxes: allCheckBoxes)
		walkTwoCheckBox.backgroundColor = UIColor.clear
		self.addSubview(walkTwoCheckBox)
		
		
		let frame = CGRect(x: 60, y: 67, width: self.frame.width-60, height: 30)
		let textInfo = InfoLine(frame: frame, text: String(GlobalVariables.LENGTH_TWO) + " Minute Walk at $" + String(GlobalVariables.COST_TWO), editable: false)
		self.addSubview(textInfo)
	}
	
	func initWalkThree() {
		walkThreeCheckBox = CheckBox(frame: CGRect(x: 0, y: 100, width: 50, height: 50), otherCheckBoxes: allCheckBoxes)
		walkThreeCheckBox.backgroundColor = UIColor.clear
		self.addSubview(walkThreeCheckBox)
		
		
		let frame = CGRect(x: 60, y: 117, width: self.frame.width-60, height: 30)
		let textInfo = InfoLine(frame: frame, text: String(GlobalVariables.LENGTH_THREE) + " Minute Walk at $" + String(GlobalVariables.COST_THREE), editable: false)
		self.addSubview(textInfo)
	}
	
	func getCost() -> Int {
		var cost = 0
		if(walkOneCheckBox.isChecked) {
			cost = GlobalVariables.COST_ONE
		}
		if(walkTwoCheckBox.isChecked) {
			cost = GlobalVariables.COST_TWO
		}
		if(walkThreeCheckBox.isChecked) {
			cost = GlobalVariables.COST_THREE
		}
		return cost
	}
	
	func getLength() -> Int{
		var length = 0
		if(walkOneCheckBox.isChecked) {
			length = GlobalVariables.LENGTH_ONE
		}
		if(walkTwoCheckBox.isChecked) {
			length = GlobalVariables.LENGTH_TWO
		}
		if(walkThreeCheckBox.isChecked) {
			length = GlobalVariables.LENGTH_THREE
		}
		return length
	}
	
	func initInfoLine() {
		let textBox = CGRect(x: 10, y: 3*self.frame.height/4 + 50, width: self.frame.width - 40, height: 30)
		
		infoLine = InfoLine(frame: textBox, text: "Select One", editable: false)
		
		self.addSubview(infoLine)
	}
	
	func warnUser() {
		infoLine.setFontColor(color: UIColor.red)
	}
	
}
