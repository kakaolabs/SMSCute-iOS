//
//  LeftMenuTableViewCell.h
//  TinNhanYeuThuong
//
//  Created by Kien Nguyen on 1/25/14.
//  Copyright (c) 2014 kakaolabs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeftMenuTableViewCell : UITableViewCell {
    IBOutlet UIImageView *iconImage;
    IBOutlet UILabel *nameLabel;
    IBOutlet UIView *selectedView;
}

- (void) setUpCellWithImage:(NSString *) imagePath text:(NSString *) text isSelected:(BOOL) isSelected;
@end
