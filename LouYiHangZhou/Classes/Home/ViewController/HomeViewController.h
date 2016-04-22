//
//  HomeViewController.h
//  LouYiHangZhou
//
//  Created by 远深 on 16/4/8.
//  Copyright © 2016年 Luo Yi TECHNOLOGY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeViewController : UIViewController
@property (nonatomic, retain) id superDelegate;

+ (instancetype)bridgeForWebView:(UIWebView *)webView withSuperDelegate:(id)superDelegate;

- (void)initBridge:(UIWebView *)webView withSuperDelegate:(id)superDelegate;

- (void)executeScript:(NSString *)script;

- (void)executeScriptFunction:(NSString *)function withArgs:(NSArray *)args;

- (void)executeCallback:(NSString *)callback withArgs:(NSArray *)args;

- (void)converters:(NSString *)type name:(NSString *)name args:(NSDictionary *)args callback:(NSString *)callback;
- (void)executeSelector:(NSString *)name args:(NSDictionary *)args callback:(NSString *)callback;


-(void)setUpWebview:(NSString *)htmlName CGRectMakeForWebview:(CGRect)webviewFrame;

@end

@protocol WebViewJSBridgeDelegate <NSObject>

@optional

- (void)converters:(NSString *)type name:(NSString *)name args:(NSDictionary *)args callback:(NSString *)callback;
- (void)executeSelector:(NSString *)name args:(NSDictionary *)args callback:(NSString *)callback;


@end
