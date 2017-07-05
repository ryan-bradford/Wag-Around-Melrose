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
    
    public init(number: Int, times: String, month: Int) {
        self.number = number
        self.month = month
        availableTimes = Array<String>()
        processTimes(times: times)
    }
    
    func processTimes(times: String) {
        let ranges = times.characters.split { $0 == ","}.map(String.init)
        for var range in ranges {
            let times = range.characters.split { $0 == "-"}.map(String.init)
            let firstTime = Int(times[0])
            let lastTime = Int(times[1])
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
                availableTimes.append(toAppend)
            }
        }
    }
    
    func toString() -> String {
        return String(month) + "-" + String(number)
    }
    
}
