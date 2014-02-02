//
//  SubcategoryViewCell.h
//  TinNhanYeuThuong
//
//  Created by Kien Nguyen on 1/27/14.
//  Copyright (c) 2014 kakaolabs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWTableViewCell.h"

@interface SubcategoryViewCell : SWTableViewCell
{
    IBOutlet UILabel *titleLabel;
}

@property (nonatomic, weak) IBOutlet UITextView *contentText;
@property (nonatomic, retain) NSDictionary *data;

- (void) setUpCellWithDictionary:(NSDictionary *) dict isSelected:(BOOL) isSelected;
@end
