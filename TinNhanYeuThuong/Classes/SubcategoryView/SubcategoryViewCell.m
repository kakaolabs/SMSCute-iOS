//
//  SubcategoryViewCell.m
//  TinNhanYeuThuong
//
//  Created by Kien Nguyen on 1/27/14.
//  Copyright (c) 2014 kakaolabs. All rights reserved.
//

#import "SubcategoryViewCell.h"

@implementation SubcategoryViewCell
@synthesize data, contentText;

- (void) setUpCellWithDictionary:(NSDictionary *) dict isSelected:(BOOL) isSelected
{
    self.data = dict;
    self.contentText.scrollEnabled = NO;
    self.contentText.text = self.data[@"content"];
    titleLabel.text = [self.data[@"content"] componentsSeparatedByString:@"\n"][0];
}

@end
