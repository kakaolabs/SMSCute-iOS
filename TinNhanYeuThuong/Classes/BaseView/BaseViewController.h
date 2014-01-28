//
//  HomeViewController.h
//  TinNhanYeuThuong
//
//  Created by Kien Nguyen on 1/25/14.
//  Copyright (c) 2014 kakaolabs. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JASidePanelController;

@interface BaseViewController : UIViewController<UITableViewDataSource, UITableViewDelegate> {
    IBOutlet UIButton *leftButton;
    IBOutlet UILabel *titleLabel;
    IBOutlet UIImageView *logoImageView;
    IBOutlet UITableView *categoriesTable;
    
    int selectedIndex;
    NSMutableArray *listItem;
}

@property (strong, nonatomic) JASidePanelController *viewController;

- (BOOL) isRootViewController;
- (IBAction) menuButtonPressed:(id) sender;

@end
