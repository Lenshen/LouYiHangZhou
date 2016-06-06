//
//  BYSHttpTool.m
//  LouYiHangZhou
//
//  Created by 远深 on 16/4/8.
//  Copyright © 2016年 Luo Yi TECHNOLOGY. All rights reserved.
//

#import "BYSHttpTool.h"
#import "AFNetworking.h"

@implementation BYSHttpTool


+(void)GET:(NSString *)URLString Parameters:(id)parameters Success:(void (^)(id))success Failure:(void (^)(NSError *))failure
{
    
     dispatch_async(dispatch_get_global_queue(0, 0), ^{
         AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
         mgr.requestSerializer.timeoutInterval = 30;
         mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/css", nil];
         [mgr GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             if (success) {
        dispatch_async(dispatch_get_main_queue(), ^{
             success(responseObject);
        });
                
             }
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             if (failure) {
            dispatch_async(dispatch_get_main_queue(), ^{
                     failure(error);
                 });

             }
         }];
     });
   
}

+(void)POST:(NSString *)URLString Parameters:(id)parameters Success:(void (^)(id))success Failure:(void (^)(NSError *))failure
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
        mgr.requestSerializer.timeoutInterval = 30;
        mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/css",@"text/plain",nil];
        [mgr POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            if (success) {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    success(responseObject);

                });
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (failure) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    failure(error);

                });
            }
            
        }];

    });
   }

@end
