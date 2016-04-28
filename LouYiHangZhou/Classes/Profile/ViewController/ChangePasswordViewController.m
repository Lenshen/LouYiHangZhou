//
//  ChangePasswordViewController.m
//  LouYiHangZhou
//
//  Created by 远深 on 16/4/22.
//  Copyright © 2016年 Luo Yi TECHNOLOGY. All rights reserved.
//

#import "ChangePasswordViewController.h"
#import "BYSHttpTool.h"
#import "HttpParameters.h"
#import "UIButton+countDown.h"
//ddddd
@interface ChangePasswordViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIButton *codeButton;
@property (weak, nonatomic) IBOutlet UITextField *mobileTF;
@property (weak, nonatomic) IBOutlet UITextField *codeTF;
@property (weak, nonatomic) IBOutlet UITextField *niupasswordTF;
@property (weak, nonatomic) IBOutlet UIButton *registerButton;
@property (strong, nonatomic) NSDictionary *registerDic;

@end

@implementation ChangePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.codeButton.enabled = NO;
    
    self.codeButton.layer.cornerRadius = 5;
    [self.codeButton setBackgroundColor:[UIColor grayColor]];
    
    
    _mobileTF.delegate = self;
    _codeTF.delegate = self;
    _niupasswordTF.delegate = self;
    [_mobileTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    
    
    
    
}
- (IBAction)registerEvent:(id)sender {
    
    NSString *str = APP_USER_FINDPASSWORD;
    NSLog(@"%@%@%@",_mobileTF.text,_niupasswordTF.text,_codeTF.text);
    [BYSHttpTool GET:str Parameters:[HttpParameters find_password:@"" newpassword:_niupasswordTF.text code:_codeTF.text mobile:_mobileTF.text ] Success:^(id responseObject) {
        _registerDic = responseObject;
        NSLog(@"%@",responseObject);
        NSString *message = _registerDic[@"message"];
        if (_registerDic[@"message"] != nil && ![_registerDic[@"message"] isKindOfClass:[NSNull class] ]) {
            [self alert:message];

            
        }
        
        
        
    } Failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
}
-(void)alert:(NSString *)message
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:message message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popViewControllerAnimated:YES];

    }];
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
    NSString *str = APP_MOBILEVERIFY;
    NSDictionary *parameter = @{@"mobile":_mobileTF.text,@"access_token":@"101",@"func_id":@"101"};
    [BYSHttpTool POST:str Parameters:parameter Success:^(id responseObject) {
        NSLog(@"%@",responseObject);
    } Failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = NO;
    self.title = @"忘记密码";
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    self.navigationController.navigationBarHidden = YES;
    
}- (void)didReceiveMemoryWarning {
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
