//
//  HomeViewController.h
//  TinNhanYeuThuong
//
//  Created by Kien Nguyen on 1/25/14.
//  Copyright (c) 2014 kakaolabs. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JASidePanelController;

@interface HomeViewController : UIViewController {
    IBOutlet UIButton *menuButton;
    IBOutlet UILabel *titleLabel;
}

@property (strong, nonatomic) JASidePanelController *viewController;

- (IBAction) menuButtonPressed:(id) sender;

@end
