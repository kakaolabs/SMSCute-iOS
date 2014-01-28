//
//  APIEngine+SMS.m
//  TinNhanYeuThuong
//
//  Created by Kien Nguyen on 1/27/14.
//  Copyright (c) 2014 kakaolabs. All rights reserved.
//

#import "APIEngine+SMS.h"

@implementation APIEngine (SMS)

- (void) getListCategories:(FetcherDataBlock) completionBlock
                   onError:(MKNKErrorBlock) errorBlock
{
    [self startOperationWithPath:@"/sms/v1/categories/" withParameters:nil withData:nil httpMethod:@"GET"
        onComplete:^(id object) {
        completionBlock(object);
    } onError:^(NSError *error) {
        errorBlock(error);
    }];
}


- (void) getDetailOfSubCategory:(NSString *) subcategoryId
                     onComplete:(FetcherDataBlock) completionBlock
                        onError:(MKNKErrorBlock) errorBlock
{
    NSString *path = [NSString stringWithFormat:@"/sms/v1/subcategory/%@/", subcategoryId];
    [self startOperationWithPath:path withParameters:nil withData:nil httpMethod:@"GET"
      onComplete:^(id object) {
          completionBlock(object);
    } onError:^(NSError *error) {
        errorBlock(error);
    }];
}

@end
