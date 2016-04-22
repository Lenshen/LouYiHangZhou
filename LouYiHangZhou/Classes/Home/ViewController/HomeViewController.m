//
//  HomeViewController.m
//  LouYiHangZhou
//
//  Created by 远深 on 16/4/8.
//  Copyright © 2016年 Luo Yi TECHNOLOGY. All rights reserved.
//

#import "HomeViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#define JSBridgeName @"MALLJSBridge"
#define JSBridgeProtocol @"bridge://"


@interface HomeViewController ()<UIWebViewDelegate,WebViewJSBridgeDelegate>
@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic, weak) JSContext *jsContext;


@end

@implementation HomeViewController


- (void)initBridge:(UIWebView *)webView withSuperDelegate:(id)superDelegate
{
    _superDelegate = superDelegate;
    _webView = webView;
    _webView.delegate = self;

}

- (void)converters:(NSString *)type name:(NSString *)name args:(NSDictionary *)args callback:(NSString *)callback
{
    if ([type isEqualToString:@"function"]) {
        [self executeSelector:name args:args callback:callback];
        
    }
    [_superDelegate converters:type name:name args:args callback:callback];
}

// 执行OC函数
- (void)executeSelector:(NSString *)name args:(NSDictionary *)args callback:(NSString *)callback
{
    [_superDelegate executeSelector:name args:args callback:callback];
}

// 执行Javascript回调函数
- (void)executeCallback:(NSString *)callback withArgs:(NSArray *)args
{
    [self executeScriptFunction:callback withArgs:args];
}

// 注入Javascript
- (void)executeScript:(NSString *)script
{
    [_webView stringByEvaluatingJavaScriptFromString:script];
}


#pragma mark - UIWebViewDelegate

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    if (webView != _webView) {
        return;
    }
    BOOL bridgeIsNotEval = ![[webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"typeof window.%@ == 'object'", JSBridgeName]] isEqualToString:@"true"];
    if (bridgeIsNotEval) {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"WebViewJSBridge" ofType:@"js"];
        //        LOG(@"filePath: %@", filePath);
        NSString *fileContent = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
        NSString *JSScript = [NSString stringWithFormat:fileContent, JSBridgeName, JSBridgeProtocol];
             NSLog(@"JSScript: %@",  fileContent);
        [webView stringByEvaluatingJavaScriptFromString:JSScript];
    }
    
    // ----------------------------- responds super delegate ----------------------------- //
    __strong typeof(_superDelegate) strongDelegate = _superDelegate;
    if (strongDelegate && [strongDelegate respondsToSelector:@selector(webViewDidFinishLoad:)]) {
        [strongDelegate webViewDidFinishLoad:webView];
    }
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if (webView != _webView) {
        return YES;
    }
    __strong typeof(_superDelegate) strongDelegate = _superDelegate;
    
    NSString *url = [[request URL] absoluteString];
    if ([url hasPrefix:JSBridgeProtocol]) {
        int protocolLength = [JSBridgeProtocol length];
        NSString *jsonString = [url substringFromIndex:protocolLength];
        if (![jsonString isEqualToString:@""]) {
            NSString *jsonDecodeString = [self decodeURIComponent:jsonString];
            NSData *jsonData = [jsonDecodeString dataUsingEncoding:NSUTF8StringEncoding];
            
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
            NSDictionary *args = [json objectForKey:@"args"];
            [self converters:[json objectForKey:@"type"] name:[json objectForKey:@"name"] args:args callback:[json objectForKey:@"callback"]];
            NSLog(@"%@",json);
            
        }
        return NO;
    }
    else {
        if (strongDelegate && [strongDelegate respondsToSelector:@selector(webView:shouldStartLoadWithRequest:navigationType:)]) {
            return [strongDelegate webView:webView shouldStartLoadWithRequest:request navigationType:navigationType];
        } else {
            return YES;
        }
    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    if (webView != _webView) {
        return;
    }
    
    // ----------------------------- responds super delegate ----------------------------- //
    __strong typeof(_superDelegate) strongDelegate = _superDelegate;
    if (strongDelegate && [strongDelegate respondsToSelector:@selector(webView:didFailLoadWithError:)]) {
        [strongDelegate webView:webView didFailLoadWithError:error];
    }
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    if (webView != _webView) {
        return;
    }
    
    // ----------------------------- responds super delegate ----------------------------- //
    __strong typeof(_superDelegate) strongDelegate = _superDelegate;
    if (strongDelegate && [strongDelegate respondsToSelector:@selector(webViewDidStartLoad:)]) {
        [strongDelegate webViewDidStartLoad:webView];
    }
}

#pragma mark - encodeURIComponent

- (NSString *)encodeURIComponent:(NSString *)string
{
    static NSString * const kLegalCharactersToBeEscaped = @"!*'();:@&=+$,/?%#[]";
    return (__bridge_transfer NSString *)CFURLCreateStringByAddingPercentEscapes(NULL, (__bridge CFStringRef)string, NULL, (__bridge CFStringRef)kLegalCharactersToBeEscaped, kCFStringEncodingUTF8);
}

- (NSString *)decodeURIComponent:(NSString *)string
{
    return (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL, (__bridge CFStringRef)string, CFSTR(""), kCFStringEncodingUTF8);
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self initBridge:_webView withSuperDelegate:_superDelegate];

    
    [self setUpWebview:@"index2" CGRectMakeForWebview:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64)];
    
    
    
}
-(void)setUpWebview:(NSString *)htmlName CGRectMakeForWebview:(CGRect)webviewFrame;
{
    _webView = [[UIWebView alloc]initWithFrame:webviewFrame];
//    NSString *str = [[NSBundle mainBundle] bundlePath];
    _webView.delegate = self;
    NSString *mainBundleDirectory = [[NSBundle mainBundle] bundlePath];
    NSString *path1 = [mainBundleDirectory  stringByAppendingPathComponent:@"web"];
    NSURL *baseURL = [NSURL fileURLWithPath:path1];
    
//    NSString *path = [[NSBundle mainBundle] pathForResource:htmlName ofType:@"html"];
    NSString *str = [NSString stringWithFormat:@"web/%@.html",htmlName];
    NSString *path = [mainBundleDirectory stringByAppendingPathComponent:str];
    NSLog(@"%@ %@",path1,path);

    NSString *html = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    [_webView loadHTMLString:html baseURL:baseURL];
//    NSURL *url = [NSURL URLWithString:@"http://lmmm0013.gotoip55.com/Bridge/bridge.html"];
    
//    [_webView loadRequest:[NSURLRequest requestWithURL:url]];
    
    [self.view addSubview:_webView];

    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
  

//    self.navigationController.navigationBarHidden= NO;
//    [[UINavigationBar appearance] setBarTintColor:[UIColor redColor]];
//    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
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
