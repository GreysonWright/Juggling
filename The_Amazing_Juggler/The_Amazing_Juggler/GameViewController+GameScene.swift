//
//  GameViewController+GameScene.swift
//  The_Amazing_Juggler
//
//  Created by Greyson Wright on 6/2/16.
//  Copyright © 2016 Greyson Wright. All rights reserved.
//

import UIKit

extension GameViewController {
	func gameOver(score: Int) {
		gameView?.presentScene(nil)
		gameScene?.removeAllActions()
		gameScene?.removeAllChildren()
		gameScene = nil
		
		let gameOverLabel = UILabel(frame: UIScreen.mainScreen().bounds)
		gameOverLabel.numberOfLines = 0
		gameOverLabel.textAlignment = .Center
		gameOverLabel.font = UIFont(name: "Helvetica Neue", size: 24)
		gameOverLabel.text = "Game Over\nScore: \(score)"
		gameOverLabel.textColor = UIColor.whiteColor()
		gameOverLabel.backgroundColor = UIColor.blackColor()
		view.addSubview(gameOverLabel)
		
		if let highScore = NSUserDefaults.standardUserDefaults().valueForKey("HighScore") as? Int {
			NSUserDefaults.standardUserDefaults().setInteger(max(highScore, score), forKey: "HighScore")
			NSUserDefaults.standardUserDefaults().synchronize()
		}
		
		2.second.delay {
			let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
			let menuViewController = MenuViewController(nibName: "MenuViewController", bundle: nil)
			appDelegate.window?.rootViewController = menuViewController
		}
	}
	
	func updateCrowdSatisfaction(value: Int) {
		
	}
}
