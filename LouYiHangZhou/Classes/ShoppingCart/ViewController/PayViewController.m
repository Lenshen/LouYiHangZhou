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
@interface PayViewController ()<UIWebViewDelegate,OpenWebviewDelegate>
@property (nonatomic ,strong)WebViewJSBridge *bridge;
@property (nonatomic ,strong)UIWebView *webview;

@end

@implementation PayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  
//      [self setUpWebview];
}
- (void)setUpWebview;
{
    
         _webview = [[UIWebView alloc]initWithFrame:CGRectMake(0,64, self.view.frame.size.width, self.view.frame.size.height)];
    _webview.scrollView.scrollEnabled = YES;
//    _webview.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height+66);
    
     
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

-(void)openAddAddress
{
    
    [self.navigationController pushViewController:[AddReceptionViewController instanceFromStoryboard] animated:YES];

}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = NO;
    self.title = @"结算";
    self.automaticallyAdjustsScrollViewInsets = NO
    ;
   
    [self setUpWebview];
    
  
  
    

}
- (void)viewWillDisappear:(BOOL)animated
{
   
    [super viewWillDisappear:YES];
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
