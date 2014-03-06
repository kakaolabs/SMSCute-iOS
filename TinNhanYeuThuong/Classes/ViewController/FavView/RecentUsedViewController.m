//
//  RecentUsedViewController.m
//  TinNhanYeuThuong
//
//  Created by Kien Nguyen on 1/29/14.
//  Copyright (c) 2014 kakaolabs. All rights reserved.
//

#import "UIViewController+MessageHandle.h"
#import "DBEngine.h"
#import "SubcategoryViewCell.h"
#import "RecentUsedViewController.h"


@implementation RecentUsedViewController

- (void) reloadView
{
    titleLabel.text = @"RECENTLY USED SMS";
    
    DBEngine *db = [DBEngine sharedEngine];
    [db open];
    
    listItem = [[NSMutableArray alloc] initWithArray:[db getRecentUsedSMS]];
    [categoriesTable reloadData];
    
    [db close];
}

- (NSArray *) rightButtons
{
    NSMutableArray *rightButtons = [NSMutableArray new];
    [rightButtons sw_addUtilityButtonWithColor: MORE_BUTTON_COLOR
                                         title:@"Send"];
    [rightButtons sw_addUtilityButtonWithColor: DELETE_BUTTON_COLOR
                                         title:@"Delete"];
    return rightButtons;
}

- (void) swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index
{
    SubcategoryViewCell *subCategoryCell = (SubcategoryViewCell *) cell;
    switch (index) {
        case 0:
        {
            NSString *content = [subCategoryCell.contentText.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            [self presentViewControllerToSendSMSWithContent:content];
            break;
        }
        case 1:
        {
            NSString *smsId = subCategoryCell.data[@"id"];
            [[DBEngine sharedEngine] markSMSContentIsRead:smsId isRead:NO];
            [self reloadView];
            break;
        }
    }
}

@end