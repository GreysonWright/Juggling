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
				let boundedLocationX = max(CGRectGetMinX(frame) + player.size.width / 2, min(touchLocation.x, CGRectGetMaxX(frame) - player.size.width / 2))
				player.move(CGPoint(x: boundedLocationX, y: player.position.y))
			}
		}
	}
}
