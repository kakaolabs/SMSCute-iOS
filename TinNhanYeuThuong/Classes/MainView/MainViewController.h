//
//  MainViewController.h
//  TinNhanYeuThuong
//
//  Created by Kien Nguyen on 1/27/14.
//  Copyright (c) 2014 kakaolabs. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HomeViewController;
@class JASidePanelController;

@interface MainViewController : UINavigationController {
    HomeViewController *homeVC;
}

@property (strong, nonatomic) JASidePanelController *viewController;

+ (MainViewController *) sharedMainVC;

- (void) showLeftMenu;
- (void) changeToHome;

@end
