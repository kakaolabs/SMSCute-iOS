//
//  TextViewController.m
//  TinNhanYeuThuong
//
//  Created by Kien Nguyen on 1/29/14.
//  Copyright (c) 2014 kakaolabs. All rights reserved.
//

#import "TextViewController.h"


@implementation TextViewController
@synthesize index;

- (id) initWithText:(NSString *)_text withIndex:(int)i
{
    self = [super initWithNibName:@"TextViewController" bundle:nil];
    if (self) {
        text = [NSString stringWithFormat:@"\n\n\n%@\n\n\n\n\n", _text];
        self.index = i;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    textView.text = text;
    textView.selectable = NO;
}

@end
