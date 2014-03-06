//
//  HomeViewController.h
//  TinNhanYeuThuong
//
//  Created by Kien Nguyen on 1/25/14.
//  Copyright (c) 2014 kakaolabs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KKGAViewController.h"

@class JASidePanelController;

@interface BaseViewController : KKGAViewController<UITableViewDataSource, UITableViewDelegate> {
    IBOutlet UIButton *leftButton;
    IBOutlet UILabel *titleLabel;
    IBOutlet UITableView *categoriesTable;
    
    int selectedIndex;
    NSMutableArray *listItem;
}

@property (strong, nonatomic) JASidePanelController *viewController;

- (BOOL) isRootViewController;
- (IBAction) menuButtonPressed:(id) sender;

@end
