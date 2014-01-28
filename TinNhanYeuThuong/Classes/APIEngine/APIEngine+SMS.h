//
//  APIEngine+SMS.h
//  TinNhanYeuThuong
//
//  Created by Kien Nguyen on 1/27/14.
//  Copyright (c) 2014 kakaolabs. All rights reserved.
//

#import "APIEngine.h"

@interface APIEngine (SMS)

- (void) getListCategories:(FetcherDataBlock) completionBlock
                   onError:(MKNKErrorBlock) errorBlock;
- (void) getDetailOfSubCategory:(NSString *) subcategoryId
                     onComplete:(FetcherDataBlock) completionBlock
                        onError:(MKNKErrorBlock) errorBlock;

@end
