//
//  ReceptionTableViewController.m
//  LouYiHangZhou
//
//  Created by 远深 on 16/4/11.
//  Copyright © 2016年 Luo Yi TECHNOLOGY. All rights reserved.
//

#import "ReceptionTableViewController.h"
#import "ReceptionTableViewCell.h"
#import "BYSHttpTool.h"
#import "HttpParameters.h"
#import "AddressModel.h"
#import "SVProgressHUD.h"
#import "NSString+MD5.h"
#import "NavigationViewController.h"
#import "ChangeReceptionViewController.h"
#import "UIViewController+StoryboardFrom.h"
#import "WebViewJSBridge.h"
#import "AddReceptionViewController.h"

@interface ReceptionTableViewController ()<UITableViewDataSource,UITableViewDelegate,OpenWebviewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) AddressModel *model;
@property (nonatomic,strong)NSMutableArray *addressArrayM;
@property (nonatomic, strong) UILabel *label;

@end

@implementation ReceptionTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.edgesForExtendedLayout = UIRectEdgeNone;
  
    
    
    
  
    

}


-(void)getAddress
{
    
    [SVProgressHUD show];
    
    NSDictionary *dic = [HttpParameters app_get_userImformation:nil];
    NSLog(@"%@",dic);

    [BYSHttpTool GET:APP_ADDRESS_GET Parameters:[HttpParameters app_get_userImformation:nil ] Success:^(id responseObject) {
        NSArray *array = responseObject[@"data"];

        self.addressArrayM = [NSMutableArray arrayWithArray:array];
        NSLog(@"%@ -----response==%@",_addressArrayM,responseObject);
        
        if (self.addressArrayM.count == 0 || self.addressArrayM == nil || [self.addressArrayM isKindOfClass:[NSNull class]]) {
            
           
                _label = [[UILabel alloc]initWithFrame:CGRectMake(self.view.center.x-50, self.view.center.y-50, 100, 50)];
          
                _label.text = @"暂无数据";
                _label.font =[UIFont systemFontOfSize:15];
                _label.textAlignment = NSTextAlignmentCenter;
                [self.tableView addSubview:_label];

                
         
        }
        [SVProgressHUD dismiss];
        [self.tableView reloadData];
        
        
        
    } Failure:^(NSError *error) {
        NSString *message = @"服务器未响应";
        [message alert:message viewcontroller:self];
        [SVProgressHUD dismiss];
    }];
}
-(void)viewWillAppear:(BOOL)animated
{
   
    self.navigationController.navigationBarHidden = NO;
    self.title = @"收货地址";
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    
    [_label removeFromSuperview];

    [self getAddress];

//    NavigationViewController *nav = (NavigationViewController *)self.navigationController;
//    [nav setAlph];
   

}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    self.navigationController.navigationBarHidden = YES;
    
}
- (IBAction)black:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
        return self.addressArrayM.count;


}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    ReceptionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReceptionTableViewCell" forIndexPath:indexPath];
    NSDictionary *dic = self.addressArrayM[indexPath.row];
    _model = [[AddressModel alloc]initWithDictionary:dic error:nil];
    NSLog(@"%@",_model);
    NSString *address = [NSString stringWithFormat:@"%@%@%@%@",_model.province,_model.city,_model.area,_model.address];
    if (_model.is_default) {
        NSMutableAttributedString *mutoString = [[NSMutableAttributedString alloc]initWithString:[NSString  stringWithFormat:@"[默认]%@",address]];
        [mutoString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0,4)];
        cell.addressLable.attributedText = mutoString;
        cell.hideView.hidden = NO;
    }
    else
    {
        cell.addressLable.text = address;
        cell.hideView.hidden = YES;

    }
   
    cell.full_nameLable.text = _model.full_name;
    cell.mobileLable.text = _model.mobile;
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChangeReceptionViewController *changeReceptionVC = [ChangeReceptionViewController instanceFromStoryboard];
    NSDictionary *dic = self.addressArrayM[indexPath.row];
    _model = [[AddressModel alloc]initWithDictionary:dic error:nil];
    changeReceptionVC.model = self.model;
    [self.navigationController pushViewController:changeReceptionVC animated:YES];
    
}
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self deleteTableviewCell:indexPath.row];
        [self.addressArrayM removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];


        [self.tableView reloadData];
        
    }
    
}
-(void)deleteTableviewCell:(NSInteger )index;
{
    
    NSDictionary *dic = self.addressArrayM[index];
    
    [BYSHttpTool POST:APP_ADDRESS_DELETE Parameters:[HttpParameters delete_address:nil address_id:dic[@"address_id"]] Success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        
    } Failure:^(NSError *error) {
        
    }];
}


-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
