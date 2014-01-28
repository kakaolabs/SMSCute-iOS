//
//  CustomFontUILabel.m
//  TinNhanYeuThuong
//
//  Created by Kien Nguyen on 1/26/14.
//  Copyright (c) 2014 kakaolabs. All rights reserved.
//

#import "CustomFontUILabel.h"

@implementation CustomFontUILabel

-(void) awakeFromNib
{
    [super awakeFromNib];
    self.font = [UIFont fontWithName:@"ProximaNova-Bold"
                                size:self.font.pointSize];
}

@end
