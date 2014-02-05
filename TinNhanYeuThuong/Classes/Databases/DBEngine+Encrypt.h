//
//  DBEngine+Encrypt.h
//  TinNhanYeuThuong
//
//  Created by Kien Nguyen on 1/30/14.
//  Copyright (c) 2014 kakaolabs. All rights reserved.
//

#import "DBEngine.h"

@interface DBEngine (Encrypt)

- (NSData *) encryptString:(NSString *) input;
- (NSString *) decryptData:(NSData *) input;
@end
