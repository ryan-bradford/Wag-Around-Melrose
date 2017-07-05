//
//  Month.swift
//  Wag Around Melrose
//
//  Created by Ryan Bradford on 7/5/17.
//  Copyright © 2017 RBradford Studios. All rights reserved.
//

import Foundation

public class Month {
    
    var month: Int
    var monthName: String
    public var days = Array<Day>()

    public init(month: Int, toProcess: String) {
        self.month = month
        
        let dateFormatter: DateFormatter = DateFormatter()
        
        let months = dateFormatter.shortMonthSymbols
        let monthSymbol = months?[month-1] // month - from your date components
        
        monthName = monthSymbol!
        
        processText(toProcess: toProcess)
    }
    
    func processText(toProcess: String) {
        let days = toProcess.characters.split { $0 == "|"}.map(String.init)
        for x in 0 ..< days.count where x % 2 == 0 {
            self.days.append(Day(number: Int(days[x])!, times: days[x+1], month: month))
        }
    }
    
    func toStringArray() -> Array<String> {
        
        var toReturn = Array<String>()
        for i in days {
            toReturn.append(monthName + " " + String(i.number))
        }
        return toReturn
        
    }
    
}
