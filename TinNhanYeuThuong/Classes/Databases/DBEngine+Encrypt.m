//
//  DBEngine+Encrypt.m
//  TinNhanYeuThuong
//
//  Created by Kien Nguyen on 1/30/14.
//  Copyright (c) 2014 kakaolabs. All rights reserved.
//

#import "RNCryptor.h"
#import "RNEncryptor.h"
#import "RNDecryptor.h"
#import "DBEngine+Encrypt.h"

@implementation DBEngine (Encrypt)

- (NSData *) encryptString:(NSString *) input
{
    NSData *data = [input dataUsingEncoding:NSUnicodeStringEncoding];
    NSError *error;
    NSData *output = [RNEncryptor encryptData:data
                                        withSettings:kRNCryptorAES256Settings
                                            password:API_SECRET
                                               error:&error];

    return output;
}

- (NSString *) decryptData:(NSData *) input
{
    NSError *error;
    NSData *decryptedData = [RNDecryptor decryptData:input
                                        withPassword:API_SECRET
                                               error:&error];
    NSString *output = [[NSString alloc] initWithData:decryptedData encoding:NSUnicodeStringEncoding];
    return output;
}

@end
