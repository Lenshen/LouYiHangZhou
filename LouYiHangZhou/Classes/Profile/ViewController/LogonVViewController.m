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
#import "HttpParameters.h"
#import "NSString+MD5.h"

@interface LogonVViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (strong, nonatomic) IBOutlet UITextField *passwordTF;
@property (weak, nonatomic) IBOutlet UIButton *logoButton;
@property (strong, nonatomic) UserImformationModel *useModel;
@property (strong, nonatomic) NSDictionary *dic;




@end

@implementation LogonVViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  [[UINavigationBar appearance] setTintColor:[UIColor blackColor]];


    _passwordTF.enabled = NO;
    _passwordTF.keyboardType = UIKeyboardTypePhonePad;
    _userName.keyboardType = UIKeyboardTypePhonePad;

 
    [_passwordTF addTarget:self action:@selector(logoButtonBackgroundChange) forControlEvents:UIControlEventEditingChanged];
    [_userName addTarget:self action:@selector(passwordCanWirtte) forControlEvents:UIControlEventEditingChanged];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
}
-(void)passwordCanWirtte
{
    if ( _userName.text.length == 11) {
        _passwordTF.enabled = YES;

    }else
        _passwordTF.enabled = NO;

    
}
-(void)logoButtonBackgroundChange
{
    if (_passwordTF.text.length > 5 && _userName.text.length == 11) {
        [self.logoButton setBackgroundImage:[UIImage imageNamed:@"登陆注册按钮"] forState:UIControlStateNormal];
        [self.logoButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }else
    {
        [self.logoButton setBackgroundImage:[UIImage imageNamed:@"登陆按钮框"] forState:UIControlStateNormal];
        [self.logoButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    }
}
- (IBAction)logoEvent:(id)sender {
    [_userName resignFirstResponder];
    [_passwordTF resignFirstResponder];
    [BYSHttpTool GET:APP_USER_API Parameters:[HttpParameters user_autoSendMobiel:_userName.text password:_passwordTF.text] Success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        if (responseObject[@"data"] != nil && ![responseObject[@"data"]  isKindOfClass:[NSNull class]])
        {
            [USER_DEFAULT setObject:responseObject[@"data"] forKey:@"user_token"];
            [BYSHttpTool GET:APP_USER_GET Parameters:[HttpParameters app_get_userImformation:nil] Success:^(id responseObject) {
                NSLog(@"%@",responseObject);
                [self.navigationController popToRootViewControllerAnimated:YES];
                NSDictionary *dic = responseObject[@"data"];
                _useModel = [[UserImformationModel alloc]initWithDictionary:dic error:nil];
                [USER_DEFAULT setObject:_useModel.mobile forKey:@"mobile"];
                [USER_DEFAULT setObject:_useModel.sex forKey:@"sex"];
                [USER_DEFAULT setObject:_useModel.birth forKey:@"birth"];
                [USER_DEFAULT setObject:_useModel.user_id forKey:@"user_id"];
                [USER_DEFAULT setObject:_useModel.avatar forKey:@"avatar"];
                
            } Failure:^(NSError *error) {
               
            }];
            
        }
        if (responseObject[@"message"] != nil && ![responseObject[@"message"]  isKindOfClass:[NSNull class]]) {
            {
               NSString *message = responseObject[@"message"];
                [self alert:message];
            }
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
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [_userName resignFirstResponder];
    [_passwordTF resignFirstResponder];
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
