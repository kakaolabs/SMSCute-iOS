//
//  SubcategoryViewController.m
//  TinNhanYeuThuong
//
//  Created by Kien Nguyen on 1/27/14.
//  Copyright (c) 2014 kakaolabs. All rights reserved.
//

#import "APIEngine+SMS.h"
#import "SMSViewController.h"
#import "SubcategoryViewCell.h"
#import "SubcategoryViewController.h"

@implementation SubcategoryViewController
- (id) initWithSubcategoryId:(NSString *) _subcategoryId withTitle:(NSString *)name
{
    self = [super initWithNibName:@"BaseViewController" bundle:nil];
    if (self) {
        subCategoryId = _subcategoryId;
        titleName = name;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    titleLabel.text = [titleName uppercaseString];
    
    UINib *nibFile = [UINib nibWithNibName:@"SubcategoryViewCell"
                                    bundle:[NSBundle mainBundle]];
    [categoriesTable registerNib: nibFile
          forCellReuseIdentifier:@"SubcategoryViewCell"];
    categoriesTable.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    [self requestToGetSubcategoryDetail];
}

#pragma mark - Request
- (void) requestToGetSubcategoryDetail {
    [[APIEngine sharedEngine] getDetailOfSubCategory:subCategoryId onComplete:^(id objects) {
        NSArray *items = (NSArray *) objects;
        for (NSDictionary *item in items) {
            [listItem addObject:item];
        }
        [categoriesTable reloadData];
    } onError:^(NSError *error) {
    }];
}

#pragma mark - TableDataSource
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellNibFile = @"SubcategoryViewCell";
    SubcategoryViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellNibFile];
    
    if (!cell) {
        cell = (SubcategoryViewCell *)[[NSClassFromString(cellNibFile) alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellNibFile];
    }
    
    NSDictionary *item = listItem[indexPath.row];
    BOOL isSelected = selectedIndex == indexPath.row;
    [cell setUpCellWithDictionary:item isSelected:isSelected];
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    
    SMSViewController *controller = [[SMSViewController alloc] initWithData:listItem atIndex:(int) indexPath.row];
    [self presentViewController:controller animated:YES completion:^{}];
    //[self.navigationController pushViewController:controller animated:YES];
}

@end
