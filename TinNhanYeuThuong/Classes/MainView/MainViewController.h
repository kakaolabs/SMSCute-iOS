//
//  MainViewController.h
//  TinNhanYeuThuong
//
//  Created by Kien Nguyen on 1/27/14.
//  Copyright (c) 2014 kakaolabs. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JASidePanelController;
@class HomeViewController;
@class FavViewController;
@class RecentUsedViewController;

@interface MainViewController : UINavigationController {
    HomeViewController *homeVC;
    FavViewController *favVC;
    RecentUsedViewController *recentVC;
}

@property (strong, nonatomic) JASidePanelController *viewController;

+ (MainViewController *) sharedMainVC;

- (void) showLeftMenu;
- (void) changeToHome;
- (void) changeToFavouriteView;
- (void) changeToRecentView;
@end
