//
//  DBEngine.h
//  TinNhanYeuThuong
//
//  Created by Kien Nguyen on 1/29/14.
//  Copyright (c) 2014 kakaolabs. All rights reserved.
//

#import "sqlite3.h"
#import "FMDatabase.h"

@interface DBEngine : FMDatabase

+ (id) sharedEngine;
- (void) createTables;
- (void) insertCategoryWithDict:(NSDictionary *) dict parentId:(NSString *)parentId;
- (void) insertSMSWithDict:(NSDictionary *) dict categoryId:(NSString *)categoryId;
- (NSArray *) getCategories;
- (NSArray *) getSMSForCategory:(NSString *) categoryId;
@end
