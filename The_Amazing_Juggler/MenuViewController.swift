//
//  MenuViewController.swift
//  The_Amazing_Juggler
//
//  Created by Greyson Wright on 6/2/16.
//  Copyright © 2016 Greyson Wright. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
	@IBOutlet weak var highScoreLabel: UILabel!
	
    override func viewDidLoad() {
        super.viewDidLoad()

		if let highScore = NSUserDefaults.standardUserDefaults().valueForKey("HighScore") {
			highScoreLabel.text = "High Score: \(highScore)"
		} else {
			NSUserDefaults.standardUserDefaults().setInteger(0, forKey: "HighScore")
		}
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
