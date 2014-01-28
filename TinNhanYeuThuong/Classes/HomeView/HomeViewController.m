//
//  HomeViewController.m
//  TinNhanYeuThuong
//
//  Created by Kien Nguyen on 1/27/14.
//  Copyright (c) 2014 kakaolabs. All rights reserved.
//

#import "APIEngine+SMS.h"
#import "CategoryViewController.h"
#import "HomeViewController.h"


@implementation HomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    logoImageView.hidden = NO;
    titleLabel.text = @"HOME";
    [self requestToGetAllCategories];
}

#pragma mark - request
- (void) requestToGetAllCategories
{
    [[APIEngine sharedEngine] getListCategories:^(id objects) {
        NSArray *items = (NSArray *) objects;
        for (NSDictionary *item in items) {
            [listItem addObject:item];
        }
        [categoriesTable reloadData];
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
