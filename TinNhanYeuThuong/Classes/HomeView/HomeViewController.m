//
//  HomeViewController.m
//  TinNhanYeuThuong
//
//  Created by Kien Nguyen on 1/27/14.
//  Copyright (c) 2014 kakaolabs. All rights reserved.
//

#import "APIEngine+SMS.h"
#import "DBEngine.h"
#import "CategoryViewController.h"
#import "HomeViewController.h"


@implementation HomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    logoImageView.hidden = NO;
    titleLabel.text = @"HOME";
    
    [self loadCategoriesFromDB];
    [self requestToGetAllCategories];
}

#pragma mark - DB
- (void) loadCategoriesFromDB
{
    NSArray *items = [[DBEngine sharedEngine] getCategories];
    for (NSDictionary *item in items) {
        [listItem addObject:item];
    }
    [categoriesTable reloadData];
}

- (void) saveCategoriesToDB
{
    DBEngine *db = [DBEngine sharedEngine];
    [db open];
    for (NSDictionary *item in listItem) {
        [[DBEngine sharedEngine] insertCategoryWithDict:item parentId:nil];
        NSString *itemId = item[@"id"];
        for (NSDictionary *subItem in item[@"data"]) {
            [[DBEngine sharedEngine] insertCategoryWithDict:subItem parentId:itemId];
        }
    }
    [db close];
}

#pragma mark - request
- (void) requestToGetAllCategories
{
    [[APIEngine sharedEngine] getListCategories:^(id objects) {
        [listItem removeAllObjects];
        
        NSArray *items = (NSArray *) objects;
        for (NSDictionary *item in items) {
            [listItem addObject:item];
        }
        
        [categoriesTable reloadData];
        
        [self saveCategoriesToDB];
    } onError:^(NSError *error) {
        
    }];
}

#pragma mark - TableView
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    
    NSDictionary *data = listItem[indexPath.row];
    CategoryViewController *controller = [[CategoryViewController alloc] initWithData:data];
    [self.navigationController pushViewController:controller animated:YES];
}

@end
