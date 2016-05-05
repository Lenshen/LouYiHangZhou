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


@interface ProfileViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UITableViewDelegate,UIWebViewDelegate>
{
    BOOL isLogoin;
}
@property (weak, nonatomic) IBOutlet UIView *hideview;
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
    //
    self.tableView.contentOffset = CGPointMake(0, 0);
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(pushLogonVViewController:) name:@"LogonVViewController" object:nil];
    
    

    

    
}



-(void)pushLogonVViewController:(NSNotification *)notification
{
    NSDictionary *dic = notification.userInfo;
    NSString *push = dic[@"LogonVViewController"];
    
    if ([push isEqualToString:@"LogonVViewController"]) {
        [self.navigationController pushViewController:[LogonVViewController instanceFromStoryboard] animated:YES];
    }
}
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:YES];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"LogonVViewController" object:nil];
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
#pragma mark 点击跳转

- (IBAction)ProsonIMFor:(id)sender {

    
    if (isLogoin) {
        ProfileIMForViewController *p = [ProfileIMForViewController instanceFromStoryboard];
        self.hideview.hidden = NO;
        p.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:p animated:YES];
    }else
    {
        self.hideview.hidden = YES;
        LogonVViewController *Logon = [LogonVViewController instanceFromStoryboard];
        Logon.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:Logon animated:YES];
    }
}


#pragma mark viewVillAppear
-(void)viewWillAppear:(BOOL)animated
{
    
    isLogoin = [USER_DEFAULT objectForKey:@"user_token"];
    

    if ([USER_DEFAULT objectForKey:@"user_token"]) {
 
        self.hideview.hidden = NO;
    }else
    {
        self.hideview.hidden = YES;
    }
    
    self.navigationController.navigationBarHidden = YES;
    NSURL *url = [NSURL URLWithString:[USER_DEFAULT objectForKey:@"avatar"]];
    [self.headImage sd_setBackgroundImageWithURL:url forState:UIControlStateNormal];
    self.mobileNumbel.text = [USER_DEFAULT objectForKey:@"mobile"];
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
    
    if (indexPath.section == 0 &&indexPath.row == 1  && isLogoin) {
        UIViewController *v2 = [ReceptionTableViewController instanceFromStoryboard];
        v2.hidesBottomBarWhenPushed = YES;

        [self.navigationController pushViewController:v2 animated:YES];
    }else if(indexPath.section == 0 && indexPath.row == 1)
    {
        [self.navigationController pushViewController:[LogonVViewController instanceFromStoryboard] animated:YES];
    }
    
    
     if(indexPath.section == 0 &&indexPath.row == 4)
    {
        [self cellMobiel:@"400-800-67672"];
    }
        
    
    
    
    
      if(indexPath.row == 0 && indexPath.section == 0 && isLogoin)
    {
        UIViewController *tab = [CollectTableViewController instanceFromStoryboard];
        tab.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:tab animated:YES];
        
    }else if(indexPath.row == 0 && indexPath.section == 0)
        
    {
        [self.navigationController pushViewController:[LogonVViewController instanceFromStoryboard] animated:YES];

    }
    
    
    
    
    if(indexPath.row == 2 && indexPath.section == 0 && isLogoin)
    {
        UITableViewController *tab = [MessageTableViewController instanceFromStoryboard];
        tab.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:tab animated:YES];
    }else if(indexPath.row == 2 && indexPath.section == 0)
        
    {
        [self.navigationController pushViewController:[LogonVViewController instanceFromStoryboard] animated:YES];
    }
    
    
    
    if (indexPath.row == 3 && indexPath.section == 0 && isLogoin)
    {
        CouponViewController *coupon = [[CouponViewController alloc]init];
        coupon.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:coupon animated:YES];
    }else if(indexPath.row == 3 && indexPath.section == 0 )
    {
        [self.navigationController pushViewController:[LogonVViewController instanceFromStoryboard] animated:YES];

    }
    


}


-(void)cellMobiel:(NSString *)mobielNumbel
{
    NSMutableString *Str =[[NSMutableString alloc]initWithFormat:@"tel:%@",mobielNumbel];
    UIWebView *webview = [[UIWebView alloc]init];
    [webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:Str]]];
    [self.view addSubview:webview];
}


#pragma mark 点击订单状态
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *array = [NSArray arrayWithObjects:@"0",@"10",@"80",@"15",nil];
 
        OrderStatusViewController *order = [[OrderStatusViewController alloc]init];
    order.indexName = array[indexPath.row];
    if (isLogoin) {
        [self.navigationController pushViewController:order animated:YES];

    }else
    {
        [self.navigationController pushViewController:[LogonVViewController instanceFromStoryboard] animated:YES];

    }
    

    
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
