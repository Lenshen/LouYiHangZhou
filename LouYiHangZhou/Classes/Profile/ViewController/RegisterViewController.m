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
#import "NSString+MD5.h"
#import "SVProgressHUD.h"

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
    self.codeButton.enabled = NO;

    self.codeButton.layer.cornerRadius = 5;
    [self.codeButton setBackgroundColor:[UIColor grayColor]];

   
    _mobileTF.delegate = self;
    _codeTF.delegate = self;
    _passwordTF.delegate = self;
    [_mobileTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [_passwordTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    
  

    
   
}
- (IBAction)registerEvent:(id)sender {
   
    NSString *str = APP_REGISTER;
    NSDictionary *parameter = @{@"mobile":_mobileTF.text,@"access_token":[USER_DEFAULT objectForKey:@"app_autorizd_number"],@"func_id":@"100",@"password":_passwordTF.text,@"code":_codeTF.text};
    [BYSHttpTool POST:str Parameters:parameter Success:^(id responseObject) {
        _registerDic = responseObject;
        NSLog(@"%@",responseObject);
        NSString *message = _registerDic[@"message"];
        if ([message isEqualToString:@"注册成功"]) {
            [self.navigationController popViewControllerAnimated:YES];

        }else
        {
            [message alert:message viewcontroller:self];
        }
        

    } Failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
}

- (void)textFieldDidChange:(UITextField *)textField
{
    if (textField == self.mobileTF)
    {
        if (textField.text.length == 11)
        {
            self.codeButton.enabled = YES;
            [self.codeButton setBackgroundColor:[UIColor redColor]];
            
        }else
            
        {
            self.codeButton.enabled = NO;
            
            [self.codeButton setBackgroundColor:[UIColor grayColor]];
        }

    }else if(textField == self.passwordTF)
    {
        
        if (textField.text.length > 5) {
            self.registerButton.enabled = YES;
            [self.registerButton setBackgroundImage:[UIImage imageNamed:@"登陆注册按钮"] forState:UIControlStateNormal];
            [self.registerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }else
        {
            [self.registerButton setBackgroundImage:[UIImage imageNamed:@"登陆按钮框"] forState:UIControlStateNormal];
            [self.registerButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        }
        
        
        
    }
}



- (IBAction)getCode:(id)sender {
    [SVProgressHUD show];
    [_codeButton startWithTime:59.0 title:@"获取验证码" countDownTitle:@"秒后再验证码" mainColor:nil countColor:[UIColor whiteColor]];
    NSString *str = APP_MOBILEVERIFY;
    NSDictionary *parameter = @{@"mobile":_mobileTF.text,@"access_token":[USER_DEFAULT objectForKey:@"app_autorizd_number"],@"type":@"0"};
    [BYSHttpTool GET:str Parameters:parameter Success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        [SVProgressHUD dismiss];
    } Failure:^(NSError *error) {
        NSLog(@"%@",error);
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:@"服务器未响应"];
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
- (IBAction)blackRegister:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
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
