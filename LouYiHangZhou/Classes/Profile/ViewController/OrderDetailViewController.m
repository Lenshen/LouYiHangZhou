//
//  OrderDetailViewController.m
//  踏踏海
//
//  Created by 远深 on 16/5/18.
//  Copyright © 2016年 Luo Yi TECHNOLOGY. All rights reserved.
//

#import "OrderDetailViewController.h"

@interface OrderDetailViewController ()<UIWebViewDelegate>
{
    
}
@property (nonatomic ,strong)UIWebView *webview;
@property (nonatomic)BOOL firstRequest;
@end

@implementation OrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpWebview];
    self.firstRequest = YES;
    self.edgesForExtendedLayout = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;

}

- (void)setUpWebview;
{
    
    _webview = [[UIWebView alloc]initWithFrame:CGRectMake(0, -64, self.view.frame.size.width, self.view.frame.size.height)];
    _webview.delegate = self;
    _webview.scrollView.bounces = NO;
    
    
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    dispatch_async(queue, ^{
        
        
        NSURLRequest *request1 = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"https://m.kuaidi100.com/index_all.html?type=shentong&postid=3308347602249"]];
        NSLog(@"%@",request1);
        
        
        [_webview loadRequest:request1];
        dispatch_queue_t mainqueue = dispatch_get_main_queue();
        dispatch_async(mainqueue, ^{
            [self.view addSubview:_webview];
        });
        
    });
    
    
}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
  
    if (self.firstRequest) {
        NSLog(@"%@",request);
        self.firstRequest = NO;
        return YES;
    }
    else {
        return NO;
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    self.navigationController.navigationBarHidden = YES;
    
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = NO;
    self.title = @"查询结果";
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
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
