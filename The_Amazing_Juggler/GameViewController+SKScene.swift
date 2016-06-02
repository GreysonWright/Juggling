//
//  GameViewController+SKScene.swift
//  The_Amazing_Juggler
//
//  Created by Greyson Wright on 6/2/16.
//  Copyright © 2016 Greyson Wright. All rights reserved.
//

import SpriteKit

extension GameViewController{
	func setupScene() {
		let skView = view as! SKView
		skView.showsFPS = true
		skView.showsNodeCount = true
		
		let scene = GameScene(size: UIScreen.mainScreen().bounds.size)
		scene.scaleMode = .AspectFill
		scene.gameDelegate = self
		
		gameScene = scene
		gameView = skView
		gameView!.presentScene(self.gameScene)
	}
}
