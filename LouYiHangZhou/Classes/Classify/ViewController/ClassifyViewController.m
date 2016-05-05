//
//  ClassifyViewController.m
//  LouYiHangZhou
//
//  Created by 远深 on 16/4/8.
//  Copyright © 2016年 Luo Yi TECHNOLOGY. All rights reserved.
//

#import "ClassifyViewController.h"
#import "WebViewJSBridge.h"
#define JSBridgeName @"MallJSBridge"
#define JSBridgeProtocol @"bridge://"
@interface ClassifyViewController ()<UIWebViewDelegate>
@property (nonatomic, strong)UIWebView *webView;
@property (nonatomic, strong)WebViewJSBridge *bridge;

@end

@implementation ClassifyViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUPWebView];
    NSString *str = [USER_DEFAULT objectForKey:@"user_token"];
    NSLog(@"%@",str);
    


    
}




-(void)setUPWebView
{
    _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64)];
    
    [_webView setUserInteractionEnabled:YES];
    _webView.delegate = self;

    NSString *mainBundleDirectory = [[NSBundle mainBundle] bundlePath];

    
    NSString *htmlStr = [NSString stringWithFormat:@"web/classify.html?typeid=117"];
    NSString *path = [mainBundleDirectory stringByAppendingPathComponent:htmlStr];


 
    
    _bridge = [WebViewJSBridge bridgeForWebView:_webView withSuperDelegate:self];
//    NSString *path1 = [mainBundleDirectory  stringByAppendingPathComponent:@"web"];
//    NSURL *baseURL = [NSURL fileURLWithPath:path1];
//    [_webView loadHTMLString:html baseURL:baseURL];
//    NSLog(@"%@ ",path);
//    NSString *html = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
//    NSLog(@"%@",html);
    NSURLRequest *request1 = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"file://%@",[path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]]]];
    NSLog(@"%@",request1);
    
    [self.webView loadRequest:request1];
    [self.view addSubview:_webView];
}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    NSString *url = [[request URL] absoluteString];
  

    
    NSLog(@"%@",url);

    return YES;
}
//-(void)webViewDidFinishLoad:(UIWebView *)webView
//{
//    _webView stringByEvaluatingJavaScriptFromString:<#(nonnull NSString *)#>
//}
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
