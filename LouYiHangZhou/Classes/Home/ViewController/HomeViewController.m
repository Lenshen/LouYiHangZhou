//
//  HomeViewController.m
//  LouYiHangZhou
//
//  Created by 远深 on 16/4/8.
//  Copyright © 2016年 Luo Yi TECHNOLOGY. All rights reserved.
//

#import "HomeViewController.h"
#import "UIViewController+StoryboardFrom.h"
#import "SearchViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "WebViewJSBridge.h"
#import "SearhDetailViewController.h"
#define JSBridgeName @"MALLJSBridge"
#define JSBridgeProtocol @"bridge://"


@interface HomeViewController ()<UIWebViewDelegate,WebViewJSBridgeDelegate>
@property (strong, nonatomic) UIWebView *webView;
@property (nonatomic, weak) JSContext *jsContext;
@property (nonatomic, strong) WebViewJSBridge *bridge;


@end

@implementation HomeViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.




    
}
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:YES];
    
  
}
- (IBAction)pushButton:(id)sender {
    SearchViewController  *search = [SearchViewController instanceFromStoryboard];
    search.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:search animated:YES];

    

}




-(void)updateWebview
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        NSString *mainBundleDirectory = [[NSBundle mainBundle] bundlePath];
        
        
        _bridge = [WebViewJSBridge bridgeForWebView:_webView withSuperDelegate:self];
        
        
        
        NSString *htmlStr = [NSString stringWithFormat:@"web/index2.html"];
        NSString *path = [mainBundleDirectory stringByAppendingPathComponent:htmlStr];
        
        
        
        
        NSURLRequest *request1 = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"file://%@",[path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]]]];
        
        [self.webView loadRequest:request1];
        
        NSLog(@"%@",[NSThread currentThread]);
        

    });
   
}
-(void)setUPWebView
{
    _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64)];
    
    [_webView setUserInteractionEnabled:YES];
    _webView.delegate = self;
    _webView.scrollView.bounces = NO;
 
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSString *mainBundleDirectory = [[NSBundle mainBundle] bundlePath];
        
        
        _bridge = [WebViewJSBridge bridgeForWebView:_webView withSuperDelegate:self];
        
        
        
        NSString *htmlStr = [NSString stringWithFormat:@"web/index2.html"];
        NSString *path = [mainBundleDirectory stringByAppendingPathComponent:htmlStr];
        
        NSURLRequest *request1 = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"file://%@",[path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]]]];
        
        [self.webView loadRequest:request1];
        NSLog(@"%@",[NSThread currentThread]);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.view addSubview:_webView];

        });
    });
   
    
    
    
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
  
    NSString *url = [[request URL] absoluteString];
    if ([url rangeOfString:@"id"].location != NSNotFound) {
        NSArray *array = [url componentsSeparatedByString:@"?"];
        
        NSString *good_id = [array[1] substringFromIndex:3];
        
        SearhDetailViewController *detail = [[SearhDetailViewController alloc]init];
        
        detail.indexName = good_id;
        
        [self.navigationController pushViewController:detail animated:YES];
        
        
        
        
        
        
    }else
    {
        NSLog(@"notiaozhuan");
    }
    
    
    
    return YES;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    if (!_webView) {
        [self setUPWebView];

    }else
    {
        [self updateWebview];
    }

  

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    self.webView = nil;

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
