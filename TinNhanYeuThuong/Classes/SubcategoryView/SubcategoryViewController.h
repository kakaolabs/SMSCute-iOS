//
//  SubcategoryViewController.h
//  TinNhanYeuThuong
//
//  Created by Kien Nguyen on 1/27/14.
//  Copyright (c) 2014 kakaolabs. All rights reserved.
//

#import <MessageUI/MessageUI.h>
#import "BaseViewController.h"
#import "SWTableViewCell.h"

@interface SubcategoryViewController : BaseViewController<
    SWTableViewCellDelegate, MFMessageComposeViewControllerDelegate> {
    int index;
    NSString *subCategoryId;
    NSString *titleName;
}

- (id) initWithSubcategoryId:(NSString *) _subcategoryId withTitle:(NSString *) name;
- (void) reloadView;
- (NSArray *) rightButtons;
@end