//
//  MainViewController.m
//  The_Amazing_Juggler
//
//  Created by greyson on 10/26/15.
//  Copyright © 2015 Greyson Wright. All rights reserved.
//

#import "MainViewController.h"
#import "MainScene.h"
#import "AppDelegate.h"
#import "MenuViewController.h"
#import <iAd/iAd.h>

@interface MainViewController () {
	
	MainScene *_scene;
	
}

@property (strong, nonatomic) IBOutlet SKView *sceneView;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UIImageView *crowdStatusImageView;

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
	_scene = [[MainScene alloc] initWithSize: [UIScreen mainScreen].bounds.size];
	_scene.updateDelegate = self;
	_scene.scaleMode = SKSceneScaleModeAspectFill;
	
	// Present the scene.
	[skView presentScene:_scene];
	
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)updateTime:(int)time withCrowdMeeter:(int)satisfaction {
	
	self.timeLabel.text = [NSString stringWithFormat: @"%d:%02d", (time / 60) % 60, time % 60];
	
	if (satisfaction < 25) {
		
		self.crowdStatusImageView.backgroundColor = [UIColor redColor];
		
	} else if (satisfaction < 50) {
		
		self.crowdStatusImageView.backgroundColor = [UIColor orangeColor];
		
	} else if (satisfaction < 75) {
		
		self.crowdStatusImageView.backgroundColor = [UIColor yellowColor];
		
	} else if (satisfaction > 75) {
		
		self.crowdStatusImageView.backgroundColor = [UIColor greenColor];
		
	}
	
}

-(void)gameEnded {
	
	((AppDelegate *)[UIApplication sharedApplication].delegate).window.rootViewController = [[MenuViewController alloc] init];
	
}

@end
