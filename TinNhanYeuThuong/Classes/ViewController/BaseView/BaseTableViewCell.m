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
        self.backgroundColor = SELECTED_BACKGROUND_COLOR;
        nameLabel.textColor = [UIColor whiteColor];
    } else {
        self.backgroundColor = [UIColor clearColor];
        nameLabel.textColor = TEXT_COLOR;
    }
    
    isSubcategory = [dict[@"type"] intValue] == 1;
    categoryId = dict[@"id"];
    nameLabel.text = [dict[@"name"] uppercaseString];
    data = dict[@"data"];
}

@end
