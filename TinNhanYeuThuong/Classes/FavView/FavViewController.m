//
//  FavViewController.m
//  TinNhanYeuThuong
//
//  Created by Kien Nguyen on 1/29/14.
//  Copyright (c) 2014 kakaolabs. All rights reserved.
//

#import "DBEngine.h"
#import "FavViewController.h"

@implementation FavViewController

- (void) reloadView
{
    titleLabel.text = @"FAVOURITE SMS";
    
    DBEngine *db = [DBEngine sharedEngine];
    [db open];
    listItem = [[NSMutableArray alloc] initWithArray:[db getFavouriteSMS]];
    [categoriesTable reloadData];
    
    [db close];
}
@end
