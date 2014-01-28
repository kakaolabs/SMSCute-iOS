//
//  APIEngine.h
//  TinNhanYeuThuong
//
//  Created by Kien Nguyen on 1/26/14.
//  Copyright (c) 2014 kakaolabs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MKNetworkKit.h"


typedef void (^FetcherDataBlock)(id object);
typedef void (^BOOLBlock)(BOOL b);


@interface APIEngine : MKNetworkEngine

+ (APIEngine *) sharedEngine;
- (void) startOperationWithPath:(NSString *) path
                 withParameters:(NSMutableDictionary *)params
                       withData:(NSMutableDictionary *)data
                     httpMethod:(NSString *)method
                     onComplete:(FetcherDataBlock) completionBlock
                        onError:(MKNKErrorBlock) errorBlock;
@end
