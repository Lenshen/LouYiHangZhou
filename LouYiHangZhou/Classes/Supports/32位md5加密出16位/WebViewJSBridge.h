//
//  WebViewJSBridge.h
//  SHUO
//
//  Created by XL on 14-8-7.
//  Copyright (c) 2014年 XL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol OpenWebviewDelegate <NSObject>
@optional
- (void)openGoodDetailWebviewWithString:(NSString *)goods_id;
- (void)openGoodsWebbiewWihtString:(NSString *)type_id brand_id:(NSString *)brand_id;
-(void)openAddAddress;


@end
@interface WebViewJSBridge : UIViewController <UIWebViewDelegate>
@property (nonatomic, strong) NSString *goods_id;
@property BOOL openWebview;
@property (nonatomic, retain) IBOutlet UIWebView *webView;
@property (nonatomic, retain) id superDelegate;
@property (nonatomic,retain)  id <OpenWebviewDelegate>openWebviewDelegate;

+ (instancetype)bridgeForWebView:(UIWebView *)webView withSuperDelegate:(id)superDelegate;

- (void)initBridge:(UIWebView *)webView withSuperDelegate:(id)superDelegate;

- (void)executeScript:(NSString *)script;

- (void)executeScriptFunction:(NSString *)function withArgs:(NSArray *)args;

- (void)executeCallback:(NSString *)callback withArgs:(NSArray *)args;

- (void)converters:(NSString *)type name:(NSString *)name args:(NSDictionary *)args callback:(NSString *)callback;
- (void)executeSelector:(NSString *)name args:(NSDictionary *)args callback:(NSString *)callback;
- (void)getToken:(NSString *)callback;

- (void)showWaiting:(NSDictionary *)args ;
-(void)hideWaiting;
-(void)getUser:(NSString *)callback;
-(void)openWebview:(NSURL *)url;
-(void)closeWebview;
-(void)signin;
@end


@protocol WebViewJSBridgeDelegate <NSObject>

@optional

- (void)converters:(NSString *)type name:(NSString *)name args:(NSDictionary *)args callback:(NSString *)callback;
- (void)executeSelector:(NSString *)name args:(NSDictionary *)args callback:(NSString *)callback;


@end

