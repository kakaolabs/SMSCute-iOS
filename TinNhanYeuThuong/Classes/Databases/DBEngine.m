//
//  DBEngine.m
//  TinNhanYeuThuong
//
//  Created by Kien Nguyen on 1/29/14.
//  Copyright (c) 2014 kakaolabs. All rights reserved.
//

#import "DBEngine.h"

@implementation DBEngine

+ (id) sharedEngine
{
    static DBEngine *sharedEngine = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDir = [docPaths objectAtIndex:0];
        NSString *dbPath = [documentsDir stringByAppendingPathComponent:@"UserDatabase.sqlite"];
        
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

- (void) insertCategoryWithDict:(NSDictionary *) dict parentId:(NSString *)parentId
{
    [self executeUpdate:@"INSERT INTO category VALUES(?, ?, ?, ?, ?)", dict[@"id"], dict[@"name"], parentId, dict[@"type"], dict[@"index"]];
}

- (void) insertSMSWithDict:(NSDictionary *) dict categoryId:(NSString *)categoryId
{
    [self executeUpdate:@"INSERT INTO smscontent VALUES(?, ?, ?, ?, ?, ?)", dict[@"id"], categoryId, dict[@"content"], dict[@"index"], @"0", @"0"];
}

- (NSArray *) getCategories
{
    [self open];
    
    NSMutableArray *categories = [[NSMutableArray alloc] init];
    FMResultSet *s = [self executeQuery:@"SELECT * FROM category WHERE parentId IS NULL ORDER BY `index` DESC"];
    while ([s next]) {
        NSLog(@"%@, %@, %@, %@, %@",
              [s stringForColumn:@"id"],
              [s stringForColumn:@"index"],
              [s stringForColumn:@"name"],
              [s stringForColumn:@"type"],
              [s stringForColumn:@"parentId"]);        
        NSMutableDictionary *item = [[NSMutableDictionary alloc] init];
        item[@"id"] = [s stringForColumn:@"id"];
        item[@"index"] = [s stringForColumn:@"index"];
        item[@"name"] = [s stringForColumn:@"name"];
        item[@"type"] = [s stringForColumn:@"type"];
        [categories addObject:item];
    }
    
    [self close];
    
    return categories;
}

- (NSArray *) getSMSForCategory:(NSString *) categoryId
{
    [self open];
    
    NSMutableArray *smscontents = [[NSMutableArray alloc] init];
    FMResultSet *s = [self executeQuery:@"SELECT * FROM smscontent WHERE categoryId = ? ORDER BY `index`, content", categoryId];
    while ([s next]) {
        NSMutableDictionary *item = [[NSMutableDictionary alloc] init];
        item[@"id"] = [s stringForColumn:@"id"];
        item[@"content"] = [s stringForColumn:@"content"];
        [smscontents addObject:item];
    }
    
    [self close];
    
    return smscontents;
}

@end
