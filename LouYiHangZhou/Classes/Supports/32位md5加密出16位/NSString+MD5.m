//
//  NSString+MD5.m
//  LuoYi
//
//  Created by 远深 on 16/4/5.
//  Copyright © 2016年 Luo Yi TECHNOLOGY. All rights reserved.
//
#define STOREAPPID @"1080182980"

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


-(BOOL) isValidateMobile:(NSString *)mobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}


-(void)alert:(NSString *)message viewcontroller:(UIViewController *)viewcontroller;
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:message message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:action];
    [viewcontroller presentViewController:alert animated:YES completion:nil];
}



-(void)alertAndViewcontroller:(UIViewController *)viewcontroller;
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:self message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"立即前往" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://itunes.apple.com/us/app/id%@?ls=1&mt=8", STOREAPPID]];
        [[UIApplication sharedApplication] openURL:url];

    } ];
    
    [alert addAction:action];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:action1];
    
    
    [viewcontroller presentViewController:alert animated:YES completion:nil];
}


@end
