//
//  ClassifyBrandViewController.m
//  进口零食
//
//  Created by 远深 on 16/5/5.
//  Copyright © 2016年 Luo Yi TECHNOLOGY. All rights reserved.
//

#import "ClassifyBrandViewController.h"
#import "WebViewJSBridge.h"


@interface ClassifyBrandViewController ()<OpenWebviewDelegate>
@property (nonatomic, strong)UIWebView *webView;
@property (nonatomic, strong)WebViewJSBridge *bridge;


@end

@implementation ClassifyBrandViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
//    _webView.delegate = self;
    
    NSString *mainBundleDirectory = [[NSBundle mainBundle] bundlePath];
    
    
    NSString *htmlStr = [NSString stringWithFormat:@"web/goods.html"];
    NSString *path = [mainBundleDirectory stringByAppendingPathComponent:htmlStr];
    
    
    
    
    _bridge = [WebViewJSBridge bridgeForWebView:_webView withSuperDelegate:self];
    _bridge.openWebviewDelegate = self;
    
    
    NSURLRequest *request1 = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"file://%@",[path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]]]];
    NSLog(@"%@",request1);
    
    [self.webView loadRequest:request1];
    [self.view addSubview:_webView];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = NO;
    self.title = @"品牌详情";
    
    
}
-(void)viewWillDisappear:(BOOL)animated

{
    self.navigationController.navigationBarHidden = YES;
    
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
