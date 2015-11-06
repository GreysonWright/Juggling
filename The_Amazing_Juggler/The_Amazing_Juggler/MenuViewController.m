//
//  MenuViewController.m
//  The_Amazing_Juggler
//
//  Created by greyson on 11/5/15.
//  Copyright © 2015 Greyson Wright. All rights reserved.
//

#import "MenuViewController.h"
#import "AppDelegate.h"
#import "MainViewController.h"
#import <iAd/iAd.h>

@interface MenuViewController ()

@end

@implementation MenuViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	
	self.canDisplayBannerAds = YES;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
	
	((AppDelegate *)[UIApplication sharedApplication].delegate).window.rootViewController = [[MainViewController alloc] init];
	
}

@end
