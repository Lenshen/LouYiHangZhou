//
//  ProfileIMForViewController.m
//  LouYiHangZhou
//
//  Created by 远深 on 16/4/8.
//  Copyright © 2016年 Luo Yi TECHNOLOGY. All rights reserved.
//

#import "ProfileIMForViewController.h"

@interface ProfileIMForViewController ()<UIPickerViewDataSource,UIPickerViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    UIImagePickerController *_imagePickerController;

}
@property (strong, nonatomic) IBOutlet UIButton *headImage;
@property (strong, nonatomic) IBOutlet UILabel *sexLabel;
@property (nonatomic,strong) NSMutableArray *yearArray;

@property (nonatomic,strong) NSMutableArray *monthArray;

@property (nonatomic,strong) NSMutableArray *dayArray;
@property (nonatomic,strong) UIPickerView *pickview;

@end

@implementation ProfileIMForViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
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
        [self initPickView];
    }
}
-(void)initPickView
{
   
    
    
    
}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 3;
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


-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (component == 0)
        
        return self.yearArray.count;
    
    else if (component ==1)
        
        return self.monthArray.count;
    
    else
        return self.dayArray.count;
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
    [self.headImage setImage:editingInfo[UIImagePickerControllerEditedImage] forState:UIControlStateNormal]; 
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
    [self.headImage setImage:info[UIImagePickerControllerEditedImage] forState:UIControlStateNormal];

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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
