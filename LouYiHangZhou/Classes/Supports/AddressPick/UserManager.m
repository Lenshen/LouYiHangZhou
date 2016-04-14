//
//  UserManager.m
//  LouYiHangZhou
//
//  Created by 远深 on 16/4/14.
//  Copyright © 2016年 Luo Yi TECHNOLOGY. All rights reserved.
//

#import "UserManager.h"

@implementation UserManager
+(instancetype)shareManager
{
    static UserManager *user = nil;
    static dispatch_once_t token;
    dispatch_once(&token,^{
        user = [[UserManager alloc]init];
    });
    return user;
}

@end
