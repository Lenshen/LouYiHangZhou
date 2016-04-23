//
//  PayViewController.m
//  进口零食
//
//  Created by 远深 on 16/4/23.
//  Copyright © 2016年 Luo Yi TECHNOLOGY. All rights reserved.
//

#import "PayViewController.h"

@interface PayViewController ()

@end

@implementation PayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIWebView *webview = [[UIWebView alloc]initWithFrame:CGRectMake(0,0, self.view.frame.size.width, self.view.frame.size.height)];
    NSString *mainBundleDirectory = [[NSBundle mainBundle] bundlePath];
    NSString *path1 = [mainBundleDirectory  stringByAppendingPathComponent:@"web"];
    NSURL *baseURL = [NSURL fileURLWithPath:path1];
    
    //    NSString *path = [[NSBundle mainBundle] pathForResource:htmlName ofType:@"html"];
    NSString *str = [NSString stringWithFormat:@"web/order-confirm.html"];
    NSString *path = [mainBundleDirectory stringByAppendingPathComponent:str];
    NSLog(@"%@ %@",path1,path);
    
    NSString *html = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    [webview loadHTMLString:html baseURL:baseURL];
    [self.view addSubview:webview];
    
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
