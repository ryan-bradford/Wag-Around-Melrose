//
//  Day.swift
//  Wag Around Melrose
//
//  Created by Ryan Bradford on 7/5/17.
//  Copyright © 2017 RBradford Studios. All rights reserved.
//

import Foundation

public class Day {
    
    var availableTimes: Array<String>
    var number: Int
    var month: Int
    var year: Int
    
    public init(number: Int, times: String, month: Int, year: Int) {
        self.year = year
        self.number = number
        self.month = month
        availableTimes = Array<String>()
        processTimes(times: times)
    }
    
    func processTimes(times: String) {
        let ranges = times.characters.split { $0 == ","}.map(String.init)
        for var range in ranges {
            if(!range.contains("-")) {
                break
            }
            let times = range.characters.split { $0 == "-"}.map(String.init)
            let firstTime = Int(times[0])
            let lastTime = Int(times[1])
            if((lastTime! - firstTime!) <= 0) {
                break
            }
            let num = (lastTime! - firstTime!)/15
            for x in 0 ..< num {
                let minuteTotal = firstTime! + 15*x
                var hours = minuteTotal / 60
                hours = Int(floor(Double(hours)))
                let minutes = minuteTotal % 60
                var toAppend = String(hours) + ":" + String(minutes)
                if(minutes == 0) {
                    toAppend = toAppend + "0"
                }
                if(hours < 12) {
                    toAppend = toAppend + " AM"
                } else {
                    toAppend = toAppend + " PM"
                    if(hours > 12) {
                        var newMinutes = String(minutes)
                        if(minutes == 0) {
                            newMinutes += "0"
                        }
                        toAppend = String(hours-12) + ":" + newMinutes + " PM"
                    }
                }
                availableTimes.append(toAppend)
            }
        }
    }
    
    func toString() -> String {
        return String(year) + "-" + String(month) + "-" + String(number)
    }
    
}
