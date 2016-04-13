//
//  TabBarViewController.m
//  WeiboTabBar
//
//  Created by 君子 on 16/1/17.
//  Copyright © 2016年 君子. All rights reserved.
//

#import "TabBarViewController.h"
#import "BYSHttpTool.h"
#import "HttpParameters.h"
#import "HomeViewController.h"
#import "ClassifyViewController.h"
#import "ShoppingCartViewController.h"
#import "ProfileViewController.h"
#import "NavigationViewController.h"
#import "ShoppingCartViewController.h"
#include "UIViewController+StoryboardFrom.h"
#import "WLZ_ShoppingCarController.h"
#include <ifaddrs.h>
#include <arpa/inet.h>


@interface TabBarViewController ()

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //主页
    HomeViewController *home =[HomeViewController instanceFromStoryboard];
    [self addChildViewController:home image:@"首页" selectedImage:@"红色首页" title:@"首页"];
    //消息
     ClassifyViewController *message = [ClassifyViewController instanceFromStoryboard];
    [self addChildViewController:message image:@"分类" selectedImage:@"红色分类" title:@"分类"];
    
    //购物车
    WLZ_ShoppingCarController *shopVC = [[WLZ_ShoppingCarController alloc]init
                                   ];
    [self addChildViewController:shopVC image:@"购物车" selectedImage:@"红色购物车" title:@"购物车"];

    
   
 
    

    [self addChildViewController:[ProfileViewController instanceFromStoryboard] image:@"个人" selectedImage:@"红色个人" title:@"个人"];
    
    
    [BYSHttpTool GET:APP_AUTHOTIZD_API Parameters:[HttpParameters app_autorize_parameters] Success:^(id responseObject) {
        DLog(@"%@",responseObject[@"data"]);
        [USER_DEFAULT setObject:responseObject[@"data"] forKey:@"app_autorizd_number"];
    } Failure:^(NSError *error) {
        DLog(@"%@",error);
    }];
    
    NSString *str = [self getIPAddress];
    NSLog(@"%@",str);
    [USER_DEFAULT setObject:str forKey:@"client_id"];
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
-(void)getAppAutorizer
{
    
}
/**
 *  添加子控制器
 *
 *  @param childViewController 子控制器
 *  @param image               tabBarItem正常状态图片
 *  @param selectedImage       tabBarItem选中状态图片
 *  @param title               标题
 */
- (void)addChildViewController:(UIViewController *)childViewController image:(NSString *)image selectedImage:(NSString *)selectedImage title:(NSString *)title {
    
    //标题
    childViewController.title = title;
//    childViewController.view.backgroundColor = [UIColor whiteColor];
    
    //tabBarItem图片
    childViewController.tabBarItem.image = [UIImage imageNamed:image];
    childViewController.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //tabBarItem字体的设置
    //正常状态
    NSMutableDictionary *normalText = [NSMutableDictionary dictionary];
    normalText[NSForegroundColorAttributeName] = [UIColor colorWithRed:123/255.0 green:123/255.0 blue:123/255.0 alpha:1.0];
    [childViewController.tabBarItem setTitleTextAttributes:normalText forState:UIControlStateNormal];
   
   
    
    //选中状态
    NSMutableDictionary *selectedText = [NSMutableDictionary dictionary];
    selectedText[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [childViewController.tabBarItem setTitleTextAttributes:selectedText forState:UIControlStateSelected];
    
    
//    //导航控制器
    NavigationViewController *navgationVC = [[NavigationViewController alloc]initWithRootViewController:childViewController];
    navgationVC.navigationBarHidden = YES;
    [self addChildViewController:navgationVC];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.1
}

/**
 *  addBtn 的代理方法
 *
 *  @param tabBar tabBar
 */


@end
