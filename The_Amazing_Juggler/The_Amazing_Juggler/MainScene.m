//
//  MainScene.m
//  The_Amazing_Juggler
//
//  Created by greyson on 10/26/15.
//  Copyright © 2015 Greyson Wright. All rights reserved.
//

#import "MainScene.h"

@interface MainScene () {
	
	SKSpriteNode *_player;
	int _satisfaction;
	int _seconds;
	int _ballCount;
	
}

@end

@implementation MainScene

-(float)generateRandomNumber:(float)lowerBound to:(float)upperBound {
	
	return (((float)arc4random() / 0x100000000) * (upperBound - lowerBound) + lowerBound);
	
}

-(void)gameTimeUpdate {
	
	_seconds++;
	
	[self.updateDelegate updateTime: _seconds withCrowdMeeter: _satisfaction];
	
	if (_seconds % 5 == 0 && _ballCount < 5) {
		
		[self createBall];
		
	}
	
}

-(void)createBall {
	
	SKShapeNode *ball = [SKShapeNode shapeNodeWithCircleOfRadius: 5];
	ball.fillColor = [UIColor blueColor];
	ball.strokeColor = ball.fillColor;
	ball.position = CGPointMake(CGRectGetMidX(_player.frame), CGRectGetMaxY(_player.frame) + 50);
	ball.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius: 5];
	ball.physicsBody.collisionBitMask = 0;
	ball.physicsBody.contactTestBitMask = 1;
	[self addChild: ball];
	
	[ball.physicsBody applyImpulse: CGVectorMake(0.3 * [self generateRandomNumber: -1.0 to: 1.0], 1.7)];
	_ballCount++;
	
}

-(void)didMoveToView:(SKView *)view {
	
	self.physicsWorld.gravity = CGVectorMake(0, -3);
	self.physicsWorld.contactDelegate = self;
	self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect: self.frame];
	self.physicsBody.contactTestBitMask = 3;
	self.physicsBody.collisionBitMask = 1;
	
	_seconds = 0;
	
	_player = [[SKSpriteNode alloc] initWithColor: [UIColor redColor] size: CGSizeMake(30, 30)];
	_player.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMinY(self.frame) + 120);
	_player.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize: _player.size];
	_player.physicsBody.dynamic = NO;
	_player.physicsBody.categoryBitMask = 0;
	_player.physicsBody.collisionBitMask = 0;
	_player.physicsBody.contactTestBitMask = 2;
	[self addChild: _player];
	
	[self createBall];
	
	[NSTimer scheduledTimerWithTimeInterval: 1 target: self selector: @selector(gameTimeUpdate) userInfo: nil repeats:YES];
	
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
	
	for (UITouch *touch in touches) {
		
		_player.position = CGPointMake([touch locationInNode: self].x, _player.position.y);
		
	}
	
}

-(void)didBeginContact:(SKPhysicsContact *)contact {
	
	if (contact.bodyA.contactTestBitMask == 3) {
		
		contact.bodyB.velocity = CGVectorMake(contact.bodyB.velocity.dx * -0.5, contact.bodyB.velocity.dy);
		
	} else if (contact.bodyA.contactTestBitMask == 2) {

		[contact.bodyB applyImpulse: CGVectorMake(0.1 * [self generateRandomNumber: -1.0 to: 1.0], 3.5)];
		contact.bodyB.velocity = CGVectorMake(contact.bodyB.velocity.dx, fmin(contact.bodyB.velocity.dy, 600));
		
	}
	
	if (contact.contactPoint.y < CGRectGetMinY(_player.frame) - 10) {
		
		[contact.bodyB.node removeFromParent];
		_ballCount--;
		
	}
	
}

@end
