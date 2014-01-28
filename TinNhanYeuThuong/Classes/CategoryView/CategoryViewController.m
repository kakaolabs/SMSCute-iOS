//
//  CategoryViewController.m
//  TinNhanYeuThuong
//
//  Created by Kien Nguyen on 1/27/14.
//  Copyright (c) 2014 kakaolabs. All rights reserved.
//

#import "SubcategoryViewController.h"
#import "CategoryViewController.h"

@implementation CategoryViewController
- (id) initWithData:(NSDictionary *) _data
{
    self = [super initWithNibName:@"BaseViewController" bundle:nil];
    if (self) {
        data = _data;
        listItem = [NSMutableArray arrayWithArray:data[@"data"]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    titleLabel.text = [data[@"name"] uppercaseString];
    [categoriesTable reloadData];
}


#pragma mark - TableView
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    
    NSDictionary *item = listItem[indexPath.row];
    NSString *subCategoryId = item[@"id"];
    SubcategoryViewController *controller = [[SubcategoryViewController alloc] initWithSubcategoryId:subCategoryId withTitle:data[@"name"]];
    [self.navigationController pushViewController:controller animated:YES];
}

@end
