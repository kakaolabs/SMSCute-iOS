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
    
    if (isSelected) {
        self.backgroundColor = [UIColor colorWithRed:0/255 green:89.0/255 blue:107.0/255 alpha:1.0];
        contentText.textColor = [UIColor whiteColor];
    } else {
        self.backgroundColor = [UIColor clearColor];
        contentText.textColor = [UIColor colorWithRed:20.0/255 green:108.0/255 blue:136.0/255 alpha:1.0];
    }

}

@end
