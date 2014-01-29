//
//  SMSViewController.h
//  TinNhanYeuThuong
//
//  Created by Kien Nguyen on 1/28/14.
//  Copyright (c) 2014 kakaolabs. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface SMSViewController : UIViewController<MFMessageComposeViewControllerDelegate, UIPageViewControllerDataSource> {
    
    IBOutlet UIButton *closeButton;
    IBOutlet UITextView *textView;
    IBOutlet UIButton *shareButton;
    IBOutlet UIButton *likeButton;
    IBOutlet UIButton *convertButton;
    
    UIPageViewController *pageController;
    
    NSArray *data;
    int index;
}

- (id) initWithData:(NSArray *) _data atIndex:(int) _index;
- (IBAction) closeButtonPressed:(id) sender;
- (IBAction) shareButtonPressed:(id) sender;
- (IBAction) likeButtonPressed:(id) sender;

@end