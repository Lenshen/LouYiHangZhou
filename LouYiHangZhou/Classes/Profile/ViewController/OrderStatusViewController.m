//
//  OrderStatusViewController.m
//  LouYiHangZhou
//
//  Created by 远深 on 16/4/20.
//  Copyright © 2016年 Luo Yi TECHNOLOGY. All rights reserved.
//

#import "OrderStatusViewController.h"
#import "ProfileViewController.h"
#import "UIViewController+StoryboardFrom.h"
#import "ChangePassWordViewController.h"

@interface OrderStatusViewController ()

@end

@implementation OrderStatusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"%@",self.indexName);
    [self setUpWebview:self.indexName CGRectMakeForWebview:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64)];
    
}
-(void)setUpWebview:(NSString *)htmlName CGRectMakeForWebview:(CGRect)webviewFrame
{
    UIWebView *webview = [[UIWebView alloc]initWithFrame:webviewFrame];
    //    NSString *str = [[NSBundle mainBundle] bundlePath];
    NSString *mainBundleDirectory = [[NSBundle mainBundle] bundlePath];
    NSString *path1 = [mainBundleDirectory  stringByAppendingPathComponent:@"web"];
    NSURL *baseURL = [NSURL fileURLWithPath:path1];
    
    //    NSString *path = [[NSBundle mainBundle] pathForResource:htmlName ofType:@"html"];
//    NSString *str = [NSString stringWithFormat:@"web/orders.html?status=%@",htmlName];
    NSString *str2 = [NSString stringWithFormat:@"web/orders.html"];
    NSString *path = [mainBundleDirectory stringByAppendingPathComponent:str2];
    NSLog(@"%@ %@",path1,path);
    
    NSString *html = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    [webview loadHTMLString:html baseURL:baseURL];
    [self.view addSubview:webview];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = NO;
    self.title = @"订单"; 
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
