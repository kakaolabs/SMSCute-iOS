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

+ (DBEngine *) sharedEngine;
- (void) createTables;

- (void) insertCategoryWithDict:(NSDictionary *) dict parentId:(NSString *)parentId;
- (void) insertSMSWithDict:(NSDictionary *) dict categoryId:(NSString *)categoryId;
- (void) markSMSContentIsRead:(NSString *) smsId isRead:(BOOL) isRead;
- (void) markSMSContentIsFavourite:(NSString *) smsId isFavourite:(BOOL) isFavourite;

- (NSDictionary *) getSMSContentWithId:(NSString *) smsId;
- (NSArray *) getCategories;
- (NSArray *) getSMSForCategory:(NSString *) categoryId;
- (NSArray *) getFavouriteSMS;
- (NSArray *) getRecentUsedSMS;
@end
