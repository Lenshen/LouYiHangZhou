//
//  BYSHttpTool.h
//  LouYiHangZhou
//
//  Created by 远深 on 16/4/8.
//  Copyright © 2016年 Luo Yi TECHNOLOGY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BYSHttpTool : NSObject

//add
//add

+(void)GET:(NSString *)URLString Parameters:(id)parameters Success:(void (^) (id responseObject))success Failure:(void (^) (NSError *error))failure;
+(void)POST:(NSString *)URLString Parameters:(id)parameters Success:(void (^) (id responseObject))success Failure:(void (^) (NSError *error))failure;


@end
