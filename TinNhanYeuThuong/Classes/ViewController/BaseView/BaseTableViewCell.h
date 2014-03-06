//
//  HomeTableViewCell.h
//  TinNhanYeuThuong
//
//  Created by Kien Nguyen on 1/27/14.
//  Copyright (c) 2014 kakaolabs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTableViewCell : UITableViewCell {
    IBOutlet UILabel *nameLabel;
    BOOL isSubcategory;
    NSMutableArray *data;
    
    NSString *categoryId;
}

- (void) setUpCellWithDictionary:(NSDictionary *) dict isSelected:(BOOL) isSelected;

@end
