//
//  LeftMenuTableViewCell.m
//  TinNhanYeuThuong
//
//  Created by Kien Nguyen on 1/25/14.
//  Copyright (c) 2014 kakaolabs. All rights reserved.
//

#import "LeftMenuTableViewCell.h"

@implementation LeftMenuTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (void) setUpCellWithImage:(NSString *) imagePath text:(NSString *) text isSelected:(BOOL) isSelected
{
    nameLabel.text = text;
    if (isSelected) {
        self.backgroundColor = SELECTED_BACKGROUND_COLOR;
        nameLabel.textColor = [UIColor whiteColor];
        imagePath = [NSString stringWithFormat:@"white-%@", imagePath];
    } else {
        self.backgroundColor = [UIColor clearColor];
        nameLabel.textColor = TEXT_COLOR;
        
    }
    [iconImage setImage:[UIImage imageNamed:imagePath]];
}

@end
