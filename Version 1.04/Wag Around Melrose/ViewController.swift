//
//  ViewController.swift
//  Wag Around Melrose
//
//  Created by Ryan Bradford on 6/16/17.
//  Copyright © 2017 RBradford Studios. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	var mainView: MainView?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setScales()
		let hasInternet = checkVersionNumber()
		if(hasInternet) {
			loadPrices()
			initMainView()
		}
	}
	
	func initMainView() {
		let screenSize: CGRect = UIScreen.main.bounds
		let loadingScreen = UIView(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height))
		loadingScreen.backgroundColor = UIColor(colorLiteralRed: 249.0/255.0, green: 208.0/255.0, blue: 164.0/255.0, alpha: 1)
		self.view.addSubview(loadingScreen)
	
		sleep(1)
		
		self.mainView = MainView(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height))
		self.view.addSubview(self.mainView!)
		UIView.animate(withDuration: 0.5, animations: {
			loadingScreen.frame = CGRect(x: loadingScreen.frame.origin.x, y: loadingScreen.frame.height, width: loadingScreen.frame.width, height: loadingScreen.frame.height)
		}, completion: {
			(value: Bool) in
			self.mainView?.transitionToFirstStage()
		})
	}
	
	func loadPrices() {
		let _ = PriceLoader()
	}
	
	override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
		return UIInterfaceOrientationMask.portrait
	}
	
	func setScales() {
		print(self.view.frame.width)
		GlobalVariables.Y_SCALE *= self.view.frame.height
		GlobalVariables.X_SCALE *= self.view.frame.width
		
		if(GlobalVariables.Y_SCALE < GlobalVariables.X_SCALE) {
			GlobalVariables.X_SCALE = GlobalVariables.Y_SCALE
		} else {
			GlobalVariables.Y_SCALE = GlobalVariables.X_SCALE
		}
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	func slideDownNoInternetScreen() {
		let screenSize: CGRect = UIScreen.main.bounds

		let noInternetScreen = NoInternetScreen(frame: CGRect(x: 0, y: -screenSize.height, width: screenSize.width, height: screenSize.height))
		self.view.addSubview(noInternetScreen)
		
		UIView.animate(withDuration: 0.5, animations: {
			noInternetScreen.frame.origin.y += screenSize.height
		})
	}
	
	func checkVersionNumber() -> Bool {
		
		var versionText = ""
		
		if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
			versionText = version
		}
		
		print(versionText)
		
		var isFinished = false
		var versionOld = false
		var hasInternet = true
		var request = URLRequest(url: URL(string: "https://rbradford.thaumavor.io/iOS_Programs/Wag_Around_Melrose/checkVersion.php")!)
		request.httpMethod = "POST"
		
		let postString = "version=" + versionText
		
		request.httpBody = postString.data(using: .utf8)
		let task = URLSession.shared.dataTask(with: request) { data, response, error in
			guard let _ = data, error == nil else {
				print("error=\(String(describing: error))")
				isFinished = true
				hasInternet = false
				return
			}
			
			if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
				print("statusCode should be 200, but is \(httpStatus.statusCode)")
				print("response = \(String(describing: response))")
				isFinished = true
				hasInternet = false
				return
			}
			let responseString = String(data: data!, encoding: .utf8)
			if(responseString != nil) {
				if responseString! == "false" {
					hasInternet = false
					versionOld = true
				}
				isFinished = true
			}
			print(responseString ?? "")
		}
		task.resume()
		
		while(!isFinished) {
			
		}
		if(!hasInternet) {
			slideDownNoInternetScreen()
		}
		if(versionOld) {
			slideDownOldVersionScreen()
		}
		return hasInternet
	}
	
	func slideDownOldVersionScreen() {
		let screenSize: CGRect = UIScreen.main.bounds
		
		let oldVersionScreen = OldVersionScreen(frame: CGRect(x: 0, y: -screenSize.height, width: screenSize.width, height: screenSize.height))
		self.view.addSubview(oldVersionScreen)
		
		UIView.animate(withDuration: 0.5, animations: {
			oldVersionScreen.frame.origin.y += screenSize.height
		})
	}


}

