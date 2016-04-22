//
//  ForgotPassWViewController.m
//  LouYiHangZhou
//
//  Created by 远深 on 16/4/9.
//  Copyright © 2016年 Luo Yi TECHNOLOGY. All rights reserved.
//

#import "ForgotPassWViewController.h"
#import "UIButton+countDown.h"
#import "BYSHttpTool.h"
#import "HttpParameters.h"



@interface ForgotPassWViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *mobileTF;
@property (weak, nonatomic) IBOutlet UITextField *codeTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;
@property (weak, nonatomic) IBOutlet UIButton *registerButton;
@property (strong, nonatomic) NSDictionary *registerDic;

@end

@implementation ForgotPassWViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    _mobileTF.delegate = self;
    _codeTF.delegate = self;
    _passwordTF.delegate = self;
    [_mobileTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = NO;
    self.title = @"更换密码";
}

- (IBAction)registerEvent:(id)sender {
    [BYSHttpTool GET:APP_USER_PASSWORD Parameters:[HttpParameters change_password:nil newpassword:_passwordTF.text oldpassword:_codeTF.text] Success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        if (responseObject[@"message"] != nil && ![responseObject[@"message"]  isKindOfClass:[NSNull class]]) {
            
                NSString *message = responseObject[@"message"];
                [USER_DEFAULT removeObjectForKey:@"user_token"];
        
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
        [self.navigationController popToRootViewControllerAnimated:YES];
    }];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
}
- (void)textFieldDidChange:(UITextField *)textField
{
    if (textField == self.mobileTF) {
        if (textField.text.length == 11) {
            
        }else
            
        {
            
        }
        
    }
}




- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    self.navigationController.navigationBarHidden = YES;
    
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
