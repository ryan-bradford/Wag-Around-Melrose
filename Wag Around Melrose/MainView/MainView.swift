//
//  MainView.swift
//  Wag Around Melrose
//
//  Created by Ryan Bradford on 6/16/17.
//  Copyright © 2017 RBradford Studios. All rights reserved.
//

import Foundation
import UIKit

public class MainView: UIView {
	
	var times = ["0", "15", "30", "45", "60"]
	var dogGraphic: DogGraphic!
	var startButton: StartButton!
	var infoObjects = Array<UIView>()
	var currentIndex = 0
	var continueButton: ContinueButton!
	var backButton: BackButton!
	var submitView: SubmitView!
	
	//Info Objects
	var selector: TimeSelector!
	var personalInfo: PersonalInfoScreen!
	var checkBoxes: CheckBoxScreen!
	var postString = ""
	
	override public init(frame: CGRect) {
		super.init(frame: frame)
		self.backgroundColor = GlobalVariables.backgroundColor
		initDoggo()
		initStartButton()
		initTimeSelector()
		initPersonalInfoScreen()
		initCheckBoxScreen()
		initSubmitButton()
		initContinueButton()
		initBackButton()
	}
	
	required public init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	func initStartButton() {
		let width = CGFloat(250*GlobalVariables.X_SCALE)
		let height = CGFloat(250*GlobalVariables.Y_SCALE)
		let rect = CGRect(x: (self.frame.width/2 - width/2)+self.frame.width, y: self.frame.height - height - 100*GlobalVariables.Y_SCALE, width: width, height: height)
		startButton = StartButton(frame: rect, superScreen: self, text: "Request a Walker")
		self.addSubview(startButton)
		infoObjects.append(startButton)
	}
	
	func initDoggo() {
		dogGraphic = DogGraphic(screenWidth: Double(self.frame.width), y: -Double(self.frame.height/2 - 75*GlobalVariables.Y_SCALE))
		self.addSubview(dogGraphic)
		
		UIView.animate(withDuration: 0.5, animations: {
			self.dogGraphic.frame.origin.y = -self.dogGraphic.frame.origin.y
		})
	}
	
	func initTimeSelector() {
		let width = CGFloat(300*GlobalVariables.X_SCALE)
		let height = CGFloat(300*GlobalVariables.Y_SCALE)
		let rect = CGRect(x: (self.frame.width/2 - width/2) + self.frame.width, y: self.frame.height - height, width: width, height: height)
		selector = TimeSelector(frame: rect)
		
		self.addSubview(selector)
		
		infoObjects.append(selector)
	}
	
	func initPersonalInfoScreen() {
		let width = CGFloat(300*GlobalVariables.X_SCALE)
		let height = CGFloat(266*GlobalVariables.Y_SCALE)
		let rect = CGRect(x: (self.frame.width/2 - width/2) + self.frame.width, y: self.frame.height - height - 50, width: width, height: height)
		personalInfo = PersonalInfoScreen(frame: rect, superScreen: self)
		
		self.addSubview(personalInfo)
		
		infoObjects.append(personalInfo)
	}
	
	func initCheckBoxScreen() {
		let width = CGFloat(300*GlobalVariables.X_SCALE)
		let height = CGFloat(200*GlobalVariables.Y_SCALE)
		let rect = CGRect(x: (self.frame.width/2 - width/2) + self.frame.width, y: self.frame.height - height - 50*GlobalVariables.Y_SCALE, width: width, height: height)
		checkBoxes = CheckBoxScreen(frame: rect, superScreen: self)
		
		self.addSubview(checkBoxes)
		
		infoObjects.append(checkBoxes)
	}
	
	func initSubmitButton() {
		let width = CGFloat(300*GlobalVariables.X_SCALE)
		let height = CGFloat(300*GlobalVariables.Y_SCALE)
		let rect = CGRect(x: (self.frame.width/2 - width/2) + self.frame.width, y: self.frame.height - height, width: width, height: height)
		submitView = SubmitView(frame: rect, superScreen: self)
		self.addSubview(submitView)
		infoObjects.append(submitView)
	}
	
	func initContinueButton() {
		let width = CGFloat(75*GlobalVariables.X_SCALE)
		let rect = CGRect(x: (self.frame.width - width*1.5)+self.frame.width, y: self.infoObjects[1].frame.origin.y - width*1.25, width: width, height: width)
		continueButton = ContinueButton(frame: rect, superScreen: self, width: Double(width))
		self.addSubview(continueButton)
	}
	
	func slideOnContinueButton() {
		UIView.animate(withDuration: 0.5, animations: {
			self.continueButton.frame.origin.x -= self.frame.width
		})
	}
	
	func initBackButton() {
		let width = CGFloat(75*GlobalVariables.X_SCALE)
		let rect = CGRect(x: (width/2)-self.frame.width, y: self.infoObjects[1].frame.origin.y - width*1.25, width: width, height: width)
		backButton = BackButton(frame: rect, superScreen: self, width: Double(width))
		self.addSubview(backButton)
	}
	
	func slideOnBackButton() {
		UIView.animate(withDuration: 0.5, animations: {
			self.backButton.frame.origin.x += self.frame.width
		})
	}
	
	func removeContinueButton() {
		UIView.animate(withDuration: 0.5, animations: {
			self.continueButton.frame.origin.x += self.frame.width
		})
	}
	
	func removeBackButton() {
		UIView.animate(withDuration: 0.5, animations: {
			self.backButton.frame.origin.x -= self.frame.width
		})
	}
	
	func transitionToNext() {
		if(self.infoObjects.count == 1) {
			initTimeSelector()
			initPersonalInfoScreen()
			initCheckBoxScreen()
			initSubmitButton()
			initContinueButton()
			initBackButton()
			currentIndex = 0
		}
		if let info = self.infoObjects[currentIndex] as? PersonalInfoScreen {
			if info.getName() == "Name" || info.getName() == "" || info.getName() == " " {
				info.warnUser()
				return
			}
			if info.getAddress() == "Address" || info.getAddress() == "" || info.getAddress() == " "{
				info.warnUser()
				return
			}
			if info.getPhoneNumber() == "Phone Number" || info.getPhoneNumber() == "" || info.getPhoneNumber() == " " || info.getPhoneNumber().characters.count < 10 {
				info.warnPhone()
				return
			}
		}
		
		if let info = self.infoObjects[currentIndex] as? CheckBoxScreen {
			if info.getCost() == 0 {
				info.warnUser()
				return
			}
		}
		if(currentIndex == 0) {
			slideOnContinueButton()
		} else if(currentIndex == 1) {
			slideOnBackButton()
		} else if(currentIndex == self.infoObjects.count-2) {
			updateSubmitText()
			removeContinueButton()
		}
		slideDownPersonalInfo()
		UIView.animate(withDuration: 0.5, animations: {
			self.infoObjects[self.currentIndex].frame.origin.x -= self.frame.width
			self.infoObjects[self.currentIndex+1].frame.origin.x -= self.frame.width
		})
		currentIndex += 1
		
	}
	
	func transitionToLast() {
		if(currentIndex > 0) {
			if(currentIndex == self.infoObjects.count-1) {
				slideOnContinueButton()
			} else if(currentIndex == 2) {
				removeBackButton()
			}
			slideDownPersonalInfo()
			UIView.animate(withDuration: 0.5, animations: {
				self.infoObjects[self.currentIndex].frame.origin.x += self.frame.width
				self.infoObjects[self.currentIndex-1].frame.origin.x += self.frame.width
			})
			currentIndex -= 1
		}
	}
	
	func transitionToFirstStage() {
		UIView.animate(withDuration: 0.5, animations: {
			self.dogGraphic.frame.origin.y = 25
			self.startButton.frame.origin.x -= self.frame.width
		})
	}
	
	func transitionToFinalStage() {
		UIView.animate(withDuration: 0.5, animations: {
			self.infoObjects.last?.frame.origin.x -= self.frame.width
		})
		let width = CGFloat(300*GlobalVariables.X_SCALE)
		let height = CGFloat(200*GlobalVariables.Y_SCALE)
		let rect = CGRect(x: (self.frame.width/2 - width/2) + self.frame.width, y: 30*GlobalVariables.Y_SCALE + self.frame.height/2 - height/2, width: width, height: height)
		let finalScreen = FinalScreen(frame: rect, superScreen: self)
		
		self.addSubview(finalScreen)
		
		UIView.animate(withDuration: 0.5, animations: {
			finalScreen.frame.origin.x -= self.frame.width
		})
	}
	
	func submit() {
		submitView.hideText()
		postString += "date=" + selector.getDateAndTime()
		postString += "&name=" + personalInfo.getName()
		postString += "&address=" + personalInfo.getAddress()
		postString += "&phone=" + personalInfo.getPhoneNumber()
		postString += "&cost=" + String(checkBoxes.getCost())
		postString += "&length=" + String(checkBoxes.getLength())
		
		var request = URLRequest(url: URL(string: "https://rbradford.thaumavor.io/iOS_Programs/Wag_Around_Melrose/recieveWalk.php")!)
		request.httpMethod = "POST"
		
		request.httpBody = postString.data(using: .utf8)
		let task = URLSession.shared.dataTask(with: request) { data, response, error in
			guard let _ = data, error == nil else {
				return
			}
			
			if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
				return
			}
			//let responseString = String(data: data!, encoding: .utf8)
		}
		task.resume()
		removeBackButton()
	}
	
	func slideUpPersonalInfo() {
		if(!self.personalInfo.slidUp) {
			self.personalInfo.slidUp = true
			UIView.animate(withDuration: 0.5, animations: {
				self.personalInfo.frame.origin.y -= 200*GlobalVariables.Y_SCALE
				self.continueButton.frame.origin.y -= 150*GlobalVariables.Y_SCALE
				self.backButton.frame.origin.y -= 150*GlobalVariables.Y_SCALE
			})
		}
	}
	
	func slideDownPersonalInfo() {
		if(self.personalInfo.slidUp) {
			self.endEditing(true)
			self.personalInfo.slidUp = false
			UIView.animate(withDuration: 0.5, animations: {
				self.personalInfo.frame.origin.y += 200*GlobalVariables.Y_SCALE
				self.continueButton.frame.origin.y += 150*GlobalVariables.Y_SCALE
				self.backButton.frame.origin.y += 150*GlobalVariables.Y_SCALE
			})
		}
	}
	
	func updateSubmitText() {
		submitView.setCost(cost: checkBoxes.getCost())
		submitView.setLength(length: checkBoxes.getLength())
	}
	
}
