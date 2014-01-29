//
//  TextViewController.m
//  TinNhanYeuThuong
//
//  Created by Kien Nguyen on 1/29/14.
//  Copyright (c) 2014 kakaolabs. All rights reserved.
//

#import "TextViewController.h"

@interface TextViewController ()

@end

@implementation TextViewController

- (id) initWIthText:(NSString *)_text
{
    self = [super initWithNibName:@"TextViewController" bundle:nil];
    if (self) {
        text = _text;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    textView.text = text;
}

@end
