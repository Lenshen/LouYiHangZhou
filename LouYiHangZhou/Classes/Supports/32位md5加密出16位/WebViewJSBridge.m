//
//  WebViewJSBridge.m
//  SHUO
//
//  Created by XL on 14-8-7.
//  Copyright (c) 2014年 XL. All rights reserved.
//

#import "WebViewJSBridge.h"
#import "SVProgressHUD.h"
#import "LogonViewController.h"
#import "UIViewController+StoryboardFrom.h"

#define JSBridgeName @"MallJSBridge"
#define JSBridgeProtocol @"bridge://"

@implementation WebViewJSBridge

+ (instancetype)bridgeForWebView:(UIWebView *)webView withSuperDelegate:(id)superDelegate
{
    WebViewJSBridge *bridge = [self new];
    [bridge initBridge:webView withSuperDelegate:superDelegate];
    return bridge;
}

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

- (void)getToken:(NSString *)callback
{
    NSString *str = [USER_DEFAULT objectForKey:@"user_token"];
    
    if (str == nil) {
        str = @"";
    }
    [self executeCallback:callback withArgs: @[str]];
}
- (void)showWaiting:(NSDictionary *)args
{
    
    NSString *message = [args objectForKey:@"message"];
    [SVProgressHUD showWithStatus:message];
    
}
-(void)closeWebview
{
    
}
-(void)openWebview:(NSURL *)url
{
}
-(void)hideWaiting
{
    [SVProgressHUD dismiss];
}

-(void)signin
{
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"LogonVViewController" object:self userInfo:@{@"LogonVViewController":@"LogonVViewController"}];
    
}
-(void)getUser:(NSString *)callback
{
    NSDictionary *dic = [USER_DEFAULT objectForKey:@"userimformation"];
    NSLog(@"%@",dic);
    if (dic != nil) {
        dic = @{};
    }
    [self executeCallback:callback withArgs:@[dic]];
}

// 执行OC函数
- (void)executeSelector:(NSString *)name args:(NSDictionary *)args callback:(NSString *)callback
{
    
    
    if ([name isEqualToString:@"getToken"]) {
        [self getToken:callback];
    }
    else if ([name isEqualToString:@"showWaiting"]) {
        [self showWaiting:args  ];
    }else if ([name isEqualToString:@"hideWaiting"])
    {
        [self closeWebview];
        
    }else if ([name isEqualToString:@"getUser"])
    {
        [self getUser:callback];
    }else if ([name isEqualToString:@"openWebview"])
    {
        NSURL *url = [NSURL URLWithString:callback];
        [self openWebview:url];
    }else if ([name isEqualToString:@"closeWebview"])
    {
        [self closeWebview];
    }else if ([name isEqualToString:@"signin"])
    {
        [self signin];
    }

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

// 组装Javascript函数格式
- (void)executeScriptFunction:(NSString *)function withArgs:(NSArray *)args
{
    NSMutableArray *argsArray = [[NSMutableArray alloc] init];
    for (NSInteger i = 0, len = [args count]; i < len; i++) {
        [argsArray addObject:[NSString stringWithFormat:@"'%@'", [args objectAtIndex:i]]];
    }
    NSString *argsString = [argsArray componentsJoinedByString:@","];
    NSString *script = [NSString stringWithFormat:@"%@(%@);", function, argsString];
    [self executeScript:script];
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
        NSLog(@"%@",fileContent);
        NSString *JSScript = [NSString stringWithFormat:fileContent, JSBridgeName, JSBridgeProtocol];
//        LOG(@"JSScript: %@", JSScript);
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
        NSInteger protocolLength = [JSBridgeProtocol length];
        NSString *jsonString = [url substringFromIndex:protocolLength];
        if (![jsonString isEqualToString:@""]) {
            NSString *jsonDecodeString = [self decodeURIComponent:jsonString];
            NSData *jsonData = [jsonDecodeString dataUsingEncoding:NSUTF8StringEncoding];
        
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
            NSDictionary *args = [json objectForKey:@"args"];
            NSLog(@"args-------%@",[json objectForKey:@"name"]);
            
            [self converters:[json objectForKey:@"type"] name:[json objectForKey:@"name"] args:args callback:[json objectForKey:@"callback"]];
            
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


@end


