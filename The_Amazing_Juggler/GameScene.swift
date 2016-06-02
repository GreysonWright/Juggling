//
//  GameScene.swift
//  The_Amazing_Juggler
//
//  Created by Greyson Wright on 6/2/16.
//  Copyright © 2016 Greyson Wright. All rights reserved.
//

import SpriteKit

protocol GameSceneDelegate: class {
	func gameOver(score: Int)
	func updateCrowdSatisfaction(value: Int)
}

class GameScene: SKScene, SKPhysicsContactDelegate {
	var score = 0
	var ballCount = 0
	var crowdSatisfaction = 30
	weak var scoreLabel: SKLabelNode?
	weak var player: PlayerNode?
	weak var ballTimer: NSTimer?
	weak var satisfactionTimer: NSTimer?
	weak var gameDelegate: GameSceneDelegate?
	
	override func didMoveToView(view: SKView) {
		super.didMoveToView(view)
		
		setupScene()
	}
	
	deinit {
		player?.removeFromParent()
		player = nil
		ballTimer?.stop()
		ballTimer = nil
		satisfactionTimer?.stop()
		satisfactionTimer = nil
		print("Deinit GameScene")
	}
	
	override func update(currentTime: NSTimeInterval) {
		if crowdSatisfaction == 0 {
			gameDelegate?.gameOver(score)
		}
	}
}
