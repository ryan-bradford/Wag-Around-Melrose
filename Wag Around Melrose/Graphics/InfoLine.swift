//
//  InfoLine.swift
//  Wag Around Melrose
//
//  Created by Ryan Bradford on 6/19/17.
//  Copyright © 2017 RBradford Studios. All rights reserved.
//

import Foundation
import UIKit

public class InfoLine: UIView {
	
	var text: String!
	var editable = true
	var textBox: UITextField?
	var nonEditableTextBox: UITextView!
	
	public init(frame: CGRect, text: String, editable: Bool) {
		super.init(frame: frame)
		self.editable = editable
		self.text = text
		self.backgroundColor = UIColor.clear
		initTextBox()
	}
	
	override public func draw(_ rect: CGRect) {
		let aPath = UIBezierPath()
		
		aPath.move(to: CGPoint(x:0, y:self.frame.height))
		aPath.addLine(to: CGPoint(x:0, y:self.frame.height))
		aPath.addLine(to: CGPoint(x:self.frame.width, y:self.frame.height))
		
		aPath.close()
		aPath.lineWidth = 5
		//If you want to stroke it with a red color
		UIColor.black.set()
		
		aPath.stroke()
		//If you want to fill it as well
		aPath.fill()
	}
	
	required public init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	func initTextBox() {
		if(!editable) {
			nonEditableTextBox = UITextView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height-5))
			nonEditableTextBox.isEditable = false
			nonEditableTextBox.text = text
			nonEditableTextBox.font = UIFont(name: GlobalVariables.FONT, size: 18)
			nonEditableTextBox.textColor = UIColor.gray
			self.addSubview(nonEditableTextBox)
		} else {
			textBox = UITextField(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height-5))
			textBox?.text = text
			textBox?.contentVerticalAlignment = UIControlContentVerticalAlignment.bottom
			
			textBox?.font = UIFont(name: GlobalVariables.FONT, size: 18)
			textBox?.textColor = UIColor.gray
			textBox?.clearsOnBeginEditing = true
			self.addSubview(textBox!)
		}
	}
	
	func getText() -> String {
		return textBox!.text!
	}
	
	func setText(toSet: String) {
		nonEditableTextBox?.text = toSet
	}
	
	func setFontColor(color: UIColor) {
		nonEditableTextBox.textColor = color
	}
	
	
}
