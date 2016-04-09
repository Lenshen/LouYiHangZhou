//
//  ProfileViewController.m
//  LouYiHangZhou
//
//  Created by 远深 on 16/4/8.
//  Copyright © 2016年 Luo Yi TECHNOLOGY. All rights reserved.
//

#import "ProfileViewController.h"

#import "ProfileCollectionViewCell.h"

#import "ProfileIMForViewController.h"

#import "UIViewController+StoryboardFrom.h"
@interface ProfileViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (strong, nonatomic) IBOutlet UILabel *mobileNumbel;
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSArray *imagesArray;
@property (strong, nonatomic) IBOutlet UIButton *headImage;
@property (strong, nonatomic) NSArray *lableArray;
@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self imagesArray];
    [self lableArray];
        
}
-(void)viewWillAppear:(BOOL)animated
{
    NSData *imageData = [USER_DEFAULT objectForKey:@"headImage"];
    if (imageData) {
        UIImage *image = [NSKeyedUnarchiver unarchiveObjectWithData:imageData];
        [self.headImage setBackgroundImage:image forState:UIControlStateNormal];
        self.headImage.layer.cornerRadius = 35;
        self.headImage.layer.masksToBounds = YES;
        
    }

}
-(NSArray *)imagesArray
{
    if (!_imagesArray) {
        _imagesArray = [NSArray arrayWithObjects:[UIImage imageNamed:@"个人订单"],[UIImage imageNamed:@"个人待支付"],[UIImage imageNamed:@"个人待收货"],[UIImage imageNamed:@"个人待评价"], nil];
    }
    return _imagesArray;
}
-(NSArray *)lableArray
{
    if (!_lableArray) {
        _lableArray = [NSArray arrayWithObjects:@"全部订单",@"待支付",@"待收货",@"待评价", nil];
    }
    return _lableArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 &&indexPath.row == 1) {
        [self.navigationController pushViewController:[ProfileIMForViewController instanceFromStoryboard] animated:YES];
    }else if(indexPath.section == 0 &&indexPath.row == 4)
    {
        [self cellMobiel:self.mobileNumbel.text];
    }
}
-(void)cellMobiel:(NSString *)mobielNumbel
{
    NSMutableString *Str =[[NSMutableString alloc]initWithFormat:@"tel:%@",mobielNumbel];
    UIWebView *webview = [[UIWebView alloc]init];
    [webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:Str]]];
    [self.view addSubview:webview];
}
-(NSInteger )collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 4;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ProfileCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"profileCollectionCell" forIndexPath:indexPath];
    cell.imageView.image = _imagesArray[indexPath.row];
    cell.label.text = _lableArray[indexPath.row];
    
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    return CGSizeMake(self.view.frame.size.width/3.99999,self.collectionView.frame.size.height) ;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 20;
    }else
        return 100;
    
}



@end
