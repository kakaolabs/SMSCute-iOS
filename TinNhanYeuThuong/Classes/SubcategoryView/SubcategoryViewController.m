//
//  SubcategoryViewController.m
//  TinNhanYeuThuong
//
//  Created by Kien Nguyen on 1/27/14.
//  Copyright (c) 2014 kakaolabs. All rights reserved.
//

#import "UIViewController+MessageHandle.h"
#import "APIEngine+SMS.h"
#import "DBEngine.h"
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
    
    NSString *cellNibFile = @"SubcategoryViewCell";
    UINib *cellNib = [UINib nibWithNibName:cellNibFile bundle:nil];
    [categoriesTable registerNib:cellNib forCellReuseIdentifier:cellNibFile];
    
    categoriesTable.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self reloadView];
}

- (void) reloadView
{
    [self loadSMSContentFromDB];
    [self requestToGetSubcategoryDetail];
}

- (void) loadSMSContentFromDB
{
    DBEngine *db = [DBEngine sharedEngine];
    [db open];
    
    listItem = [[NSMutableArray alloc] initWithArray:[db getSMSForCategory:subCategoryId]];
    [categoriesTable reloadData];
    
    [db close];
}

- (void) insertSMSToDB
{
    DBEngine *db = [DBEngine sharedEngine];
    [db open];
    
    for (NSDictionary *dict in listItem) {
        [db insertSMSWithDict:dict categoryId:subCategoryId];
    }
    
    [db close];
}

#pragma mark - Request
- (void) requestToGetSubcategoryDetail {
    [[APIEngine sharedEngine] getDetailOfSubCategory:subCategoryId onComplete:^(id objects) {
        [listItem removeAllObjects];
        
        NSArray *items = (NSArray *) objects;
        for (NSDictionary *item in items) {
            [listItem addObject:item];
        }
        [listItem sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            NSDictionary *item1 = (NSDictionary *) obj1;
            NSDictionary *item2 = (NSDictionary *) obj2;
            return [item1[@"content"] compare:item2[@"content"]];
        }];
        [categoriesTable reloadData];
        
        [self insertSMSToDB];
    } onError:^(NSError *error) {
    }];
}

#pragma mark - TableDataSource
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90.0;
}

- (NSArray *) rightButtons
{
    NSMutableArray *rightButtons = [NSMutableArray new];
    UIColor *moreButtonColor = [UIColor colorWithRed:0.78f green:0.78f blue:0.8f alpha:1.0];
    [rightButtons sw_addUtilityButtonWithColor: moreButtonColor
                                         title:@"Send"];
    return rightButtons;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellNibFile = @"SubcategoryViewCell";
    SubcategoryViewCell *cell = (SubcategoryViewCell *)[tableView dequeueReusableCellWithIdentifier:cellNibFile];
    
    SubcategoryViewCell __weak *weakCell = cell;
    [cell setAppearanceWithBlock:^{
        weakCell.rightUtilityButtons = [self rightButtons];
        weakCell.delegate = self;
        weakCell.containingTableView = tableView;
    } force:NO];
    [cell setCellHeight:cell.frame.size.height];
    [cell setBackgroundColor:[UIColor clearColor]];
    
    NSDictionary *item = listItem[indexPath.row];
    BOOL isSelected = selectedIndex == indexPath.row;
    [cell setUpCellWithDictionary:item isSelected:isSelected];
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    index = (int) indexPath.row;
    SMSViewController *controller = [[SMSViewController alloc] initWithData:listItem atIndex:index];
    [self presentViewController:controller animated:YES completion:^{}];
}

#pragma mark - SWTableViewCell delegate
- (void) swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index
{
    switch (index) {
        case 0:
        {
            SubcategoryViewCell *subCategoryCell = (SubcategoryViewCell *) cell;
            NSString *content = [subCategoryCell.contentText.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            [self presentViewControllerToSendSMSWithContent:content];
            break;
        }
    }
}

- (BOOL)swipeableTableViewCellShouldHideUtilityButtonsOnSwipe:(SWTableViewCell *)cell
{
    return YES;
}

#pragma mark - MFMessageHandle
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    [self messageComposeViewController:controller didFinishWithResult:result withSMSId:listItem[index][@"id"]];
}
@end
