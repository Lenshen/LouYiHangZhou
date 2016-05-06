//
//  SearhDetailViewController.m
//  进口零食
//
//  Created by 远深 on 16/5/5.
//  Copyright © 2016年 Luo Yi TECHNOLOGY. All rights reserved.
//

#import "SearhDetailViewController.h"

@interface SearhDetailViewController ()


@end

@implementation SearhDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"%@",self.indexName);
    [self setUpWebview:self.indexName CGRectMakeForWebview:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    
}
-(void)setUpWebview:(NSString *)htmlName CGRectMakeForWebview:(CGRect)webviewFrame
{
    UIWebView *webview = [[UIWebView alloc]initWithFrame:webviewFrame];
    NSString *mainBundleDirectory = [[NSBundle mainBundle] bundlePath];
    
    NSString *str3 = [NSString stringWithFormat:@"web/goods-detail.html?status=%@",htmlName];
    NSString *path = [mainBundleDirectory stringByAppendingPathComponent:str3];
    
    
    NSURLRequest *request1 = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"file://%@",[path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]]]];
    NSLog(@"%@",request1);
    
    
    [webview loadRequest:request1];
    
    [self.view addSubview:webview];
    
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = NO;
    self.title = @"商品详情";
    
    
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
