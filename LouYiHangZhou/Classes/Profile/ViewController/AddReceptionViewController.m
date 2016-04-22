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
#import <CoreLocation/CoreLocation.h>
#import "BYSHttpTool.h"
#import "HttpParameters.h"

@interface AddReceptionViewController ()
@property (weak, nonatomic) IBOutlet UITextField *address;
@property (weak, nonatomic) IBOutlet UIButton *cityButton;
@property (weak, nonatomic) IBOutlet UITextField *mobile;
@property (weak, nonatomic) IBOutlet UITextField *full_name;
@property (weak, nonatomic) NSString *longitude;
@property (weak, nonatomic) NSString *latitude;
@property (weak, nonatomic) NSString *province;
@property (weak, nonatomic) NSString *city;
@property (weak, nonatomic) NSString *area;





@end

@implementation AddReceptionViewController
- (IBAction)black:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)sureAddButton:(id)sender {
    
    [BYSHttpTool POST:@"http://192.168.0.103:7021/api/address/add" Parameters:[HttpParameters add_address:_address.text country:nil province:self.province city:self.city area:self.area address:self.address.text zip:nil full_name:_full_name.text tel:nil mobile:_mobile.text is_default:@"yes"] Success:^(id responseObject) {
        NSLog(@"%@",responseObject);

        [self.navigationController popViewControllerAnimated:YES];
    } Failure:^(NSError *error) {
        NSLog(@"%@",error);
        

    }];
    
    
}
- (IBAction)getCity:(id)sender {
    AddressPickView *addressPickView = [AddressPickView shareInstance];
    [self.view addSubview:addressPickView];
    addressPickView.block = ^(NSString *province,NSString *city,NSString *town){
        NSString *str = [NSString stringWithFormat:@"%@ %@ %@",province,city,town] ;
        self.province  = province;
        self.city = city;
        self.area = town;
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
