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

@interface AddReceptionViewController ()
@property (weak, nonatomic) IBOutlet UIButton *cityButton;
@property (strong, nonatomic) CLGeocoder *geocoder;
@property (weak, nonatomic) NSString *longitude;
@property (weak, nonatomic) NSString *latitude;


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
        [self geocoderPostalCode:str];
        
    };

    
}
-(NSString *)geocoderPostalCode:(NSString *)address
{
    [self.geocoder geocodeAddressString:@"安徽六安金安区" completionHandler:^(NSArray *placemarks, NSError *error) {
        //如果有错误信息，或者是数组中获取的地名元素数量为0，那么说明没有找到
        if (error || placemarks.count==0) {
            NSLog(@"%@",error);
        }else   //  编码成功，找到了具体的位置信息
        {
            //打印查看找到的所有的位置信息
            /*
             name:名称
             locality:城市
             country:国家
             postalCode:邮政编码
             */
            for (CLPlacemark *placemark in placemarks) {
                NSLog(@"name=%@ locality=%@ country=%@ postalCode=%@",placemark.name,placemark.locality,placemark.country,placemark.postalCode);
            }
            
            //取出获取的地理信息数组中的第一个显示在界面上
            CLPlacemark *firstPlacemark=[placemarks firstObject];
            //详细地址名称
            //纬度
            CLLocationDegrees latitude=firstPlacemark.location.coordinate.latitude;
            //经度
            CLLocationDegrees longitude=firstPlacemark.location.coordinate.longitude;
            self.latitude = [NSString stringWithFormat:@"%.2f",latitude];
            self.longitude = [NSString stringWithFormat:@"%.2f",longitude];
            NSLog(@"%f%f",longitude,latitude);
           
        }
    }];

    return nil;
}


-(CLGeocoder *)geocoder
{
    if (_geocoder==nil) {
        _geocoder=[[CLGeocoder alloc]init];
    }
    return _geocoder;
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
