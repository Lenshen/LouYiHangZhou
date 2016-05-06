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
#define JSBridgeName @"MALLJSBridge"
#define JSBridgeProtocol @"bridge://"


@interface HomeViewController ()<UIWebViewDelegate>
@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic, weak) JSContext *jsContext;


@end

@implementation HomeViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

  
    
    [self setUpWebview:@"index2" CGRectMakeForWebview:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64)];
    
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
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    // 禁用用户选择
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserSelect='none';"];
    
    // 禁用长按弹出框
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitTouchCallout='none';"];
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

    NSString *html = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    [_webView loadHTMLString:html baseURL:baseURL];
//    NSURL *url = [NSURL URLWithString:@"http://lmmm0013.gotoip55.com/Bridge/bridge.html"];
    _webView.scalesPageToFit = NO;
//    _webView.scrollView.scrollEnabled = no
//    [_webView loadRequest:[NSURLRequest requestWithURL:url]];
    
    [self.view addSubview:_webView];

    
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];

  

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
