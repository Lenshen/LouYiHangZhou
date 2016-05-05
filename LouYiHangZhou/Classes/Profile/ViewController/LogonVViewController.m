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
#import "SVProgressHUD.h"
#import "UIButton+countDown.h"
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
   

  UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
  self.navigationItem.backBarButtonItem = item;
    [self setTextField];
    
    
}


-(void)setTextField

{
    _passwordTF.enabled = NO;
    _passwordTF.keyboardType = UIKeyboardTypePhonePad;
    _userName.keyboardType = UIKeyboardTypePhonePad;
    
    
    [_passwordTF addTarget:self action:@selector(logoButtonBackgroundChange) forControlEvents:UIControlEventEditingChanged];
    [_userName addTarget:self action:@selector(passwordCanWirtte) forControlEvents:UIControlEventEditingChanged];
    
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

        [self.logoButton canSelectButton];
    }else
    {
        [self.logoButton canNotSelectButton];
    
    }
}
- (IBAction)logoEvent:(id)sender {
    
    [SVProgressHUD showWithStatus:@"请稍等...."];
    [_userName resignFirstResponder];
    [_passwordTF resignFirstResponder];

    [BYSHttpTool GET:APP_USER_API Parameters:[HttpParameters user_autoSendMobiel:_userName.text password:_passwordTF.text] Success:^(id responseObject)
{
        
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
        
                NSDictionary *userdic = @{@"mobile":[USER_DEFAULT objectForKey:@"mobile"],@"sex":[USER_DEFAULT objectForKey:@"sex"],@"avatar":[USER_DEFAULT objectForKey:@"avatar"],@"user_id":[USER_DEFAULT objectForKey:@"user_id"],@"birth":[USER_DEFAULT objectForKey:@"birth"]};
        
                [USER_DEFAULT setObject:userdic forKey:@"userimformation"];
                [SVProgressHUD dismiss];

                }
             Failure:^(NSError *error) {
                 NSLog(@"%@",error);
                [SVProgressHUD showErrorWithStatus:@"请稍候重试..."];
                
                    
                    
                    
            }];
            
}
        if (responseObject[@"message"] != nil && ![responseObject[@"message"]  isKindOfClass:[NSNull class]])
        {
            {
               NSString *message = responseObject[@"message"];
                [message alert:message viewcontroller:self];
                [SVProgressHUD dismiss];

            }
        }
        
            
            
            
      
    } Failure:^(NSError *error) {
        NSLog(@"%@",error);
        [SVProgressHUD dismiss];


    }];
   

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
}



@end
