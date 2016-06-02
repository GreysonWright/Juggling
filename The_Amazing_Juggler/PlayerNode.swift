//
//  PlayerNode.swift
//  The_Amazing_Juggler
//
//  Created by Greyson Wright on 6/2/16.
//  Copyright © 2016 Greyson Wright. All rights reserved.
//

import SpriteKit

class PlayerNode: SKSpriteNode {
	init() {
		super.init(texture: nil, color: UIColor.redColor(), size: CGSize(width: 30, height: 30))
		physicsBody = SKPhysicsBody(rectangleOfSize: size)
		physicsBody!.contactTestBitMask = 1
		physicsBody!.allowsRotation = false
		physicsBody!.dynamic = false
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	func move(position: CGPoint) {
		self.position = position
	}
}
