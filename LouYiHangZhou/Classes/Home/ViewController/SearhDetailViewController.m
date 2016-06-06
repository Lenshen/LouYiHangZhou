//
//  SearhDetailViewController.m
//  进口零食
//
//  Created by 远深 on 16/5/5.
//  Copyright © 2016年 Luo Yi TECHNOLOGY. All rights reserved.
//

#import "SearhDetailViewController.h"
#import "WebViewJSBridge.h"
#import "CommentListViewController.h"

@interface SearhDetailViewController ()<UIWebViewDelegate,OpenWebviewDelegate>
@property (nonatomic, strong)WebViewJSBridge *bridge;
@property (nonatomic, strong)UIWebView *webview;



@end

@implementation SearhDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    
}


-(void)setUpWebview:(NSString *)htmlName
{
    
    
    _webview = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    _webview.delegate = self;


    
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    dispatch_async(queue, ^{
        NSString *mainBundleDirectory = [[NSBundle mainBundle] bundlePath];
        
        NSString *str3 = [NSString stringWithFormat:@"web/goods-detail.html?id=%@",htmlName];
        NSString *path = [mainBundleDirectory stringByAppendingPathComponent:str3];
        
        _bridge = [WebViewJSBridge bridgeForWebView:_webview withSuperDelegate:self];
        _bridge.openWebviewDelegate = self;
        NSURLRequest *request1 = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"file://%@",[path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]]]];
        NSLog(@"%@",request1);
      
        [_webview loadRequest:request1];
        dispatch_queue_t mainqueue = dispatch_get_main_queue();
    dispatch_async(mainqueue, ^{
          [self.view addSubview:_webview];
    });
      
    });

    
}
-(void)openGoodDetailWebviewWithString:(NSString *)goods_id
{
    
    SearhDetailViewController *gooddetail = [[SearhDetailViewController alloc]init];
    gooddetail.hidesBottomBarWhenPushed = YES;
    gooddetail.indexName = goods_id;
    [self.navigationController pushViewController:gooddetail animated:YES];
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = NO;
    self.title = @"商品详情";

    [self setUpWebview:self.indexName];
   
    
}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    NSString *url = [[request URL] absoluteString];
    NSLog(@"%@",url);
    if ([url rangeOfString:@"list"].location != NSNotFound) {
        NSArray *array = [url componentsSeparatedByString:@"?"];
        
        NSString *good_id = [array[1] substringFromIndex:3];
        if (good_id.length != 0) {
            CommentListViewController *detail = [[CommentListViewController alloc]init];
            
            detail.commentIndexName = good_id;
            
            [self.navigationController pushViewController:detail animated:YES];
            
        }
    
        
        
        
        
        
    }else
    {
        NSLog(@"notiaozhuan");
    }
    
    
    
    return YES;
}

-(void)viewWillDisappear:(BOOL)animated

{
    self.navigationController.navigationBarHidden = YES;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    _webview = nil;
    
}
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
