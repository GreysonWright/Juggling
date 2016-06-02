//
//  GameScene+SKNode.swift
//  The_Amazing_Juggler
//
//  Created by Greyson Wright on 6/2/16.
//  Copyright © 2016 Greyson Wright. All rights reserved.
//

import SpriteKit

extension GameScene {
	func randomNumber(lowerBound: CGFloat, upperBound: CGFloat) -> CGFloat {
		let randomNumber = lowerBound + (CGFloat(Float(arc4random()) / Float(UINT32_MAX)) * (upperBound - lowerBound))
		return randomNumber
	}
	
	func createGround() {
		let groundNode = SKShapeNode(rectOfSize: CGSize(width: size.width, height: 40))
		groundNode.name = "Ground"
		groundNode.fillColor = UIColor.blackColor()
		groundNode.strokeColor = groundNode.fillColor
		groundNode.position = CGPoint(x: CGRectGetMidX(frame), y: CGRectGetMinY(frame))
		groundNode.physicsBody = SKPhysicsBody(rectangleOfSize: groundNode.frame.size)
		groundNode.physicsBody!.dynamic = false
		groundNode.physicsBody!.contactTestBitMask = 3
		addChild(groundNode)
	}
	
	func createPlayer() {
		let playerNode = PlayerNode()
		playerNode.name = "Player"
		playerNode.position = CGPoint(x: CGRectGetMidX(frame), y: CGRectGetMinY(frame) + 36)
		player = playerNode
		addChild(player!)
	}
	
	func createBall() {
		let ball = SKShapeNode(circleOfRadius: 5)
		ball.name = "Ball"
		ball.fillColor = UIColor.blueColor()
		ball.strokeColor = ball.fillColor
		ball.position = player!.position
		ball.physicsBody = SKPhysicsBody(circleOfRadius: 5)
		ball.physicsBody!.contactTestBitMask = 2
		ball.physicsBody!.collisionBitMask = 0
		addChild(ball)
		ballCount += 1
		
		ball.physicsBody!.applyImpulse(CGVector(dx: 0.3 * randomNumber(-1.0, upperBound: 1.0), dy: 1.7))
	}
	
	func setupTimer() {
		ballTimer = 5.second.interval { [weak self] in
			if self?.ballCount < 7 {
				self?.createBall()
				self?.crowdSatisfaction = min(self!.crowdSatisfaction + 8, 100);
			}
			if self?.score != 0 {
				self?.score += 3
				self?.scoreLabel?.text = "Score: \(self!.score)"
			}
		}
		satisfactionTimer =  1.second.interval { [weak self] in
			self?.crowdSatisfaction = min(self!.crowdSatisfaction + 1, 100);
			self?.gameDelegate?.updateCrowdSatisfaction(self!.crowdSatisfaction)
		}
	}
	
	func createScoreLabel() {
		let scoreLabelNode = SKLabelNode(text: "Score: 0")
		scoreLabelNode.fontColor = UIColor.whiteColor()
		scoreLabelNode.fontSize = 20
		scoreLabelNode.fontName = "Helvetica Neue"
		scoreLabelNode.position = CGPoint(x: CGRectGetMinX(frame) + scoreLabelNode.frame.width / 2 + 7, y: CGRectGetMaxY(frame) - 28)
		
		scoreLabel = scoreLabelNode
		addChild(scoreLabel!)
	}
	
	func setupScene() {
		physicsWorld.contactDelegate = self
		physicsWorld.gravity = CGVector(dx: 0, dy: -3)
		physicsBody = SKPhysicsBody(edgeLoopFromRect: frame)
		physicsBody!.contactTestBitMask = 4;
		physicsBody!.collisionBitMask = 1;
		createScoreLabel()
		createGround()
		createPlayer()
		setupTimer()
	}
}
