//
//  HomeViewController.m
//  LouYiHangZhou
//
//  Created by 远深 on 16/4/8.
//  Copyright © 2016年 Luo Yi TECHNOLOGY. All rights reserved.
//

#import "HomeViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>


@interface HomeViewController ()<UIWebViewDelegate>
@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic, weak) JSContext *jsContext;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.webView.delegate = self;
    [self setUpWebview:@"index2" CGRectMakeForWebview:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64)];
    
    
    
}
-(void)setUpWebview:(NSString *)htmlName CGRectMakeForWebview:(CGRect)webviewFrame;
{
    UIWebView *webview = [[UIWebView alloc]initWithFrame:webviewFrame];
//    NSString *str = [[NSBundle mainBundle] bundlePath];
    NSString *mainBundleDirectory = [[NSBundle mainBundle] bundlePath];
    NSString *path1 = [mainBundleDirectory  stringByAppendingPathComponent:@"web"];
    NSURL *baseURL = [NSURL fileURLWithPath:path1];
    
//    NSString *path = [[NSBundle mainBundle] pathForResource:htmlName ofType:@"html"];
    NSString *str = [NSString stringWithFormat:@"web/%@.html",htmlName];
    NSString *path = [mainBundleDirectory stringByAppendingPathComponent:str];
    NSLog(@"%@ %@",path1,path);

    NSString *html = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    [webview loadHTMLString:html baseURL:baseURL];
    [self.view addSubview:webview];

    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
  

//    self.navigationController.navigationBarHidden= NO;
//    [[UINavigationBar appearance] setBarTintColor:[UIColor redColor]];
//    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
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
