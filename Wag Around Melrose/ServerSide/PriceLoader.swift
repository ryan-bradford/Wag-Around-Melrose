//
//  PriceLoader.swift
//  Wag Around Melrose
//
//  Created by Ryan Bradford on 6/20/17.
//  Copyright © 2017 RBradford Studios. All rights reserved.
//

import Foundation

public class PriceLoader {
	
	init() {
		loadPricesAndLengths()
	}
	
	func loadPricesAndLengths() {
		var isFinished = false
		var request = URLRequest(url: URL(string: "https://rbradford.thaumavor.io/iOS_Programs/Wag_Around_Melrose/getPricesAndLengths.php")!)
		request.httpMethod = "POST"
		
		request.httpBody = String("").data(using: .utf8)
		let task = URLSession.shared.dataTask(with: request) { data, response, error in
			guard let _ = data, error == nil else {
				print("error=\(String(describing: error))")
				isFinished = true
				return
			}
			
			if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
				print("statusCode should be 200, but is \(httpStatus.statusCode)")
				print("response = \(String(describing: response))")
				isFinished = true
				return
			}
			let responseString = String(data: data!, encoding: .utf8)
			if(responseString != nil) {
				let lines = responseString?.characters.split { $0 == ","}.map(String.init)
				GlobalVariables.COST_ONE = Int((lines?[0])!)!
				GlobalVariables.COST_TWO = Int((lines?[1])!)!
				GlobalVariables.COST_THREE = Int((lines?[2])!)!
				GlobalVariables.LENGTH_ONE = Int((lines?[3])!)!
				GlobalVariables.LENGTH_TWO = Int((lines?[4])!)!
				GlobalVariables.LENGTH_THREE = Int((lines?[5])!)!
				isFinished = true
			}
			print(responseString ?? "")
		}
		task.resume()
		
		while(!isFinished) {
			
		}
		
	}

	
}
