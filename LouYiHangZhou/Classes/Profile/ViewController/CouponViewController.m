//
//  CouponViewController.m
//  LouYiHangZhou
//
//  Created by 远深 on 16/4/12.
//  Copyright © 2016年 Luo Yi TECHNOLOGY. All rights reserved.
//

#import "CouponViewController.h"
#import "WebViewJSBridge.h"

@interface CouponViewController ()<WebViewJSBridgeDelegate,UIWebViewDelegate>
@property (nonatomic ,strong)WebViewJSBridge *bridge;
@property (nonatomic ,strong)UIWebView *webview;
@end

@implementation CouponViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"优惠券";
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    [self setUpWebview];
   
    
}

- (void)setUpWebview;
{
    
    _webview = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    _webview.delegate = self;
    
    
    
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    dispatch_async(queue, ^{
        

        NSString *mainbounld = [[NSBundle mainBundle]bundlePath];
        NSString *pathstr = @"/web/coupon.html";
        NSString *path = [mainbounld stringByAppendingString:pathstr];
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"file://%@",[path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]]];
        NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
        [_webview loadRequest:request];
        
        dispatch_queue_t mainqueue = dispatch_get_main_queue();
        dispatch_async(mainqueue, ^{
            [self.view addSubview:_webview];
        });
        
    });
    

}
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
-(void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
