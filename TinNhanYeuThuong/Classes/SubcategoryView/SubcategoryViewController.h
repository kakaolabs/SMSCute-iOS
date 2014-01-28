//
//  SubcategoryViewController.h
//  TinNhanYeuThuong
//
//  Created by Kien Nguyen on 1/27/14.
//  Copyright (c) 2014 kakaolabs. All rights reserved.
//

#import "BaseViewController.h"

@interface SubcategoryViewController : BaseViewController {
    NSString *subCategoryId;
    NSString *titleName;
}

- (id) initWithSubcategoryId:(NSString *) _subcategoryId withTitle:(NSString *) name;

@end
