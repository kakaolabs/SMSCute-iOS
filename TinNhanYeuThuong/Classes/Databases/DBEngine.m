//
//  DBEngine.m
//  TinNhanYeuThuong
//
//  Created by Kien Nguyen on 1/29/14.
//  Copyright (c) 2014 kakaolabs. All rights reserved.
//

#import "DBEngine+Encrypt.h"
#import "DBEngine.h"

@implementation DBEngine

# pragma mark - Create
+ (DBEngine *) sharedEngine
{
    static DBEngine *sharedEngine = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDir = [docPaths objectAtIndex:0];
        NSString *dbPath = [documentsDir stringByAppendingPathComponent:@"UserDatabase.sqlite"];
        NSLog(@"%@", dbPath);
        sharedEngine = [[DBEngine alloc ]initWithPath:dbPath];
    });
    return sharedEngine;
}

- (id) initWithPath:(NSString *)inPath
{
    self = [super initWithPath:inPath];
    if (self) {}
    return self;
}

- (void) createTables
{
    [self executeUpdate:@"CREATE TABLE IF NOT EXISTS category (id INTEGER  PRIMARY KEY, name TEXT, parentId INTEGER DEFAULT NULL, type INTEGER DEFAULT 0, `index` INTEGER DEFAULT 0)"];
    [self executeUpdate:@"CREATE TABLE IF NOT EXISTS smscontent (id INTEGER  PRIMARY KEY, categoryId INTEGER DEFAULT NULL, content TEXT, `index` INTEGER DEFAULT 0, isRead INTEGER DEFAULT 0, isFavourite INTEGER DEFAULT 0)"];
}

# pragma mark - Create/Update
- (void) insertCategoryWithDict:(NSDictionary *) dict parentId:(NSString *)parentId
{
    FMResultSet *s = [self executeQuery:@"SELECT COUNT(*) FROM category WHERE id = ?", dict[@"id"]];
    [s next];
    int result = [s intForColumnIndex:0];
    if (result == 0) {
        [self executeUpdate:@"INSERT INTO category VALUES(?, ?, ?, ?, ?)",
         dict[@"id"], dict[@"name"], parentId, dict[@"type"], dict[@"index"]];
    } else {
        [self executeUpdate:@"UPDATE category SET name = ?, parentId = ?, type = ?, `index` = ? WHERE id = ?",
         dict[@"name"], parentId, dict[@"type"], dict[@"index"], dict[@"id"]];
    }
}

- (void) insertSMSWithDict:(NSDictionary *) dict categoryId:(NSString *)categoryId
{
    NSData *encryptContent = [self encryptString:dict[@"content"]];
    
    FMResultSet *s = [self executeQuery:@"SELECT COUNT(*) FROM smscontent WHERE id = ?", dict[@"id"]];
    [s next];
    int result = [s intForColumnIndex:0];
    if (result == 0) {
        [self executeUpdate:@"INSERT INTO smscontent VALUES(?, ?, ?, ?, ?, ?)",
         dict[@"id"], categoryId, encryptContent, dict[@"index"], @"0", @"0"];
    } else {
        [self executeUpdate:@"UPDATE smscontent SET categoryId = ?, content = ?, `index` = ? WHERE id = ?",
         categoryId, encryptContent, dict[@"index"], dict[@"id"]];
    }
}


- (void) markSMSContentIsRead:(NSString *) smsId isRead:(BOOL) isRead
{
    NSString *isReadStr = isRead ? @"1" : @"0";
    [self open];
    [self executeUpdate:@"UPDATE smscontent SET isRead = ? WHERE id = ?", isReadStr, smsId];
    [self close];
}


- (void) markSMSContentIsFavourite:(NSString *) smsId isFavourite:(BOOL) isFavourite
{
    NSString *isLike = isFavourite ? @"1" : @"0";
    [self open];
    [self executeUpdate:@"UPDATE smscontent SET isFavourite = ? WHERE id = ?", isLike, smsId];
    [self close];
}


# pragma mark - Read
- (NSArray *) getCategories
{
    [self open];
    
    NSMutableArray *categories = [[NSMutableArray alloc] init];
    NSMutableArray *subCategories = [[NSMutableArray alloc] init];
    NSMutableDictionary *categoryDict = [[NSMutableDictionary alloc] init];
    
    FMResultSet *s = [self executeQuery:@"SELECT * FROM category ORDER BY `index` ASC, name ASC"];
    
    while ([s next]) {
        NSMutableDictionary *item = [[NSMutableDictionary alloc] init];
        item[@"id"] = [s stringForColumn:@"id"];
        item[@"index"] = [s stringForColumn:@"index"];
        item[@"name"] = [s stringForColumn:@"name"];
        item[@"type"] = [s stringForColumn:@"type"];
        item[@"data"] = [[NSMutableArray alloc] init];
        NSString *parentId = [s stringForColumn:@"parentId"];
        if (parentId) {
            item[@"parentId"] = parentId;
            [subCategories addObject:item];
        } else {
            [categories addObject:item];
            categoryDict[item[@"id"]] = item;
        }
    }
    
    for (NSDictionary *item in subCategories) {
        NSString *parentId = item[@"parentId"];
        NSDictionary *parentItem = categoryDict[parentId];
        [parentItem[@"data"] addObject:item];
    }
        
    [self close];
    
    return categories;
}

- (NSArray *) getSMSContentWithResultSet:(FMResultSet *) s
{
    NSMutableArray *smscontents = [[NSMutableArray alloc] init];
    while ([s next]) {
        NSMutableDictionary *item = [[NSMutableDictionary alloc] init];
        item[@"id"] = [s stringForColumn:@"id"];
        NSData *content = [s dataForColumn:@"content"];
        item[@"content"] = [self decryptData:content];
        item[@"isRead"] = [s stringForColumn:@"isRead"];
        item[@"isFavourite"] = [s stringForColumn:@"isFavourite"];
        [smscontents addObject:item];
    }
    
    [smscontents sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSDictionary *item1 = (NSDictionary *) obj1;
        NSDictionary *item2 = (NSDictionary *) obj2;
        return [item1[@"content"] compare:item2[@"content"]];
    }];
    
    return smscontents;
}

- (NSArray *) getSMSForCategory:(NSString *) categoryId
{
    [self open];
    FMResultSet *s = [self executeQuery:@"SELECT * FROM smscontent WHERE categoryId = ? ORDER BY `index`, content", categoryId];
    NSArray *smscontents = [self getSMSContentWithResultSet:s];
    [self close];
    return smscontents;
}

- (NSArray *) getFavouriteSMS
{
    [self open];
    
    FMResultSet *s = [self executeQuery:@"SELECT * FROM smscontent WHERE isFavourite = 1 ORDER BY `index`, content"];
    NSArray *smscontents = [self getSMSContentWithResultSet:s];

    [self close];
    
    return smscontents;
}

- (NSArray *) getRecentUsedSMS;
{
    [self open];
    
    FMResultSet *s = [self executeQuery:@"SELECT * FROM smscontent WHERE isRead = 1 ORDER BY `index`, content"];
    NSArray *smscontents = [self getSMSContentWithResultSet:s];

    [self close];
    
    return smscontents;
}

- (NSDictionary *) getSMSContentWithId:(NSString *) smsId
{
    [self open];
    
    FMResultSet *s = [self executeQuery:@"SELECT * FROM smscontent WHERE id = ?", smsId];
    NSArray *smscontents = [self getSMSContentWithResultSet:s];
    [self close];
    
    return smscontents[0];
}
@end
