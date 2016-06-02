//
//  MenuViewController+UITouch.swift
//  The_Amazing_Juggler
//
//  Created by Greyson Wright on 6/2/16.
//  Copyright © 2016 Greyson Wright. All rights reserved.
//

import UIKit

extension MenuViewController {
	override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
		let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
		let gameViewController = GameViewController(nibName: "GameViewController", bundle: nil)
		appDelegate.window?.rootViewController = gameViewController
	}
}
