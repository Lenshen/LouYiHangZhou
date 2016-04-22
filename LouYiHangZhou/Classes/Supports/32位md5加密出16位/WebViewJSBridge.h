//
//  WebViewJSBridge.h
//  SHUO
//
//  Created by XL on 14-8-7.
//  Copyright (c) 2014年 XL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//@protocol WebViewJSBridgeDelegate;

@interface WebViewJSBridge : NSObject <UIWebViewDelegate>

@property (nonatomic, retain) IBOutlet UIWebView *webView;
@property (nonatomic, retain) id superDelegate;

+ (instancetype)bridgeForWebView:(UIWebView *)webView withSuperDelegate:(id)superDelegate;

- (void)initBridge:(UIWebView *)webView withSuperDelegate:(id)superDelegate;

- (void)executeScript:(NSString *)script;

- (void)executeScriptFunction:(NSString *)function withArgs:(NSArray *)args;

- (void)executeCallback:(NSString *)callback withArgs:(NSArray *)args;

- (void)converters:(NSString *)type name:(NSString *)name args:(NSDictionary *)args callback:(NSString *)callback;
- (void)executeSelector:(NSString *)name args:(NSDictionary *)args callback:(NSString *)callback;

@end


@protocol WebViewJSBridgeDelegate <NSObject>

@optional

- (void)converters:(NSString *)type name:(NSString *)name args:(NSDictionary *)args callback:(NSString *)callback;
- (void)executeSelector:(NSString *)name args:(NSDictionary *)args callback:(NSString *)callback;


@end
