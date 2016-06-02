//
//  GameScene+UITouch.swift
//  The_Amazing_Juggler
//
//  Created by Greyson Wright on 6/2/16.
//  Copyright © 2016 Greyson Wright. All rights reserved.
//

import UIKit

extension GameScene {
	override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
		for touch in touches {
			let touchLocation = touch.locationInNode(self)
			if let player = player {
				player.move(CGPoint(x: touchLocation.x, y: player.position.y))
			}
		}
	}
}
