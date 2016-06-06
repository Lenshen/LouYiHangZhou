//
//  ChangeReceptionViewController.m
//  进口零食
//
//  Created by 远深 on 16/4/29.
//  Copyright © 2016年 Luo Yi TECHNOLOGY. All rights reserved.
//

#import "ChangeReceptionViewController.h"
#import "AddressPickView.h"
#import "BYSHttpTool.h"
#import "HttpParameters.h"

@interface ChangeReceptionViewController ()
@property (weak, nonatomic) IBOutlet UITextField *full_nameTF;
@property (weak, nonatomic) IBOutlet UITextField *mobileTF;
@property (weak, nonatomic) IBOutlet UITextField *detailAddressTF;
@property (weak, nonatomic) IBOutlet UIButton *addressButton;
@property BOOL is_default;
@property (weak, nonatomic) IBOutlet UIButton *is_defaultButton;
@property (weak, nonatomic) NSString *province;
@property (weak, nonatomic) NSString *city;
@property (weak, nonatomic) NSString *area;
@property (weak, nonatomic) NSString *isDefault;
@property (weak, nonatomic) NSString *address_id;


@end

@implementation ChangeReceptionViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@",_model);
    // Do any additional setup after loading the view.
    _full_nameTF.text = _model.full_name;
    
    _mobileTF.text = _model.mobile;
    
    _detailAddressTF.text = _model.address;
    
    self.address_id = _model.address_id;
    
    NSString *string = [NSString stringWithFormat:@"%@ %@ %@",_model.province,_model.city,_model.area];
    
    [_addressButton setTitle:string forState:UIControlStateNormal];
    _is_default = NO;
    
    if (self.province == nil) {
        self.province = @"湖南省";
        self.city = @"湘潭市";
        self.area = @"雨湖区";
    }
 
    
    
}

- (IBAction)save:(id)sender {
    if (_is_default) {
        self.isDefault = @"true";
    }else
    {
        self.isDefault = @"false";
    }
    
    
    NSLog(@"%@   -----%@",self.address_id,self.isDefault);
    
    
    
 
    
    [BYSHttpTool POST:APP_ADDRESS_UPDATE Parameters:[HttpParameters update_address:self.detailAddressTF.text country:nil province:self.province city:self.city area:self.area address:self.detailAddressTF.text zip:nil full_name:self.full_nameTF.text tel:nil mobile:self.mobileTF.text is_default:self.isDefault address_id:self.address_id] Success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        
        [self.navigationController popViewControllerAnimated:YES];
        
    } Failure:^(NSError *error) {
        
        
    NSLog(@"%@",error);
    }];
    
}
- (IBAction)isDefault:(id)sender {
    

    _is_defaultButton.selected =!_is_defaultButton.selected;
    
    self.is_default = _is_defaultButton.selected;
    
   
}




- (IBAction)getCity:(id)sender {
    AddressPickView *addressPickView = [AddressPickView shareInstance];
    [self.view addSubview:addressPickView];
    addressPickView.block = ^(NSString *province,NSString *city,NSString *town){
        NSString *str = [NSString stringWithFormat:@"%@ %@ %@",province,city,town] ;
        self.province  = province;
        self.city = city;
        self.area = town;
       
    [_addressButton setTitle:str forState:UIControlStateNormal];
        
    };
    
    
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
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
