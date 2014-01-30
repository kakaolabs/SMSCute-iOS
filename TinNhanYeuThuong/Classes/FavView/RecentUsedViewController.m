//
//  RecentUsedViewController.m
//  TinNhanYeuThuong
//
//  Created by Kien Nguyen on 1/29/14.
//  Copyright (c) 2014 kakaolabs. All rights reserved.
//

#import "DBEngine.h"
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


@end
