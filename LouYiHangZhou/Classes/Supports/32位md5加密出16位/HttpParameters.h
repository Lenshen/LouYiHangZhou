//
//  HttpParameters.h
//  LouYiHangZhou
//
//  Created by 远深 on 16/4/8.
//  Copyright © 2016年 Luo Yi TECHNOLOGY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpParameters : NSObject

+(NSDictionary *)app_Token;

+(NSDictionary *)app_get_userImformation:(NSString *)userToken;

+(NSDictionary *)user_autoSendMobiel:(NSString *)mobile password:(NSString *)password;

//+(NSDictionary *)app_MobileVerifyCode_sendMobiel:(NSString *)mobile;

+(NSDictionary *)search_goods:(NSString *)keyword page_index:(NSString *)page_index page_size:(NSString *)page_size;

+(NSDictionary *)exitLogon:(NSString *)userToken;

+(NSDictionary *)add_address:(NSString *)userToken country:(NSString *)country province:(NSString *)province city:(NSString *)city area:(NSString *)area address:(NSString *)address zip:(NSString *)zip full_name:(NSString *)full_name tel:(NSString *)tel mobile:(NSString *)mobile is_default:(NSString *)ture;

+(NSDictionary *)update_address:(NSString *)userToken country:(NSString *)country province:(NSString *)province city:(NSString *)city area:(NSString *)area address:(NSString *)address zip:(NSString *)zip full_name:(NSString *)full_name tel:(NSString *)tel mobile:(NSString *)mobile is_default:(NSString *)trueStr address_id:(NSString *)address_id;

+(NSDictionary *)delete_address:(NSString *)userToken address_id:(NSString *)address_id;

+(NSDictionary *)uploadAvatar:(NSString *)base64;

+(NSDictionary *)uploadImformation:(NSString *)dataString sexStr:(NSString *)sexStr;

+(NSDictionary *)change_password:(NSString *)userToken newpassword:(NSString *)newpassword oldpassword:(NSString *)oldpassword;

+(NSDictionary *)find_password:(NSString *)userToken newpassword:(NSString *)newpassword code:(NSString *)code mobile:(NSString *)mobile;
@end
