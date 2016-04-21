//
//  ProfileViewController.m
//  LouYiHangZhou
//
//  Created by 远深 on 16/4/8.
//  Copyright © 2016年 Luo Yi TECHNOLOGY. All rights reserved.
//

#import "ProfileViewController.h"
#import "MessageTableViewController.h"
#import "CouponViewController.h"
#import "LogonVViewController.h"
#import "UIButton+WebCache.h"
#import "OrderStatusViewController.h"

#import "ProfileCollectionViewCell.h"

#import "ProfileIMForViewController.h"

#import "UIViewController+StoryboardFrom.h"

#import "ReceptionTableViewController.h"

#import "CollectTableViewController.h"
@interface ProfileViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UITableViewDelegate>
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
    self.tableView.contentOffset = CGPointMake(0, 0);
    NSData *imageData = [USER_DEFAULT objectForKey:@"headImage"];
    if (imageData) {
        UIImage *image = [NSKeyedUnarchiver unarchiveObjectWithData:imageData];
        [self.headImage setBackgroundImage:image forState:UIControlStateNormal];
        self.headImage.layer.cornerRadius = 35;
        self.headImage.layer.masksToBounds = YES;
        
    }
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    
        
}
#pragma mark 点击跳转
- (IBAction)ProsonIMFor:(id)sender {
    
    if ([USER_DEFAULT objectForKey:@"user_token"]) {
        ProfileIMForViewController *p = [ProfileIMForViewController instanceFromStoryboard];
        p.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:p animated:YES];
    }else
    {
        LogonVViewController *Logon = [LogonVViewController instanceFromStoryboard];
        Logon.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:Logon animated:YES];
    }
}


#pragma mark viewVillAppear
-(void)viewWillAppear:(BOOL)animated
{
  self.navigationController.navigationBarHidden = YES;
    NSURL *url = [NSURL URLWithString:[USER_DEFAULT objectForKey:@"avatar"]];
    [self.headImage sd_setBackgroundImageWithURL:url forState:UIControlStateNormal];
    self.headImage.layer.cornerRadius =  self.headImage.frame.size.width/2;
    self.headImage.layer.masksToBounds = YES;
                  
    
    

}
//kkdkdk
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
        UIViewController *v2 = [ReceptionTableViewController instanceFromStoryboard];
        v2.hidesBottomBarWhenPushed = YES;

        [self.navigationController pushViewController:v2 animated:YES];
    }else if(indexPath.section == 0 &&indexPath.row == 4)
    {
        [self cellMobiel:self.mobileNumbel.text];
    }else if(indexPath.row == 0 && indexPath.section == 0)
    {
        UITableViewController *tab = [CollectTableViewController instanceFromStoryboard];
        tab.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:tab animated:YES];
    }else if(indexPath.row == 2 && indexPath.section == 0)
    {
        UITableViewController *tab = [MessageTableViewController instanceFromStoryboard];
        tab.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:tab animated:YES];
    }else if (indexPath.row == 3 && indexPath.section == 0)
    {
        CouponViewController *coupon = [[CouponViewController alloc]init];
        coupon.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:coupon animated:YES];
    }
    


}
//jj
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

#pragma mark 点击订单状态
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *array = [NSArray arrayWithObjects:@"orders",@"order-confirm",@"order-detail",@"goods",nil];
 
        OrderStatusViewController *order = [[OrderStatusViewController alloc]init];
    order.indexName = array[indexPath.row];


    [self.navigationController pushViewController:order animated:YES];

    

    
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
