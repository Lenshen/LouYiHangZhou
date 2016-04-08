//
//  TabBarViewController.m
//  WeiboTabBar
//
//  Created by 君子 on 16/1/17.
//  Copyright © 2016年 君子. All rights reserved.
//

#import "TabBarViewController.h"
//#import "HomeViewController.h"
//#import "ClassifyViewController.h"
//#import "ShoppingCartViewController.h"
//#import "ProfileViewController.h"
//#import "NavigationViewController.h"
//#import "ShoppingCartViewController.h"
//#import "HomeViewController2.h"
//#include "UIViewController+StoryboardFrom.h"
//#import "SuccessTableViewController.h"


@interface TabBarViewController ()

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //主页
//    HomeViewController *home =[HomeViewController instanceFromStoryboard];
//    [self addChildViewController:home image:@"tabbar_home" selectedImage:@"tabbar_home_selected" title:@"首页"];
//    //消息
//     ClassifyViewController *message = [ClassifyViewController instanceFromStoryboard];
//    [self addChildViewController:message image:@"分类" selectedImage:@"分类2" title:@"分类"];
//    
//    //购物车
////    ShoppingCartViewController *shopVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"ShoppingCartViewController"];
//    HomeViewController2 *shopVC = [HomeViewController2 new];
//    [self addChildViewController:shopVC image:@"购物车" selectedImage:@"添加购物车" title:@"购物车"];
//
//    
//   
// 
//    
//
//    [self addChildViewController:[ProfileViewController instanceFromStoryboard] image:@"tabbar_profile" selectedImage:@"tabbar_profile_selected" title:@"我"];
    

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
//    NavigationViewController *navgationVC = [[NavigationViewController alloc]initWithRootViewController:childViewController];
//    navgationVC.navigationBarHidden = YES;
//    [self addChildViewController:navgationVC];

    
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
