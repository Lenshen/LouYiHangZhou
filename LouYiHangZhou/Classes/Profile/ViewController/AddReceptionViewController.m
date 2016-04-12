//
//  AddReceptionViewController.m
//  LouYiHangZhou
//
//  Created by 远深 on 16/4/11.
//  Copyright © 2016年 Luo Yi TECHNOLOGY. All rights reserved.
//

#import "AddReceptionViewController.h"
#import "CityViewController.h"
@interface AddReceptionViewController ()
@property (strong, nonatomic) IBOutlet UIButton *cityButton;

@end

@implementation AddReceptionViewController
- (IBAction)black:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)getCity:(id)sender {
    CityViewController *city = [[CityViewController alloc]init];
    city.currentCityString = @"us";
    city.selectString = ^(NSString *string)
    {
        [_cityButton setTitle:string forState:UIControlStateNormal];
    };
    [self presentViewController:city animated:YES completion:nil];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
