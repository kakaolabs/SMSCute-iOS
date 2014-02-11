//
//  HomeViewController.m
//  TinNhanYeuThuong
//
//  Created by Kien Nguyen on 1/27/14.
//  Copyright (c) 2014 kakaolabs. All rights reserved.
//

#import "APIEngine+SMS.h"
#import "DBEngine.h"
#import "SubcategoryViewController.h"
#import "CategoryViewController.h"
#import "HomeViewController.h"


@implementation HomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    titleLabel.text = @"HOME";
    [self reloadView];
}

- (void) reloadView
{
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
            [db insertCategoryWithDict:subItem parentId:itemId];
        }
    }
    [db close];
}

- (void) saveSMSForSubCategoryId:(NSString *) subCategoryId
{
    [[APIEngine sharedEngine] getDetailOfSubCategory:subCategoryId onComplete:^(id objects) {
        NSArray *items = (NSArray *) objects;
        DBEngine *db = [DBEngine sharedEngine];
        [db open];
        for (NSDictionary *dict in items) {
            [db insertSMSWithDict:dict categoryId:subCategoryId];
        }
        [db close];
    } onError:^(NSError *error) {
    }];
}

- (void) saveFullDB
{
    for (NSDictionary *item in listItem) {
        NSString *itemId = item[@"id"];
        int type = [item[@"type"] intValue];
        if (type == 0) {
            for (NSDictionary *subItem in item[@"data"]) {
                NSString *subItemId = subItem[@"id"];
                [self saveSMSForSubCategoryId:subItemId];
            }
        } else {
            [self saveSMSForSubCategoryId:itemId];
        }
    }
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
    int type = [data[@"type"] intValue];
    
    if (type == 0) {
        CategoryViewController *controller = [[CategoryViewController alloc] initWithData:data];
        [self.navigationController pushViewController:controller animated:YES];
    } else {
        NSString *subCategoryId = data[@"id"];
        SubcategoryViewController *controller = [[SubcategoryViewController alloc] initWithSubcategoryId:subCategoryId withTitle:data[@"name"]];
        [self.navigationController pushViewController:controller animated:YES];
    }
}

@end
