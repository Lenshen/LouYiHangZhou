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
#pragma mark 程序令牌
+(NSDictionary *)app_Token
{
    CFUUIDRef puuid = CFUUIDCreate( nil );
    CFStringRef uuidString = CFUUIDCreateString( nil, puuid );
    NSString * result = (NSString *)CFBridgingRelease(CFStringCreateCopy( NULL, uuidString));
    CFRelease(puuid);
    CFRelease(uuidString);
    NSString *device_id = result;
    NSString *code = @"iosapp";
    NSString *accesskey = @"123456";
    NSString *sign = [NSString stringWithFormat:@"%@%@%@",code,accesskey,result];
    NSString *signmd5 = [sign md5];
    DLog(@"%@",signmd5);
    NSDictionary *dic = @{@"code":code,@"ver":@"1.0.0",@"device_id":device_id,@"sign":signmd5};

    return dic;
}

+(NSDictionary *)user_autoSendMobiel:(NSString *)mobile password:(NSString *)password
{
    
    NSDictionary *dic = @{@"access_token":[USER_DEFAULT objectForKey:@"app_autorizd_number"],@"login_name":mobile,@"user_type":@"0",@"password":password,@"client_ip":[USER_DEFAULT objectForKey:@"client_ip"]};

    return dic;
}
+(NSDictionary *)app_get_userImformation:(NSString *)userToken
{
    NSDictionary *dic = @{@"access_token":[USER_DEFAULT objectForKey:@"user_token"]};
    return dic;
    
}
+(NSDictionary *)app_user_register:(NSString *)mobile code:(NSString *)code
                          password:(NSString *)password ;
{
    NSDictionary *dic =  @{@"access_token":[USER_DEFAULT objectForKey:@"app_autorizd_number"],@"mobile":mobile,@"code":code,@"password":password};
    return dic;
}
+(NSDictionary *)app_change_user:(NSString *)avatar sex:(NSString *)sex birth:(NSString *)birth
{
    NSDictionary *dic =  @{@"access_token":[USER_DEFAULT objectForKey:@"app_autorizd_number"],@"avatar":avatar,@"sex":sex};
    return dic;

}
+(NSDictionary *)exitLogon:(NSString *)userToken
{
    NSDictionary *dic =  @{@"access_token":[USER_DEFAULT objectForKey:@"user_token"]};
    return dic;
}
+(NSDictionary *)change_password:(NSString *)userToken newpassword:(NSString *)newpassword oldpassword:(NSString *)oldpassword
{
    NSDictionary *dic =  @{@"access_token":[USER_DEFAULT objectForKey:@"user_token"],@"newpassword":newpassword,@"oldpassword":oldpassword};
    return dic;
}
+(NSDictionary *)find_password:(NSString *)userToken newpassword:(NSString *)newpassword code:(NSString *)code mobile:(NSString *)mobile
{
    NSDictionary *dic =  @{@"access_token":[USER_DEFAULT objectForKey:@"app_autorizd_number"],@"newpassword":newpassword,@"code":code,@"mobile":mobile};
    return dic;
}
+(NSDictionary *)remove_favorite:(NSString *)userToken goods_id:(NSString *)goods_id
{
    NSDictionary *dic =  @{@"access_token":userToken,@"goods_id":goods_id};
    return dic;
}
+(NSDictionary *)get_favorite:(NSString *)userToken
{
    NSDictionary *dic =  @{@"access_token":userToken};
    return dic;
}
+(NSDictionary *)add_address:(NSString *)userToken country:(NSString *)country province:(NSString *)province city:(NSString *)city area:(NSString *)area address:(NSString *)address zip:(NSString *)zip full_name:(NSString *)full_name tel:(NSString *)tel mobile:(NSString *)mobile is_default:(NSString *)ture
{
    NSDictionary *dic =  @{@"access_token":[USER_DEFAULT objectForKey:@"user_token"],@"country":@"中国",@"province":province,@"city":city,@"area":area,@"address":address,@"zip":@"100010",@"full_name":full_name,@"tel":mobile,@"mobile":mobile,@"is_default":@"true"};
    return dic;
}
+(NSDictionary *)update_address:(NSString *)userToken country:(NSString *)country province:(NSString *)province city:(NSString *)city area:(NSString *)area address:(NSString *)address zip:(NSString *)zip full_name:(NSString *)full_name tel:(NSString *)tel mobile:(NSString *)mobile is_default:(NSString *)trueStr address_id:(NSString *)address_id;
{
    NSDictionary *dic =  @{@"access_token":[USER_DEFAULT objectForKey:@"user_token"],@"country":@"中国",@"province":province,@"city":city,@"area":area,@"address":address,@"zip":@"100010",@"full_name":full_name,@"tel":mobile,@"mobile":mobile,@"is_default":trueStr,@"address_id":address_id};
    return dic;
}
+(NSDictionary *)delete_address:(NSString *)userToken address_id:(NSString *)address_id;
{
    NSDictionary *dic =  @{@"access_token":[USER_DEFAULT objectForKey:@"user_token"],@"address_id":address_id};
    return dic;
}
+(NSDictionary *)get_user_address:(NSString *)userToken
{
    NSDictionary *dic =  @{@"access_token":userToken};
    return dic;
}
+(NSDictionary *)get_one_address:(NSString *)userToken address_id:(NSString   *)address_id
{
    NSDictionary *dic =  @{@"access_token":userToken,@"address_id":address_id};
    return dic;
}
+(NSDictionary *)search_goods:(NSString *)keyword page_index:(NSString *)page_index page_size:(NSString *)page_size;
{
    NSDictionary *dic =  @{@"access_token":[USER_DEFAULT objectForKey:@"app_autorizd_number"],@"page_index":page_index,@"page_size":page_size,@"keyword":keyword};
    return dic;
}
+(NSDictionary *)uploadAvatar:(NSString *)base64
{
    NSDictionary *dic =  @{@"access_token":[USER_DEFAULT objectForKey:@"user_token"],@"avatar":base64};
    return dic;

}
+(NSDictionary *)uploadImformation:(NSString *)dataString sexStr:(NSString *)sexStr
{
    NSDictionary *dic =  @{@"access_token":[USER_DEFAULT objectForKey:@"user_token"],@"birth":dataString,@"sex":sexStr};
    return dic;
    
}

@end
