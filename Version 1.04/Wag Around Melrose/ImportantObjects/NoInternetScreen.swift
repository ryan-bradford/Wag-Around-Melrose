//
//  NoInternetScreen.swift
//  Wag Around Melrose
//
//  Created by Ryan Bradford on 6/26/17.
//  Copyright © 2017 RBradford Studios. All rights reserved.
//

import Foundation
import UIKit

public class NoInternetScreen: UIView {
	
	public override init(frame: CGRect) {
		super.init(frame: frame)
		self.backgroundColor = UIColor.red
	}
	
	required public init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	override public func draw(_ rect: CGRect) {
		let message = "You Must Be Connected to the Internet"
		let _ = super.drawTextWithNoBox(x: 0, y: self.frame.height/2, width: self.frame.width, toDraw: message, fontSize: 22, bold: false, centered: true)
	}
	
}
