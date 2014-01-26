//
//  LeftMenuViewController.h
//  TinNhanYeuThuong
//
//  Created by Kien Nguyen on 1/24/14.
//  Copyright (c) 2014 kakaolabs. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JASidePanelController;

@interface LeftMenuViewController : UIViewController<UITableViewDataSource, UITableViewDelegate> {
    IBOutlet UITableView *menuTable;
    
    NSMutableArray *listItemIcons;
    NSMutableArray *listItemNames;
    int selectedIndex;
}

@property (strong, nonatomic) JASidePanelController *viewController;

@end
