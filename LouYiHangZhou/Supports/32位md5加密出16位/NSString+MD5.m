//
//  NSString+MD5.m
//  LuoYi
//
//  Created by 远深 on 16/4/5.
//  Copyright © 2016年 Luo Yi TECHNOLOGY. All rights reserved.
//

#import "NSString+MD5.h"
#import <CommonCrypto/CommonCrypto.h>

@implementation NSString (MD5)
-(NSString*) md5 {
    const char *cStr = [self UTF8String];

    unsigned char result[16];
    
    
    
    NSNumber *num = [NSNumber numberWithUnsignedLong:strlen(cStr)];
    
    CC_MD5( cStr,[num intValue], result );
    
    

    return [[NSString stringWithFormat:
             
             @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             
             result[0], result[1], result[2], result[3],
             
             result[4], result[5], result[6], result[7],
             
             result[8], result[9], result[10], result[11],
             
             result[12], result[13], result[14], result[15]
             
             ] lowercaseString];
    
}



@end
