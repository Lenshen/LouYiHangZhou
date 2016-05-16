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
#import "WebViewJSBridge.h"

@interface OrderStatusViewController ()
@property (nonatomic, strong)WebViewJSBridge *bridge;
@property (nonatomic, strong)UIWebView *webView;


@end

@implementation OrderStatusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"%@",self.indexName);
   


    

    
}
-(void)setUpWebview:(NSString *)htmlName CGRectMakeForWebview:(CGRect)webviewFrame
{
 _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64)];

    NSString *mainBundleDirectory = [[NSBundle mainBundle] bundlePath];
   
    NSString *str3 = [NSString stringWithFormat:@"web/orders.html?status=%@",htmlName];
    _bridge = [WebViewJSBridge bridgeForWebView:_webView withSuperDelegate:self];

    NSString *path = [mainBundleDirectory stringByAppendingPathComponent:str3];
    
    NSURLRequest *request1 = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"file://%@",[path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]]]];
    NSLog(@"%@",request1);
    
    [self.webView loadRequest:request1];


    
    [self.view addSubview:self.webView];

    
    
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = NO;
    self.title = @"订单状态";
    [self setUpWebview:self.indexName CGRectMakeForWebview:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64)];
}

-(void)viewWillDisappear:(BOOL)animated

{
    self.navigationController.navigationBarHidden = YES;
    
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
