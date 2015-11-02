//
//  MainScene.h
//  The_Amazing_Juggler
//
//  Created by greyson on 10/26/15.
//  Copyright © 2015 Greyson Wright. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>


@protocol MainSceneDelegate <NSObject>

-(void)updateTime:(int)time withCrowdMeeter:(int)satisfaction;

@end


@interface MainScene : SKScene <SKPhysicsContactDelegate>

@property id<MainSceneDelegate> updateDelegate;

@end
