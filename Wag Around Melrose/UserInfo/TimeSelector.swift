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
    
    var minuteSelector: Selector!
	var daySelector: Selector!
	var height = CGFloat(200*GlobalVariables.Y_SCALE)
    var months = Array<Month>()
    var allDays = Array<Day>()
    var currentDay = 0
    var currentTime = 0
    
	public override init(frame: CGRect) {
		super.init(frame: frame)
        self.loadTimes()
		self.initDaySelector()
        self.initMinuteSelector()
		initInfoLine()
	}
	
	required public init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
		
	func initDaySelector() {
		
        var days = Array<String>()
        for x in months {
            days.append(contentsOf: x.toStringArray())
        }
        let width = CGFloat(150*GlobalVariables.X_SCALE)
		daySelector = Selector(frame: CGRect(x: 0, y: 0, width: width, height: height), times: days)
        daySelector.daySuperScreen = self
        
		self.addSubview(daySelector)
	}
    
    func initMinuteSelector() {
        let width = CGFloat(150*GlobalVariables.X_SCALE)
        minuteSelector = Selector(frame: CGRect(x: 150, y: 0, width: width, height: height), times: allDays[currentDay].availableTimes)
        minuteSelector.backgroundColor = UIColor.white
        minuteSelector.timeSuperScreen = self

        self.addSubview(minuteSelector)
    }
    
    func updateMinuteSelector(newIndex: Int) {
        minuteSelector.removeFromSuperview()
        self.currentDay = newIndex
        initMinuteSelector()
    }
    
    func updateTimeSelector(newIndex: Int) {
        self.currentTime = newIndex
    }
	
	func getDateAndTime() -> String {
        return allDays[currentDay].toString() + " " + getTimeSelected()
	}
    
    func getTimeSelected() -> String {
        var toReturn = allDays[currentDay].availableTimes[currentTime]
        if(toReturn.contains("AM")) {
            return toReturn.characters.split { $0 == " "}.map(String.init)[0]
        } else {
            let firstSplit = toReturn.characters.split { $0 == " "}.map(String.init)[0]
            let secondSplit = firstSplit.characters.split { $0 == ":"}.map(String.init)
            let hour = String(Int(secondSplit[0])! + 12)
            let minute = secondSplit[1]
            let toReturn = (hour + ":" + minute)
            return toReturn
        }
    }
	
	func initInfoLine() {
		let textBox = CGRect(x: 10, y: height + 25, width: self.frame.width - 20, height: 30)
		
		let textDisplay = InfoLine(frame: textBox, text: "Select The Walk Time", editable: false)
		
		self.addSubview(textDisplay)
	}
    
    func loadTimes() {
        var request = URLRequest(url: URL(string: "https://rbradford.thaumavor.io/iOS_Programs/Wag_Around_Melrose/getDates.php")!)
        request.httpMethod = "GET"
        var finished = false
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let _ = data, error == nil else {
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                finished = true
                return
            }
            let responseString = String(data: data!, encoding: .utf8)
            if(responseString != nil) {
                print(responseString)
                let months = responseString?.characters.split { $0 == "!"}.map(String.init)
                for x in 0 ..< months!.count where x % 2 == 0 {
                    self.months.append(Month(month: Int((months?[x])!)!, toProcess: (months?[x+1])!))
                }
                for x in self.months {
                    self.allDays.append(contentsOf: x.days)
                }
                finished = true
            }
        }
        task.resume()
        
        while(!finished) {
        }
    }
	
}
