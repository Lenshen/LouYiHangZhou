//
//  ChangeReceptionViewController.m
//  进口零食
//
//  Created by 远深 on 16/4/29.
//  Copyright © 2016年 Luo Yi TECHNOLOGY. All rights reserved.
//

#import "ChangeReceptionViewController.h"

@interface ChangeReceptionViewController ()

@end

@implementation ChangeReceptionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@",_model);
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated
{
    
    self.navigationController.navigationBarHidden = NO;
    self.title = @"修改收货地址";

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
