//
//  OrderStatusViewController.m
//  LouYiHangZhou
//
//  Created by 远深 on 16/4/20.
//  Copyright © 2016年 Luo Yi TECHNOLOGY. All rights reserved.
//

#import "OrderStatusViewController.h"
#import "ProfileViewController.h"
#import "UIViewController+StoryboardFrom.h"

@interface OrderStatusViewController ()

@end

@implementation OrderStatusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"%@",self.indexName);
    
}
-(void)setUpWebview:(NSString *)htmlName CGRectMakeForWebview:(CGRect)webviewFrame
{
    [super setUpWebview:self.indexName CGRectMakeForWebview:self.view.frame];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = NO;
    
    
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
