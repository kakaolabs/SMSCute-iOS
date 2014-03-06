//
//  LeftMenuViewController.h
//  TinNhanYeuThuong
//
//  Created by Kien Nguyen on 1/24/14.
//  Copyright (c) 2014 kakaolabs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KKGAViewController.h"

@class JASidePanelController;
@class MainViewController;

@interface LeftMenuViewController : KKGAViewController<UITableViewDataSource, UITableViewDelegate> {
    IBOutlet UITableView *menuTable;
    
    NSMutableArray *listItemIcons;
    NSMutableArray *listItemNames;
    int selectedIndex;
}

@property (strong, nonatomic) JASidePanelController *viewController;
@property (strong, nonatomic) MainViewController *mainVC;

@end