//
//  SubcategoryViewCell.m
//  TinNhanYeuThuong
//
//  Created by Kien Nguyen on 1/27/14.
//  Copyright (c) 2014 kakaolabs. All rights reserved.
//

#import "SubcategoryViewCell.h"

@implementation SubcategoryViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    }
    return self;
}

- (void) setUpCellWithDictionary:(NSDictionary *) dict isSelected:(BOOL) isSelected
{
    data = dict;
    contentText.scrollEnabled = NO;
    contentText.text = data[@"content"];
}

@end
