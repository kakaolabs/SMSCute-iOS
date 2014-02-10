//
//  HomeViewController.m
//  TinNhanYeuThuong
//
//  Created by Kien Nguyen on 1/25/14.
//  Copyright (c) 2014 kakaolabs. All rights reserved.
//

#import "JASidePanelController.h"

#import "BaseTableViewCell.h"
#import "MainViewController.h"
#import "HomeViewController.h"


@implementation BaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        listItem = [[NSMutableArray alloc] init];
        selectedIndex = -1;
    }
    return self;
}

- (BOOL) isRootViewController
{
    NSArray *viewControllers = self.navigationController.viewControllers;
    UIViewController *rootView = [viewControllers objectAtIndex:0];
    return rootView == self;
}

- (void) setUpLeftButton
{
    NSString *imagePath = @"menu-back.png";
    if ([self isRootViewController]) {
        imagePath = @"menu-open.png";
    }
    UIImage *image = [UIImage imageNamed:imagePath];
    [leftButton setImage:image forState:UIControlStateNormal];
}

- (void) setUpTableView
{
    UINib *nibFile = [UINib nibWithNibName:@"BaseTableViewCell"
                                    bundle:[NSBundle mainBundle]];
    [categoriesTable registerNib: nibFile
          forCellReuseIdentifier:@"BaseTableViewCell"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setUpLeftButton];
    [self setUpTableView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#pragma mark - TableViewSource
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return listItem.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellNibFile = @"BaseTableViewCell";
    BaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellNibFile];
    
    if (!cell) {
        cell = (BaseTableViewCell *)[[NSClassFromString(cellNibFile) alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellNibFile];
    }
    
    NSDictionary *item = listItem[indexPath.row];
    BOOL isSelected = selectedIndex == indexPath.row;
    [cell setUpCellWithDictionary:item isSelected:isSelected];
    return cell;
}

#pragma mark - TableView Control
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    selectedIndex = (int) indexPath.row;
    [tableView reloadData];
}

#pragma mark - IBActions
- (IBAction) menuButtonPressed:(id)sender
{
    if ([self isRootViewController]) {
        MainViewController *parent = (MainViewController *)self.navigationController;
        [parent.viewController showLeftPanelAnimated:YES];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
