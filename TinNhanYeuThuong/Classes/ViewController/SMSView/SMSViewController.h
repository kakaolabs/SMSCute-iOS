//
//  SMSViewController.h
//  TinNhanYeuThuong
//
//  Created by Kien Nguyen on 1/28/14.
//  Copyright (c) 2014 kakaolabs. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "KKGAViewController.h"

@interface SMSViewController : KKGAViewController<MFMessageComposeViewControllerDelegate, UIPageViewControllerDataSource, UIPageViewControllerDelegate> {
    
    IBOutlet UIButton *closeButton;
    IBOutlet UIButton *shareButton;
    IBOutlet UIButton *likeButton;
    IBOutlet UIView *messageView;
    IBOutlet UILabel *messageLabel;
    IBOutlet UILabel *titleLabel;
    
    UIPageViewController *pageController;
    
    NSArray *data;
    int index;
}

- (id) initWithData:(NSArray *) _data atIndex:(int) _index;
- (IBAction) closeButtonPressed:(id) sender;
- (IBAction) shareButtonPressed:(id) sender;
- (IBAction) likeButtonPressed:(id) sender;

@end
