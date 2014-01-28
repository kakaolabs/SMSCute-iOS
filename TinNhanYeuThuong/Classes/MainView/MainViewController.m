//
//  MainViewController.m
//  TinNhanYeuThuong
//
//  Created by Kien Nguyen on 1/27/14.
//  Copyright (c) 2014 kakaolabs. All rights reserved.
//


#import "JASidePanelController.h"

#import "HomeViewController.h"
#import "MainViewController.h"

@implementation MainViewController

+ (MainViewController *) sharedMainVC
{
    static MainViewController *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[MainViewController alloc] init];
    });
    return sharedManager;
}

- (id) init
{
    self = [super init];
    if (self) {
        [[UINavigationBar appearance] setBarTintColor:[UIColor clearColor]];
    }
    return self;
}

- (void) setUpNavigationBar
{
    self.navigationBarHidden = YES;
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
}

- (void) viewDidLoad
{
    [self setUpNavigationBar];
    [self changeToHome];
}

- (void) showLeftMenu
{
     [self.viewController showLeftPanelAnimated:YES];
}

- (void) changeToHome
{
    if (!homeVC) {
        homeVC = [[HomeViewController alloc] initWithNibName:@"BaseViewController" bundle:nil];
    }
    [self popToRootViewControllerAnimated:NO];
    [self setViewControllers:[NSArray arrayWithObjects:homeVC, nil]];
}

@end
