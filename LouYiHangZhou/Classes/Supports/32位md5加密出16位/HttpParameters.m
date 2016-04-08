//
//  HttpParameters.m
//  LouYiHangZhou
//
//  Created by 远深 on 16/4/8.
//  Copyright © 2016年 Luo Yi TECHNOLOGY. All rights reserved.
//

#import "HttpParameters.h"
#import "NSString+MD5.h"

@implementation HttpParameters
+(NSDictionary *)app_autorize_parameters
{
    CFUUIDRef puuid = CFUUIDCreate( nil );
    CFStringRef uuidString = CFUUIDCreateString( nil, puuid );
    NSString * result = (NSString *)CFBridgingRelease(CFStringCreateCopy( NULL, uuidString));
    CFRelease(puuid);
    CFRelease(uuidString);
    NSString *device_id = result;
    
    NSString *sign = [NSString stringWithFormat:@"test1123456%@",result];
    NSString *signmd5 = [sign md5];
    DLog(@"%@",signmd5);
    NSDictionary *dic = @{@"code":@"test1",@"ver":@"1.0",@"device_id":device_id,@"sign":signmd5};

    return dic;
}
+(NSDictionary *)app_MobileVerifyCode_sendMobiel:(NSString *)mobile
{
    
    NSDictionary *dic = @{@"access_token":[USER_DEFAULT objectForKey:@"app_autorizd_number"],@"mobile":mobile,@"func_id":@"100"};
    return dic;
}



@end
