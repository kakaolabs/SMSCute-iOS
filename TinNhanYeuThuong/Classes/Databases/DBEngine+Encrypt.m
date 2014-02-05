//
//  DBEngine+Encrypt.m
//  TinNhanYeuThuong
//
//  Created by Kien Nguyen on 1/30/14.
//  Copyright (c) 2014 kakaolabs. All rights reserved.
//

#import "FBEncryptorAES.h"
#import "DBEngine+Encrypt.h"

@implementation DBEngine (Encrypt)

- (NSString *) encryptString:(NSString *) input
{
    return [FBEncryptorAES encryptBase64String:input keyString:API_SECRET separateLines:NO];
}

- (NSString *) decryptString:(NSString *) input
{
    return [FBEncryptorAES decryptBase64String:input keyString:API_SECRET];
}

@end
