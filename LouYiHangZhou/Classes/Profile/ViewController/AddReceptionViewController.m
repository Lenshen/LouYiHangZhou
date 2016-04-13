//
//  AddReceptionViewController.m
//  LouYiHangZhou
//
//  Created by 远深 on 16/4/11.
//  Copyright © 2016年 Luo Yi TECHNOLOGY. All rights reserved.
//

#import "AddReceptionViewController.h"
#import "CityViewController.h"
#import "AddressPick/AddressPickView.h"

@interface AddReceptionViewController ()
@property (strong, nonatomic) IBOutlet UIButton *cityButton;

@end

@implementation AddReceptionViewController
- (IBAction)black:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)getCity:(id)sender {
    AddressPickView *addressPickView = [AddressPickView shareInstance];
    [self.view addSubview:addressPickView];
    addressPickView.block = ^(NSString *province,NSString *city,NSString *town){
        NSString *str = [NSString stringWithFormat:@"%@ %@ %@",province,city,town] ;
        NSLog(@"%@",str);
        [_cityButton setTitle:str forState:UIControlStateNormal];
        
    };

    
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
