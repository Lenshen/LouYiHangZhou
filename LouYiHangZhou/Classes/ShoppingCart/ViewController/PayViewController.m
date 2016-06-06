//
//  PayViewController.m
//  进口零食
//
//  Created by 远深 on 16/4/23.
//  Copyright © 2016年 Luo Yi TECHNOLOGY. All rights reserved.
//

#import "PayViewController.h"
#import "WebViewJSBridge.h"
#import "UIViewController+StoryboardFrom.h"
#import "AddReceptionViewController.h"
#import "SearhDetailViewController.h"
#import "PayTwoViewController.h"
@interface PayViewController ()<UIWebViewDelegate,OpenWebviewDelegate>
@property (nonatomic ,strong)WebViewJSBridge *bridge;
@property (nonatomic ,strong)UIWebView *webview;

@end

@implementation PayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    
    
}

- (void)updateWebview

{
    
    NSString *mainBundleDirectory = [[NSBundle mainBundle] bundlePath];
    
    NSString *path1 = [mainBundleDirectory  stringByAppendingPathComponent:@"web"];
    NSURL *baseURL = [NSURL fileURLWithPath:path1];
    
    //    NSString *path = [[NSBundle mainBundle] pathForResource:htmlName ofType:@"html"];
    
    _bridge = [WebViewJSBridge bridgeForWebView:_webview withSuperDelegate:self];
    _bridge.openWebviewDelegate = self;
    NSString *str = [NSString stringWithFormat:@"web/order-confirm.html"];
    NSString *path = [mainBundleDirectory stringByAppendingPathComponent:str];
    NSLog(@"%@ %@",path1,path);
    
    NSString *html = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    [self.webview loadHTMLString:html baseURL:baseURL];
}
- (void)setUpWebview;
{
    
    self.webview = [[UIWebView alloc]initWithFrame:CGRectMake(0,64, self.view.frame.size.width, self.view.frame.size.height-64)];
    _webview.delegate = self;
    _webview.scrollView.scrollEnabled = YES;
    NSString *mainBundleDirectory = [[NSBundle mainBundle] bundlePath];
    
    NSString *path1 = [mainBundleDirectory  stringByAppendingPathComponent:@"web"];
    NSURL *baseURL = [NSURL fileURLWithPath:path1];
    
    //    NSString *path = [[NSBundle mainBundle] pathForResource:htmlName ofType:@"html"];
    
    _bridge = [WebViewJSBridge bridgeForWebView:_webview withSuperDelegate:self];
    _bridge.openWebviewDelegate = self;
    NSString *str = [NSString stringWithFormat:@"web/order-confirm.html"];
    NSString *path = [mainBundleDirectory stringByAppendingPathComponent:str];
    NSLog(@"%@ %@",path1,path);
    
    NSString *html = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    [_webview loadHTMLString:html baseURL:baseURL];
 
    [self.view addSubview:_webview];
}


-(void)openOrderDetial:(NSString *)order_id
{
    
    PayTwoViewController *paytwo = [[PayTwoViewController alloc]init];
    paytwo.indexName = order_id;
    [self.navigationController pushViewController:paytwo animated:YES];
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    NSString *url = [[request URL] absoluteString];
    if ([url rangeOfString:@"id"].location != NSNotFound) {
        NSLog(@"tiaozhuan");
        NSArray *array = [url componentsSeparatedByString:@"?"];
        
        NSString *good_id = [array[1] substringFromIndex:3];

        SearhDetailViewController *detail = [[SearhDetailViewController alloc]init];
        
        detail.indexName = good_id;
        NSLog(@"%@======%@===========%@======%@",url,array,good_id,detail.indexName);

        [self.navigationController pushViewController:detail animated:YES];
        
        

        

        
    }else
    {
        NSLog(@"notiaozhuan");
    }
    
    
    
    return YES;
}

-(void)openAddAddress
{
    
    [self.navigationController pushViewController:[AddReceptionViewController instanceFromStoryboard] animated:YES];

}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = NO;
    self.title = @"订单详情";
    self.automaticallyAdjustsScrollViewInsets = NO
    ;
   
    if (!_webview) {
        [self setUpWebview];

    }else
    {
        [self updateWebview];
    }
    
  
  
    

}
- (void)viewWillDisappear:(BOOL)animated
{
   
    [super viewWillDisappear:YES];
    self.navigationController.navigationBarHidden = YES;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    _webview = nil;
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
