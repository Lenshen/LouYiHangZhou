//
//  LogonVViewController.m
//  LouYiHangZhou
//
//  Created by 远深 on 16/4/8.
//  Copyright © 2016年 Luo Yi TECHNOLOGY. All rights reserved.
//

#import "LogonVViewController.h"
#import "BYSHttpTool.h"
#import "UserImformationModel.h"

@interface LogonVViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UIButton *logoButton;
@property (strong, nonatomic) UserImformationModel *useModel1;
@property (strong, nonatomic) NSDictionary *dic;



@end

@implementation LogonVViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
 
    
    
}
- (IBAction)logoEvent:(id)sender {
    NSString *str1 = @"http://192.168.0.103:7021/api/authorized/user";
    NSDictionary *parameter1 = @{@"login_name":@"18258435630",@"access_token":@"101",@"user_type":@"0",@"password":@"123456",@"client_ip":[USER_DEFAULT objectForKey:@"client_id"]};
    [BYSHttpTool GET:str1 Parameters:parameter1 Success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        NSDictionary *dic = responseObject;
        NSDictionary *paratemers12 = @{@"access_token":dic[@"data"]};
        [BYSHttpTool GET:@"http://192.168.0.103:7021/api/user/get" Parameters:paratemers12 Success:^(id responseObject) {
            NSLog(@"%@",responseObject);
             _dic = responseObject[@"data"];
            
            
            _useModel1 = [[UserImformationModel sharedManager]initWithDictionary:_dic error:nil];
            NSLog(@"%@",_useModel1);
            [USER_DEFAULT setObject:_useModel1.mobile forKey:@"userName"];         [USER_DEFAULT setObject:_useModel1.sex forKey:@"sex"];
            [USER_DEFAULT setObject:_useModel1.birth forKey:@"birth"];

            [self.navigationController popToRootViewControllerAnimated:YES];
        } Failure:^(NSError *error) {
            NSLog(@"%@",error);
        }];
    } Failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
   


}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = NO;
    self.title = @"登陆";
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
