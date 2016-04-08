//
//  HttpParameters.h
//  LouYiHangZhou
//
//  Created by 远深 on 16/4/8.
//  Copyright © 2016年 Luo Yi TECHNOLOGY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpParameters : NSObject
+(NSDictionary *)app_autorize_parameters;
+(NSDictionary *)app_MobileVerifyCode_sendMobiel:(NSString *)mobile;

@end
