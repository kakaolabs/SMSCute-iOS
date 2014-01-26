//
//  UIViewController+Font.m
//  TinNhanYeuThuong
//
//  Created by Kien Nguyen on 1/26/14.
//  Copyright (c) 2014 kakaolabs. All rights reserved.
//

#import "UIViewController+Font.h"

@implementation UIViewController (Font)

- (void) logAllFonts
{
    for (NSString* family in [UIFont familyNames]) {
        NSLog(@"%@", family);
        for (NSString* name in [UIFont fontNamesForFamilyName: family]) {
            NSLog(@"  %@", name);
        }
    }
}

@end
