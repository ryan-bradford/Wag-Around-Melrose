//
//  EmailEnter.swift
//  Wag Around Melrose
//
//  Created by Ryan Bradford on 6/19/17.
//  Copyright © 2017 RBradford Studios. All rights reserved.
//

import Foundation
import UIKit

public class PersonalInfoScreen: UIView, UITextFieldDelegate {
	
	var name: InfoLine!
	var address: InfoLine!
	var phone: InfoLine!
	var superScreen: MainView!
	var infoLine: InfoLine!
	var slidUp = false
	
	public init(frame: CGRect, superScreen: MainView) {
		super.init(frame: frame)
		self.superScreen = superScreen
		self.backgroundColor = UIColor.white
		initNameLine()
		initAddressLine()
		initPhoneLine()
		initInfoLine()
	}
	
	required public init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	func initNameLine() {
        var text = "Name"
        let readResult = FileRW.readFile(fileName: "name.txt")
        if(readResult != nil) {
            text = readResult!
        }
		let frame = CGRect(x: 0, y: 25, width: self.frame.width, height: self.frame.height/3 - 30)
		name = InfoLine(frame: frame, text: text, editable: true)
		name.textBox?.delegate = self
		self.addSubview(name)
	}
	
	func initAddressLine() {
        var text = "Address"
        let readResult = FileRW.readFile(fileName: "address.txt")
        if(readResult != nil) {
            text = readResult!
        }
		let frame = CGRect(x: 0, y: self.frame.height/4, width: self.frame.width, height: self.frame.height/3 - 5)
		address = InfoLine(frame: frame, text: text, editable: true)
		address.textBox?.delegate = self
		self.addSubview(address)
	}
	
	func initPhoneLine() {
        var text = "Phone Number"
        let readResult = FileRW.readFile(fileName: "phone.txt")
        if(readResult != nil) {
            text = readResult!
        }
		let frame = CGRect(x: 0, y: 2*self.frame.height/4, width: self.frame.width, height: self.frame.height/3 - 5)
		phone = InfoLine(frame: frame, text: text, editable: true)
		phone.textBox?.delegate = self
		self.addSubview(phone)
	}
	
	func getName() -> String {
        FileRW.writeFile(fileName: "name.txt", contents: name.getText())
		return name.getText()
	}
	
	func getPhoneNumber() -> String {
        FileRW.writeFile(fileName: "phone.txt", contents: phone.getText())
		return phone.getText()
	}
	
	func getAddress() -> String {
        FileRW.writeFile(fileName: "address.txt", contents: address.getText())
		return address.getText()
	}
	
	func initInfoLine() {
		let textBox = CGRect(x: 10, y: 3*self.frame.height/4 + 50, width: self.frame.width - 40, height: 30)
		
		infoLine = InfoLine(frame: textBox, text: "Enter Your Information", editable: false)
		
		self.addSubview(infoLine)
	}
	
	public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		phone.endEditing(true)
		name.endEditing(true)
		address.endEditing(true)
		if(slidUp) {
			superScreen.slideDownPersonalInfo()
		}
		return false
	}
	
	public func textFieldDidBeginEditing(_ textField: UITextField) {
		if(!slidUp) {
			superScreen.slideUpPersonalInfo()
		}
	}
	
	func warnUser() {
		infoLine.setText(toSet: "Please Answer All Parts")
		infoLine.setFontColor(color: UIColor.red)
	}
	
	func warnPhone() {
		infoLine.setText(toSet: "Check Your Phone Number")
		infoLine.setFontColor(color: UIColor.red)
	}
	
}
