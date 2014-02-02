//
//  LeftMenuViewController.m
//  TinNhanYeuThuong
//
//  Created by Kien Nguyen on 1/24/14.
//  Copyright (c) 2014 kakaolabs. All rights reserved.
//

#import "JASidePanelController.h"
#import "MainViewController.h"
#import "LeftMenuViewController.h"
#import "LeftMenuTableViewCell.h"


@implementation LeftMenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        listItemIcons = [[NSMutableArray alloc] initWithArray:
                         @[@"home-menu.png",
                           @"recently-menu.png",
                           @"fav-menu.png",
                           @"fav-menu.png",
                           @"fav-menu.png"]];
        listItemNames = [[NSMutableArray alloc] initWithArray:
                        @[@"HOME",
                          @"RECENTLY USED",
                          @"FAVOURITE",
                          @"NOTIFICATIONS",
                          @"NEWS"]];
        selectedIndex = -1;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - TableViewSource
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return listItemIcons.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellNibFile = @"LeftMenuTableViewCell";
    LeftMenuTableViewCell *cell = (LeftMenuTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellNibFile];
    
    if (!cell) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:cellNibFile owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    NSString *iconPath = listItemIcons[indexPath.row];
    NSString *name = listItemNames[indexPath.row];
    BOOL isSelected = indexPath.row == selectedIndex;
    [cell setUpCellWithImage:iconPath text:name isSelected:isSelected];
    return cell;
}

#pragma mark - TableView Control
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    selectedIndex = (int) indexPath.row;
    [tableView reloadData];
    
    switch (selectedIndex) {
        case 0:
            [self.mainVC changeToHome];
            [self.viewController showCenterPanelAnimated:YES];
            break;
        case 1:
            [self.mainVC changeToRecentView];
            [self.viewController showCenterPanelAnimated:YES];
            break;
        case 2:
            [self.mainVC changeToFavouriteView];
            [self.viewController showCenterPanelAnimated:YES];
            break;
        default:
            break;
    }
}

@end
