//
//  TextViewController.h
//  TinNhanYeuThuong
//
//  Created by Kien Nguyen on 1/29/14.
//  Copyright (c) 2014 kakaolabs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KKGAViewController.h"


@interface TextViewController : UIViewController {
    NSString *text;
    IBOutlet UITextView *textView;
}

@property (readwrite) int index;

- (id) initWithText:(NSString *) _text withIndex:(int) i;
@end
