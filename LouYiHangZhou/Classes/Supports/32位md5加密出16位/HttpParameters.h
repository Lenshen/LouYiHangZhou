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
+(NSDictionary *)app_MobileVerifyCode_sendMobiel:(NSString *)mobile;
+(NSDictionary *)search_goods:(NSString *)keyword page_index:(NSString *)page_index page_size:(NSString *)page_size;
+(NSDictionary *)exitLogon:(NSString *)userToken;

@end
