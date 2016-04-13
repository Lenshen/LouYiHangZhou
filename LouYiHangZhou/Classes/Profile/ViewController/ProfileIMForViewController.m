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

@interface ProfileIMForViewController ()<UIPickerViewDataSource,UIPickerViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    UIImagePickerController *_imagePickerController;

}
@property (strong, nonatomic) IBOutlet UILabel *birthLabel;
@property (weak, nonatomic) IBOutlet UILabel *mobileLB;
@property (weak, nonatomic) IBOutlet UILabel *dateField;
@property (weak, nonatomic) IBOutlet UIButton *headImage;
@property (weak, nonatomic) IBOutlet UILabel *sexLabel;
@property (nonatomic,strong) NSMutableArray *yearArray;
@property (nonatomic, strong)UserImformationModel *useModel;

@property (nonatomic,strong) NSMutableArray *monthArray;

@property (nonatomic,strong) NSMutableArray *dayArray;
@property (nonatomic,strong) UIPickerView *pickview;
@property (nonatomic, strong) UIButton *canceButtonl;
@property (nonatomic, strong) UIButton *sureButton;
@property (nonatomic,assign) BOOL isLeapyear;//是否是闰年


@end

@implementation ProfileIMForViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.yearArray = [NSMutableArray array];
    self.monthArray = [NSMutableArray array];
    self.dayArray = [NSMutableArray array];
   
    [self getDateDataSource];
    [self initPickView];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    _useModel = [UserImformationModel sharedManager];
    self.mobileLB.text = [USER_DEFAULT objectForKey:@"userName"];
    self.sexLabel.text = [USER_DEFAULT objectForKey:@"sex"];
    self.birthLabel.text = [USER_DEFAULT objectForKey:@"birth"];




}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)changHeadImage:(id)sender {
    
    [self initHeadImageAlertController];
}
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
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 3) {
        [self initAlertController];
    }
    if (indexPath.section == 0 && indexPath.row == 2) {
        _sureButton.hidden = NO;
        _canceButtonl.hidden = NO;
        [self.view addSubview:_pickview];
        _pickview.hidden = NO;

    }else if(indexPath.section == 0 && indexPath.row == 4)
    {
        [self.navigationController pushViewController:[ForgotPassWViewController instanceFromStoryboard] animated:YES];
    }
}
-(void)initPickView
{
    _pickview = [[UIPickerView alloc]initWithFrame:CGRectMake(0, self.view.height-44-200-50,_pickview.width, _pickview.height)];
    _pickview.backgroundColor = [UIColor whiteColor];
    _pickview.delegate = self;
    _pickview.dataSource = self;
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
}
-(void)sure
{
    _canceButtonl.hidden = YES;
    _sureButton.hidden = YES;
    _pickview.hidden = YES;
    NSString *yearString = [self.yearArray objectAtIndex:[self.pickview selectedRowInComponent:0]];
    NSString *monthString = [self.monthArray objectAtIndex:[self.pickview selectedRowInComponent:1]];
    NSString *dayString = [self.dayArray objectAtIndex:[self.pickview selectedRowInComponent:2]];
    self.dateField.text = [NSString stringWithFormat:@"%@-%@-%@",yearString,monthString,dayString];
       [self.view endEditing:NO];

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
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            UIImagePickerController *impick = [[UIImagePickerController alloc]init];
            impick.delegate = self;
            impick.allowsEditing = YES;
            impick.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:impick animated:YES completion:nil];
        }
    }];
    
    UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerController *impick = [[UIImagePickerController alloc]init];
        impick.delegate = self;
        impick.allowsEditing = YES;
        impick.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:impick animated:YES completion:nil];

    }];
    UIAlertAction *archiveAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:cancelAction];
    [alertController addAction:deleteAction];
    [alertController addAction:archiveAction];
    [self presentViewController:alertController animated:YES completion:nil];
    
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo {
    [self.headImage setBackgroundImage:editingInfo[UIImagePickerControllerEditedImage] forState:UIControlStateNormal];
    NSLog(@"%@",editingInfo);
    [picker dismissViewControllerAnimated:YES completion:^{
        NSLog(@"选照片");
    }];}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    NSString *mediaType=[info objectForKey:UIImagePickerControllerMediaType];
    //判断资源类型
//    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]){
//        //如果是图片
//        self.imageView.image = info[UIImagePickerControllerEditedImage];
//        //压缩图片
//        NSData *fileData = UIImageJPEGRepresentation(self.imageView.image, 1.0);
//        //保存图片至相册
//        UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
//        //上传图片
        [self dismissViewControllerAnimated:YES completion:nil];
    NSData *imageData = [NSKeyedArchiver archivedDataWithRootObject:info[UIImagePickerControllerEditedImage]];
                         
    [USER_DEFAULT setObject:imageData forKey:@"headImage"];
   
    }


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    NSData *imagedata = [USER_DEFAULT objectForKey:@"headImage"];
    if (imagedata) {
        UIImage *iamge = [NSKeyedUnarchiver unarchiveObjectWithData:imagedata];
        [self.headImage setBackgroundImage:iamge forState:UIControlStateNormal];
        self.headImage.layer.cornerRadius = 33;
        self.headImage.layer.masksToBounds = YES;

    }
}


-(void)initAlertController
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"请选择你的性别" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"男" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        _sexLabel.text = @"男";
    }];
    UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"女" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        _sexLabel.text = @"女";
    }];
    UIAlertAction *archiveAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:cancelAction];
    [alertController addAction:deleteAction];
    [alertController addAction:archiveAction];
    [self presentViewController:alertController animated:YES completion:nil];
}


@end
