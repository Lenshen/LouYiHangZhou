//
//  AppDelegate.m
//  LouYiHangZhou
//
//  Created by 远深 on 16/4/7.
//  Copyright © 2016年 Luo Yi TECHNOLOGY. All rights reserved.
//

#import "AppDelegate.h"
#import "BYSHttpTool.h"
#import "HttpParameters.h"
#include <ifaddrs.h>
#include <arpa/inet.h>
#import "JPUSHService.h"
#import <AlipaySDK/AlipaySDK.h>
#import "NSString+MD5.h"
#define JPUSH @"074100e7a8356cde541deaea"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
  
    [self getApptokenAndClientIP];

    
    
    //极光推送
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                          UIUserNotificationTypeSound |
                                                          UIUserNotificationTypeAlert)
                                              categories:nil];
    }     //JAppKey : 是你在极光推送申请下来的appKey Jchannel : 可以直接设置默认值即可 Publish channel
    [JPUSHService setupWithOption:launchOptions appKey:JPUSH channel:nil apsForProduction:NO
                ];
    
    [JPUSHService setAlias:@"15961237169" callbackSelector:nil object:nil];

    return YES;
    
}



- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    
    [JPUSHService registerDeviceToken:deviceToken];

}

-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    NSLog(@"%@",userInfo);
    NSString *alert = [[userInfo objectForKey:@"aps"] objectForKey:@"alert"];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"jpush" object:self userInfo:userInfo];
  
    NSLog(@"%@",alert);
    if (application.applicationState == UIApplicationStateActive) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"推送消息"
                                                            message:alert
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
        
        [alertView show];
    }
    
    [application setApplicationIconBadgeNumber:0];
    [JPUSHService handleRemoteNotification:userInfo];
}
-(void)getApptokenAndClientIP
{
    
    
    [BYSHttpTool GET:APP_AUTHOTIZD_API Parameters:[HttpParameters app_Token] Success:^(id responseObject) {
        DLog(@"%@",responseObject);
        
        if (responseObject[@"data"] != nil && ![responseObject[@"data"]  isKindOfClass:[NSNull class]]){
            
             [USER_DEFAULT setObject:responseObject[@"data"] forKey:@"app_autorizd_number"];
            
        }
   
    } Failure:^(NSError *error) {
        DLog(@"%@",error);
    }];
    NSString *str = [self getIPAddress];
    NSLog(@"%@",str);
    [USER_DEFAULT setObject:str forKey:@"client_ip"];
    
    
}


- (NSString *)getIPAddress
{
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while (temp_addr != NULL) {
            if( temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if ([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            
            temp_addr = temp_addr->ifa_next;
        }
    }
    
    // Free memory
    freeifaddrs(interfaces);
    
    return address;
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
        }];
    }
    return YES;
}

// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
        }];
    }
    return YES;
}

@end
