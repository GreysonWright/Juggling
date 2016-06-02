//
//  GameScene+SKPhysicsContact.swift
//  The_Amazing_Juggler
//
//  Created by Greyson Wright on 6/2/16.
//  Copyright © 2016 Greyson Wright. All rights reserved.
//

import SpriteKit

extension GameScene {
	func didBeginContact(contact: SKPhysicsContact) {
		if contact.bodyA.contactTestBitMask == 4 {
			contact.bodyB.velocity = CGVector(dx: contact.bodyB.velocity.dx * -0.8, dy: contact.bodyB.velocity.dy)
		} else if (contact.bodyA.contactTestBitMask == 1) {
			contact.bodyB.applyImpulse(CGVectorMake(0.1 * randomNumber(-1.0, upperBound: 1.0), 3.5))
			contact.bodyB.velocity = CGVector(dx: contact.bodyB.velocity.dx, dy: min(contact.bodyB.velocity.dy, 600));
			if !ignoreContact {
				score += 1
				scoreLabel?.text = "Score \(score)"
			}
			ignoreContact = false
		}
		
		if contact.contactPoint.y < CGRectGetMinY(frame) + 20 {
			contact.bodyB.node?.removeFromParent()
			ballCount -= 1
			crowdSatisfaction = max(crowdSatisfaction - 30, 0)
		}
	}
}
