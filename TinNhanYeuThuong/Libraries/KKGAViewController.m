//
//  KKGAViewController.m
//  TinNhanYeuThuong
//
//  Created by Kien Nguyen on 2/5/14.
//  Copyright (c) 2014 kakaolabs. All rights reserved.
//

#import "KKGAViewController.h"

@implementation KKGAViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.screenName = NSStringFromClass([self class]);
}
@end
