//
//  SubcategoryViewCell.h
//  TinNhanYeuThuong
//
//  Created by Kien Nguyen on 1/27/14.
//  Copyright (c) 2014 kakaolabs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SubcategoryViewCell : UITableViewCell {
    NSDictionary *data;
    IBOutlet UITextView *contentText;
}

- (void) setUpCellWithDictionary:(NSDictionary *) dict isSelected:(BOOL) isSelected;
@end
