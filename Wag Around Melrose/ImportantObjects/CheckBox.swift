//
//  CheckBox.swift
//  Wag Around Melrose
//
//  Created by Ryan Bradford on 6/20/17.
//  Copyright © 2017 RBradford Studios. All rights reserved.
//

import Foundation
import UIKit

class CheckBox: UIButton {
	// Images
	let checkedImage = UIImage(named: "checked")! as UIImage
	let uncheckedImage = UIImage(named: "unchecked")! as UIImage
	var otherCheckBoxes: Array<CheckBox?>?
	
	// Bool property
	
	var isChecked: Bool = false
	
	init(frame: CGRect, otherCheckBoxes: Array<CheckBox?>) {
		self.otherCheckBoxes = otherCheckBoxes
		super.init(frame: frame)
		self.addTarget(self, action:#selector(buttonClicked(sender:)), for: UIControlEvents.touchUpInside)
		self.isChecked = false
		self.setImage(uncheckedImage, for: UIControlState.normal)

	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	func setUnchecked() {
		self.setImage(uncheckedImage, for: UIControlState.normal)
		isChecked = false
	}
	
	func setChecked() {
		self.setImage(checkedImage, for: UIControlState.normal)
		for x in otherCheckBoxes! {
			if(x != self) {
				x!.setUnchecked()
			}
		}
		isChecked = true
	}
	
	func buttonClicked(sender: UIButton) {
		if sender == self {			
			if isChecked == false {
				setChecked()
			} else {
				setUnchecked()
			}
		}
	}
}
