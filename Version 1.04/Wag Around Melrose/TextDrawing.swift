//
//  TextDrawing.swift
//  Wag Around Melrose
//
//  Created by Ryan Bradford on 6/19/17.
//  Copyright © 2017 RBradford Studios. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
		
	func drawCenteredTextInRect(_ x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, toDraw: String, fontSize: CGFloat) -> CGFloat {
		let message: NSMutableAttributedString = NSMutableAttributedString(string: toDraw)
		
		let fieldColor: UIColor = UIColor.black
		let fieldFont = UIFont(name: GlobalVariables.FONT, size: CGFloat(fontSize))
		let paraStyle = NSMutableParagraphStyle()
		paraStyle.alignment = NSTextAlignment.center
		
		let attributes: NSDictionary = [
			NSForegroundColorAttributeName: fieldColor,
			NSParagraphStyleAttributeName: paraStyle,
			NSFontAttributeName: fieldFont!
		]
		let countString = (message.length)
		message.addAttributes(attributes as! [String : AnyObject], range: NSRange(location: 0, length: countString) )
		
		let constraintRect = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
		
		let boundingBox = toDraw.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 25)], context: nil)
		
		let textHeight = boundingBox.height
		
		message.draw(in: CGRect(x: x, y: height / 2 - textHeight / 2 + y, width: width, height: height))
		return textHeight
	}
	
	func drawTextWithNoBox(x: CGFloat, y: CGFloat, width: CGFloat, toDraw: String, fontSize: CGFloat, bold: Bool, centered: Bool) -> CGFloat {
		var font: UIFont
		if bold {
			font = UIFont(name: GlobalVariables.FONT + "-Bold", size: CGFloat(fontSize))!
		} else {
			font = UIFont(name: GlobalVariables.FONT, size: CGFloat(fontSize))!
		}
		let message: NSMutableAttributedString = NSMutableAttributedString(string: toDraw)
		
		let fieldColor: UIColor = UIColor.black
		let paraStyle = NSMutableParagraphStyle()
		if(!centered) {
			paraStyle.alignment = NSTextAlignment.left
		} else {
			paraStyle.alignment = NSTextAlignment.center
		}
		
		let attributes: NSDictionary = [
			NSForegroundColorAttributeName: fieldColor,
			NSParagraphStyleAttributeName: paraStyle,
			NSFontAttributeName: font
		]
		let countString = (message.length)
		message.addAttributes(attributes as! [String : AnyObject], range: NSRange(location: 0, length: countString) )
		let textHeight = self.heightWithConstrainedWidth(width: width, font: font, toGet: toDraw)
		message.draw(in:  CGRect(x: x, y: y, width: width, height: textHeight))
		return textHeight
	}
	
	func heightWithConstrainedWidth(width: CGFloat, font: UIFont, toGet: String) -> CGFloat {
		let constraintRect = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
		
		let boundingBox = toGet.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
		
		return boundingBox.height
	}

}
