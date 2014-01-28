//
//  SMSViewController.m
//  TinNhanYeuThuong
//
//  Created by Kien Nguyen on 1/28/14.
//  Copyright (c) 2014 kakaolabs. All rights reserved.
//

#import "JASidePanelController.h"
#import "MainViewController.h"
#import "SMSViewController.h"

@implementation SMSViewController

- (id) initWithContent:(NSString *) _content
{
    self = [super initWithNibName:@"SMSViewController" bundle:nil];
    if (self) {
        content = _content;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    contentTextView.text = content;
}


@end
