//
//  APIEngine.m
//  TinNhanYeuThuong
//
//  Created by Kien Nguyen on 1/26/14.
//  Copyright (c) 2014 kakaolabs. All rights reserved.
//

#import "APIEngine.h"
#import "MKNetworkKit.h"
#import "JSONKit.h"
#import "NSString+sha1.h"

@implementation APIEngine

+ (APIEngine *) sharedEngine
{
    static APIEngine *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *userAgent;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            userAgent = [NSString stringWithFormat:@"iOS-%@/%@.%@", APP_NAME, APP_VERSION, APP_BUILD_INDEX];
        NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:@"",@"Accept-Encoding", userAgent, @"User-Agent", nil];
        sharedManager = [[APIEngine alloc] initWithHostName:nil customHeaderFields:dict];
    });
    return sharedManager;
}

- (NSString *) getDomain
{
    return @"kakaolabs.herokuapp.com";
}

- (NSString *) getAPIKey
{
    return @"70c0d458-600d-4ae9-a0a7-9d8d53455b43";
}

- (NSString *) getAPISecret
{
    return @"0f2d5df8-95fa-48f0-b875-4b1fcea1a158";
}

- (NSString *) calculateSignatureWithPath:(NSString *) path withParams:(NSDictionary *) params withData:(NSDictionary *) data
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:params];
    for (NSString *key in data) {
        dict[key] = data[key];
    }
    
    NSArray *sortedKeys = [[dict allKeys] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
    NSString *urlString = [NSString stringWithFormat:@"%@", path];
    for (NSString *key in sortedKeys) {
        urlString = [NSString stringWithFormat:@"%@%@=%@", urlString, key, dict[key]];
    }
    urlString = [NSString stringWithFormat:@"%@%@", urlString, [self getAPISecret]];
    NSString *signature = [urlString sha1];
    return signature;
}

- (void) objectFromJSonString:(NSString*) jsonString
          withCompletionBlock:(void (^)(id jsonObject)) jsonDecompressionHandler
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        id jsonObject = [jsonString objectFromJSONString];
        if (!jsonObject) {
            jsonDecompressionHandler(nil);
            return;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            jsonDecompressionHandler(jsonObject);
        });
    });
}

- (NSString *) getURLForPath:(NSString *) path withParameters:(NSMutableDictionary *) params
{
    NSString *url = [NSString stringWithFormat:@"http://%@%@?", [self getDomain], path];
    
    for (NSString *key in params) {
        NSString *value = [params objectForKey:key];
        if ([value isKindOfClass:[NSString class]]) {
            value = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(                                                                                                                    NULL,                                                                                                                    (__bridge CFStringRef) value,                                                                                                                    NULL, CFSTR("!*'();:@&=+$,/?%#[]"), kCFStringEncodingUTF8));
            url = [NSString stringWithFormat:@"%@&%@=%@", url, key, value];
        }
        else if ([value isKindOfClass:[NSNumber class]]) {
            url = [NSString stringWithFormat:@"%@&%@=%d", url, key, [value intValue]];
        }
    }
    return url;
}

- (void) startOperationWithPath:(NSString *) path
                 withParameters:(NSMutableDictionary *)params
                       withData:(NSMutableDictionary *)data
                     httpMethod:(NSString *)method
                     onComplete:(FetcherDataBlock) completionBlock
                        onError:(MKNKErrorBlock) errorBlock
{
    if (!params)
        params = [[NSMutableDictionary alloc] init];
    
    NSString *epochTime = [NSString stringWithFormat:@"%d", (int)([[NSDate date] timeIntervalSince1970])];
    params[@"time"] = epochTime;
    params[@"api_key"] = [self getAPIKey];
    
    NSString *signature = [self calculateSignatureWithPath:path withParams:params withData:data];
    params[@"api_sig"] = signature;
    
    float time = CACurrentMediaTime();
    // Manimpulate url info
    NSString *url = [self getURLForPath:path withParameters:params];

    // Load api from server
    MKNetworkOperation *op = [self operationWithURLString:url
                                                   params:data
                                               httpMethod:method];
    NSString *curlString = [op curlCommandLineString];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        NSLog(@"%@\nTime: %f", curlString, CACurrentMediaTime() - time);
        NSString *responseString = [completedOperation responseString];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"null" withString:@"\"\""];
        [self objectFromJSonString:responseString withCompletionBlock:^(id jsonObject) {
            completionBlock(jsonObject);
        }];
        
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        NSLog(@"%@\nTime: %f", curlString, CACurrentMediaTime() - time);
        errorBlock(error);
    }];
    
    [self enqueueOperation:op];
}

@end
