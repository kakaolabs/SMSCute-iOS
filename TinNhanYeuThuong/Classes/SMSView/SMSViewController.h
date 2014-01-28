//
//  SMSViewController.h
//  TinNhanYeuThuong
//
//  Created by Kien Nguyen on 1/28/14.
//  Copyright (c) 2014 kakaolabs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SMSViewController : UIViewController {
    NSString *content;
    IBOutlet UIButton *closeButton;
    IBOutlet UITextView *contentTextView;
    IBOutlet UIButton *shareButton;
    IBOutlet UIButton *likeButton;
    IBOutlet UIButton *convertButton;
}

- (id) initWithContent:(NSString *) _content;

@end
