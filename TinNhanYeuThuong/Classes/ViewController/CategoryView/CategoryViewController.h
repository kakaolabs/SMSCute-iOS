//
//  CategoryViewController.h
//  TinNhanYeuThuong
//
//  Created by Kien Nguyen on 1/27/14.
//  Copyright (c) 2014 kakaolabs. All rights reserved.
//

#import "BaseViewController.h"

@interface CategoryViewController : BaseViewController {
    NSDictionary *data;
}

- (id) initWithData:(NSDictionary *) data;
@end
