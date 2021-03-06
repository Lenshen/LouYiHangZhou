//
//  ProfileIMForViewController.m
//  LouYiHangZhou
//
//  Created by 远深 on 16/4/8.
//  Copyright © 2016年 Luo Yi TECHNOLOGY. All rights reserved.
//

#import "ProfileIMForViewController.h"
#import "UIView+Extension.h"
#import "ForgotPassWViewController.h"
#import "UIViewController+StoryboardFrom.h"
#import "UserImformationModel.h"
#import "UIButton+WebCache.h"
#import "BYSHttpTool.h"
#import "HttpParameters.h"
#import "SVProgressHUD.h"
#import "NSString+MD5.h"
#import <CommonCrypto/CommonCryptor.h>
#define LocalStr_None @""


@interface ProfileIMForViewController ()<UIPickerViewDataSource,UIPickerViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    UIImagePickerController *_imagePickerController;

}
@property (strong, nonatomic) IBOutlet UILabel *birthLabel;
@property (weak, nonatomic) IBOutlet UILabel *mobileLB;
@property (weak, nonatomic) IBOutlet UILabel *dateField;
@property (strong, nonatomic)NSString *dateString;
@property (weak, nonatomic) IBOutlet UIButton *headImage;
@property (weak, nonatomic) IBOutlet UILabel *sexLabel;
@property (strong, nonatomic)NSString *sexString;
@property (nonatomic,strong) NSMutableArray *yearArray;
@property (nonatomic, strong)UserImformationModel *useModel;
@property (nonatomic, strong)NSString *imageStr;
@property (nonatomic,strong) NSMutableArray *monthArray;

@property (nonatomic,strong) NSMutableArray *dayArray;
@property (nonatomic,strong) UIPickerView *pickview;
@property (nonatomic, strong) UIButton *canceButtonl;
@property (nonatomic, strong) UIButton *sureButton;
@property (nonatomic,assign) BOOL isLeapyear;//是否是闰年
@property (nonatomic,strong) UIView *viewp;
@property (nonatomic,strong) NSString *timesp;
@property (nonatomic,strong) NSString *timeOnly;


@end

@implementation ProfileIMForViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.yearArray = [NSMutableArray array];
    self.monthArray = [NSMutableArray array];
    self.dayArray = [NSMutableArray array];
    
    NSString *imagedata = [USER_DEFAULT objectForKey:@"avatar"];
    NSURL *url = [NSURL URLWithString:imagedata];
    [self.headImage sd_setBackgroundImageWithURL:url forState:UIControlStateNormal];
    self.headImage.layer.cornerRadius = 33;
    self.headImage.layer.masksToBounds = YES;



   
    [self getDateDataSource];
    [self initPickView];
    self.edgesForExtendedLayout = UIRectEdgeNone;
  




}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)changHeadImage:(id)sender {
    
    [self initHeadImageAlertController];
}
#pragma mark dianji
- (IBAction)sureAdd:(id)sender {
//    [self getdata];
    [SVProgressHUD showWithStatus:@"正在上传请稍等...."];
    if (self.imageStr) {
        [BYSHttpTool POST:APP_USER_UNLOAD_AVATAR Parameters:[HttpParameters uploadAvatar:_imageStr] Success:^(id responseObject) {
            NSLog(@"%@",responseObject);
            NSLog(@"%@",responseObject[@"data"]);
            [USER_DEFAULT setObject:responseObject[@"data"] forKey:@"avatar"];
            [SVProgressHUD showSuccessWithStatus:@"上传成功"];

        } Failure:^(NSError *error) {
            NSLog(@"%@",error);
           [SVProgressHUD dismiss];
        }];

    }
    self.sexString = self.sexLabel.text;
    self.timesp =[self transTotimeSp:self.birthLabel.text];

   
   
        
    
    if (self.sexString && self.timesp) {
        NSLog(@"%@",self.timesp);
        [BYSHttpTool POST:APP_USER_UPDATE Parameters:[HttpParameters uploadImformation:self.timesp sexStr:self.sexString] Success:^(id responseObject) {
            NSLog(@"%@",responseObject);
            
            [USER_DEFAULT setObject:self.timesp forKey:@"birth"];
            [USER_DEFAULT setObject:self.sexLabel.text forKey:@"sex"];
            NSLog(@"%@",responseObject[@"data"]);
            [SVProgressHUD showSuccessWithStatus:@"上传成功"];


        } Failure:^(NSError *error) {
            NSLog(@"%@",error);
            [SVProgressHUD showErrorWithStatus:@"缺少参数"];
        }];
    

    }
    


}


//- (void)getdata
//{
//    NSDictionary *jsondic = @{@"ShipperCode":@"STO",@"LogisticCode":@"3308347602249",@"AppKey":@"0f242821-3d28-431e-8890-005549ae2dfb"};
//
//    NSData *jsondata = [NSJSONSerialization dataWithJSONObject:jsondic options:NSJSONWritingPrettyPrinted error:nil];
//    
//
//    NSString *jsonstring = [[NSString alloc]initWithData:jsondata encoding:NSUTF8StringEncoding];
//
//
////    NSString *baseString1 = @"0f242821-3d28-431e-8890-005549ae2dfb";
//
////    NSString *baseString = [jsonstring stringByAppendingString:baseString1];
//
//
//
//    NSString *haveBaseString = [jsonstring md5];
////    NSData *data = [haveBaseString dataUsingEncoding:NSUTF8StringEncoding];
//    NSData *base64 = [jsondata base64EncodedDataWithOptions:0];
//    NSString *utf8base = [[NSString alloc]initWithData:base64 encoding:NSUTF8StringEncoding];
//    NSLog(@"%@----%@",haveBaseString,utf8base);
//
//    NSDictionary *dic = @{@"EBusinessID":@"1257984",@"RequestType":@"1002",@"RequestData":jsonstring,@"DataType":@"2",@"DataSign":@"Y2NmZmU5OGI3MjI2OWNiZTIwOWQyZDAxNzU5YjM4OWM="
//};
//    
//
//    [BYSHttpTool POST:@"http://api.kdniao.cc/Ebusiness/EbusinessOrderHandle.aspx" Parameters:dic Success:^(id responseObject) {
//        NSLog(@"%@",responseObject);
//
//
//
//    } Failure:^(NSError *error) {
//        NSLog(@"%@",error);
//        [SVProgressHUD showErrorWithStatus:@"缺少参数"];
//    }];
//
//
//}



- (IBAction)black:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 20;
    }else
        return 100;
    
}
#pragma mark tableview 点击
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 2) {
        [self initAlertController];
    }
    if (indexPath.section == 0 && indexPath.row == 1) {
        _sureButton.hidden = NO;
        _canceButtonl.hidden = NO;
        _viewp.hidden = NO;
        [self.view addSubview:_pickview];
        _pickview.hidden = NO;

    }else if(indexPath.section == 0 && indexPath.row == 3)
    {
        [self.navigationController pushViewController:[ForgotPassWViewController instanceFromStoryboard] animated:YES];
    }
}
-(void)initPickView
{
    
    
    _pickview = [[UIPickerView alloc]initWithFrame:CGRectZero];
    _pickview.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    _pickview.frame = CGRectMake(0, kScreenHeight-44-200-50,kScreenWidth, _pickview.height);
    _pickview.showsSelectionIndicator = YES;
    _pickview.backgroundColor = [UIColor whiteColor];
    _pickview.delegate = self;
    _pickview.dataSource = self;
    
    _viewp = [[UIView alloc]initWithFrame:CGRectMake(0,_pickview.origin.y-50, kScreenHeight,50 )];
    _viewp.backgroundColor = [UIColor grayColor];
    [self.view addSubview:_viewp];
    _canceButtonl = [[UIButton alloc]initWithFrame:CGRectMake(0,_pickview.origin.y-50, 50,50 )];
    [_canceButtonl addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    [_canceButtonl setTitle:@"取消" forState:UIControlStateNormal];
    _canceButtonl.backgroundColor =[UIColor redColor];
    
    [self.view addSubview:_canceButtonl];

    _sureButton = [[UIButton alloc]initWithFrame:CGRectMake(self.view.width-50,_pickview.origin.y-50, 50,50 )];
    [_sureButton setTitle:@"确定" forState:UIControlStateNormal];
    _sureButton.backgroundColor =[UIColor redColor];
    [_sureButton addTarget:self action:@selector(sure) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:_sureButton];
    _canceButtonl.hidden = YES;
    _sureButton.hidden = YES;
  
    
}
-(void)cancel
{
    _canceButtonl.hidden = YES;
    _sureButton.hidden = YES;
    _pickview.hidden = YES;
    _viewp.hidden = YES;
    
}
-(void)sure
{
    _canceButtonl.hidden = YES;
    _sureButton.hidden = YES;
    _pickview.hidden = YES;
    _viewp.hidden = YES;
    NSString *yearString = [self.yearArray objectAtIndex:[self.pickview selectedRowInComponent:0]];
    NSString *monthString = [self.monthArray objectAtIndex:[self.pickview selectedRowInComponent:1]];
    NSString *dayString = [self.dayArray objectAtIndex:[self.pickview selectedRowInComponent:2]];
    self.dateString = [NSString stringWithFormat:@"%@-%@-%@",yearString,monthString,dayString];
    
    NSString* timeStr = self.dateString;
    self.dateField.text = self.dateString;
    
    _timesp = [self transTotimeSp:timeStr];
    
    NSLog(@"%@  %@",timeStr,_timesp);
    

}

- (void)getDateDataSource{
    for (int i = 1970; i <= 9999; i++) {
        [self.yearArray addObject:[NSString stringWithFormat:@"%d",i]];
    }
    for (int i = 1; i<13; i++) {
        
        [self.monthArray addObject:[NSString stringWithFormat:@"%.2d",i]];
    }
    for (int i = 1; i<32; i++) {
        [self.dayArray addObject:[NSString stringWithFormat:@"%.2d",i]];
    }
    [self.pickview reloadAllComponents];
}


-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 3;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (component == 0)
        
        return self.yearArray.count;
    
    else if (component ==1)
        
        return self.monthArray.count;
    
    else
        return self.dayArray.count;
}


- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    if (component == 0) {
        if ((row+1970)%4==0) {
            self.isLeapyear = YES;
        }
        
        return [self.yearArray objectAtIndex:row];
        
    }
    else if (component == 1){
        if (self.isLeapyear) {
            if (row == 2) {
                
            }
        }
        
        return [self.monthArray objectAtIndex:row];
    }
    else if (component == 2)
        return [self.dayArray objectAtIndex:row];
    else
        return nil;
}

-(void)initHeadImageAlertController
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"相册或照相获取图片" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
    {
        
        [self openCamera];
        
    }];
    
    UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) \
    
    {
        
        [self openPhotoLibrary];
        
    }];
    
    UIAlertAction *archiveAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    
    [alertController addAction:cancelAction];
    [alertController addAction:deleteAction];
    [alertController addAction:archiveAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
}

-(void)openPhotoLibrary
{
    UIImagePickerController *impick = [[UIImagePickerController alloc]init];
    impick.delegate = self;
    impick.allowsEditing = YES;
    impick.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:impick animated:YES completion:nil];
    

    
}
- (void) openCamera
{
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *impick = [[UIImagePickerController alloc]init];
        impick.delegate = self;
        impick.allowsEditing = YES;
        impick.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:impick animated:YES completion:nil];
    }

    
}

//imagepickerdelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo {
    [self.headImage setBackgroundImage:editingInfo[UIImagePickerControllerEditedImage] forState:UIControlStateNormal];
    NSLog(@"%@",editingInfo);
    [picker dismissViewControllerAnimated:YES completion:^{
        NSLog(@"选照片");
    }];}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{

    UIImage *image = info[UIImagePickerControllerEditedImage];
    [self.headImage setBackgroundImage:image forState:UIControlStateNormal];
    self.headImage.layer.cornerRadius = 33;
    self.headImage.layer.masksToBounds = YES;
        [self dismissViewControllerAnimated:YES completion:nil];
  
  
    [self base64:image];
                         
   
    }


-(void)base64:(UIImage *)image
{
    NSData *imagedata = UIImageJPEGRepresentation(image, 1.0);
    NSString *imageStr = [imagedata base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    self.imageStr = imageStr;
    
}
#pragma mark viewViewAppear




-(void)initAlertController
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"请选择你的性别" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"男" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        _sexLabel.text = @"男";
        self.sexString = @"男";
    }];
    UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"女" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        _sexLabel.text = @"女";
        self.sexString = @"女";
    }];
    UIAlertAction *archiveAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:cancelAction];
    [alertController addAction:deleteAction];
    [alertController addAction:archiveAction];
    [self presentViewController:alertController animated:YES completion:nil];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    _viewp.hidden = YES;
    self.navigationController.navigationBarHidden = NO;
    self.title = @"个人信息";
    self.tableView.showsVerticalScrollIndicator = NO;
//    [self setNavigationBarType];
    
    NSString * timeStampString = [USER_DEFAULT objectForKey:@"birth"];
   
    
    
    self.mobileLB.text = [USER_DEFAULT objectForKey:@"mobile"];
    self.birthLabel.text = [self transTotime:timeStampString];
    self.sexLabel.text = [USER_DEFAULT objectForKey:@"sex"];
    
    

  
}
-(NSString *)transTotime:(NSString *)timeStampString
{
    NSTimeInterval _interval=[timeStampString doubleValue];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:_interval];
    NSLog(@"1296035591  = %@",confromTimesp);
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    
    return confromTimespStr;
}
-(NSString *)transTotimeSp:(NSString *)time{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]]; //设置本地时区
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSDate *date = [dateFormatter dateFromString:time];
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[date timeIntervalSince1970]];//时间戳
    return timeSp;
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    self.navigationController.navigationBarHidden = YES;
    
}
-(void)setNavigationBarType
{
    self.navigationController.navigationBar.translucent = YES;
    UIColor *color =[UIColor clearColor]
    ;
    CGRect rect = CGRectMake(0, 0, kScreenWidth, 64);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
}
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
@end
