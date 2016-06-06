//
//  FeedBackViewController.m
//  LouYiHangZhou
//
//  Created by 远深 on 16/4/11.
//  Copyright © 2016年 Luo Yi TECHNOLOGY. All rights reserved.
//

#import "FeedBackViewController.h"
#import "BYSHttpTool.h"
#import "SVProgressHUD.h"
#import "HttpParameters.h"

@interface FeedBackViewController ()
@property (weak, nonatomic) IBOutlet UITextField *contextTF;

@end

@implementation FeedBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//- (IBAction)black:(id)sender {
//    [self.navigationController popViewControllerAnimated:YES];
//}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = NO;
    self.title = @"意见与反馈";
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    self.navigationController.navigationBarHidden = YES;
    
}
- (IBAction)submitterClick:(id)sender {
    
    [BYSHttpTool POST:APP_USER_ADDINQUIRE Parameters:[HttpParameters app_user_addinquiresMessage:_contextTF.text] Success:^(id responseObject)
    {
        NSLog(@"%@",responseObject);
        
        
        [SVProgressHUD showSuccessWithStatus:@"提交成功"];
        [self.navigationController popViewControllerAnimated:YES];
        
    } Failure:^(NSError *error)
    {
        
        NSLog(@"%@",error);
        [SVProgressHUD showSuccessWithStatus:@"服务器正忙...."];
    }];
    
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
