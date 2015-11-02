//
//  MainViewController.m
//  The_Amazing_Juggler
//
//  Created by greyson on 10/26/15.
//  Copyright © 2015 Greyson Wright. All rights reserved.
//

#import "MainViewController.h"
#import "MainScene.h"
#import <iAd/iAd.h>

@interface MainViewController ()

@property (strong, nonatomic) IBOutlet SKView *sceneView;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];

	self.canDisplayBannerAds = YES;
	
	// Configure the view.
	SKView * skView = self.sceneView;
	skView.showsFPS = YES;
	skView.showsNodeCount = YES;
	/* Sprite Kit applies additional optimizations to improve rendering performance */
	skView.ignoresSiblingOrder = YES;
	skView.multipleTouchEnabled = YES;
	
	// Create and configure the scene.
	MainScene *scene = [[MainScene alloc] initWithSize: [UIScreen mainScreen].bounds.size];
	scene.scaleMode = SKSceneScaleModeAspectFill;
	
	// Present the scene.
	[skView presentScene:scene];
	
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
