//
//  HomeViewController.h
//  TinNhanYeuThuong
//
//  Created by Kien Nguyen on 1/27/14.
//  Copyright (c) 2014 kakaolabs. All rights reserved.
//

#import "BaseViewController.h"

@interface HomeViewController : BaseViewController

- (void) reloadView;
- (void) loadCategoriesFromDB;
- (void) requestToGetAllCategories;

@end
