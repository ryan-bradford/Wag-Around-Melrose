//
//  Selector.swift
//  Wag Around Melrose
//
//  Created by Ryan Bradford on 7/7/17.
//  Copyright © 2017 RBradford Studios. All rights reserved.
//

import Foundation
//
//  TimeSelector.swift
//  bork!
//
//  Created by Ryan Bradford on 4/18/17.
//  Copyright © 2017 RBradford Studios. All rights reserved.
//

import Foundation
import UIKit

public class Selector: UIView, UIPickerViewDataSource, UIPickerViewDelegate {
	
	var delayPicker: UIPickerView!
	var times: Array<String>?
	var timeTextField: UITextField?
	var daySuperScreen: TimeSelector?
	var timeSuperScreen: TimeSelector?
	
	init(frame: CGRect, times: Array<String>) {
		super.init(frame: frame)
		
		self.times = times
		
		delayPicker = UIPickerView()
		delayPicker.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
		
		timeTextField = UITextField()
		
		delayPicker?.dataSource = self
		delayPicker?.delegate = self
		
		timeTextField?.inputView = delayPicker
		timeTextField?.text = times[0]
		
		self.addSubview(delayPicker)
	}
	
	required public init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		return times![row]
	}
	
	public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
		daySuperScreen?.updateMinuteSelector(newIndex: row)
		timeSuperScreen?.updateTimeSelector(newIndex: row)
		timeTextField?.text = times![row]
	}
	
	func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
		return 1
	}
	
	public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		return times!.count
	}
	
	public func numberOfComponents(in pickerView: UIPickerView) -> Int {
		return 1
	}
}
