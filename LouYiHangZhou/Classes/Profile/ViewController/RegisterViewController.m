//
//  RegisterViewController.m
//  LouYiHangZhou
//
//  Created by 远深 on 16/4/8.
//  Copyright © 2016年 Luo Yi TECHNOLOGY. All rights reserved.
//

#import "RegisterViewController.h"
#import "UIButton+countDown.h"
#import "BYSHttpTool.h"

@interface RegisterViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIButton *codeButton;
@property (weak, nonatomic) IBOutlet UITextField *mobileTF;
@property (weak, nonatomic) IBOutlet UITextField *codeTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;
@property (weak, nonatomic) IBOutlet UIButton *registerButton;
@property (strong, nonatomic) NSDictionary *registerDic;


@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
    self.codeButton.layer.cornerRadius = 5;
    [self.codeButton setBackgroundColor:[UIColor grayColor]];

   
    _mobileTF.delegate = self;
    _codeTF.delegate = self;
    _passwordTF.delegate = self;
    [_mobileTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
  

    
   

}
- (IBAction)registerEvent:(id)sender {
   
    NSString *str = @"http://192.168.0.103:7021/api/user/reg";
    NSDictionary *parameter = @{@"mobile":_mobileTF.text,@"access_token":@"101",@"func_id":@"100",@"password":_passwordTF.text,@"code":_codeTF.text};
    [BYSHttpTool POST:str Parameters:parameter Success:^(id responseObject) {
        _registerDic = responseObject;
        NSLog(@"%@",responseObject);
        NSString *message = _registerDic[@"message"];
        if ([message isEqualToString:@"注册成功"]) {
            [self.navigationController popToRootViewControllerAnimated:YES];
//            NSString *str = @"http://192.168.0.103:7021/api/authorized/user";
//            NSDictionary *parameter = @{@"login_name":@"18258435631",@"access_token":@"101",@"user_type":@"0",@"password":@"123456",@"client_ip":[USER_DEFAULT objectForKey:@"client_id"]};
//            [BYSHttpTool GET:str Parameters:parameter Success:^(id responseObject) {
//                NSLog(@"%@",responseObject);
//            } Failure:^(NSError *error) {
//                NSLog(@"%@",error);
//            }];
        }else
        {
            [self alert:message];
        }
        

    } Failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
}
-(void)alert:(NSString *)message
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:message message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
}
- (void)textFieldDidChange:(UITextField *)textField
{
    if (textField == self.mobileTF) {
        if (textField.text.length == 11) {
            self.codeButton.enabled = YES;
            [self.codeButton setBackgroundColor:[UIColor redColor]];
            
        }else
            
        {
            self.codeButton.enabled = NO;
            
            [self.codeButton setBackgroundColor:[UIColor grayColor]];
        }

    }
}



- (IBAction)getCode:(id)sender {
    [_codeButton startWithTime:59.0 title:@"获取验证码" countDownTitle:@"秒后再验证码" mainColor:nil countColor:[UIColor whiteColor]];
    NSString *str = @"http://192.168.0.103:7021/api/MobileVerifyCode/send";
    NSDictionary *parameter = @{@"mobile":_mobileTF.text,@"access_token":@"101",@"func_id":@"100"};
    [BYSHttpTool POST:str Parameters:parameter Success:^(id responseObject) {
        NSDictionary *res = responseObject;
        NSLog(@"%@",responseObject);
    } Failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = NO;
    self.title = @"注册";
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
