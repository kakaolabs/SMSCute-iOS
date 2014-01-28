//
//  HomeTableViewCell.m
//  TinNhanYeuThuong
//
//  Created by Kien Nguyen on 1/27/14.
//  Copyright (c) 2014 kakaolabs. All rights reserved.
//

#import "BaseTableViewCell.h"

@implementation BaseTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {}
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (void) setUpCellWithDictionary:(NSDictionary *) dict isSelected:(BOOL) isSelected
{
    if (isSelected) {
        self.backgroundColor = [UIColor colorWithRed:0/255 green:89.0/255 blue:107.0/255 alpha:1.0];
        nameLabel.textColor = [UIColor whiteColor];
    } else {
        self.backgroundColor = [UIColor clearColor];
        nameLabel.textColor = [UIColor colorWithRed:20.0/255 green:108.0/255 blue:136.0/255 alpha:1.0];
    }
    
    isSubcategory = [dict[@"type"] intValue] == 1;
    categoryId = dict[@"id"];
    nameLabel.text = [dict[@"name"] uppercaseString];
    data = dict[@"data"];
}

@end
