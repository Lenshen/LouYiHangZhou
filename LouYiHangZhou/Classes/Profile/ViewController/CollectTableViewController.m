//
//  CollectTableViewController.m
//  LouYiHangZhou
//
//  Created by 远深 on 16/4/11.
//  Copyright © 2016年 Luo Yi TECHNOLOGY. All rights reserved.
//

#import "CollectTableViewController.h"
#import "CollectTableViewCell.h"
#import "BYSHttpTool.h"
#import <MJRefresh.h>
#import "SVProgressHUD.h"
#import "CollectionModel.h"
#import "SearhDetailViewController.h"
#import "UIImageView+WebCache.h"
#import "BYSHttpTool.h"
#import "HttpParameters.h"
@interface CollectTableViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) CollectionModel *model;
@property (strong, nonatomic) NSMutableArray *modelmutoArray;
@property (strong, nonatomic) UILabel *label;

@end

@implementation CollectTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.frame = [UIScreen mainScreen].bounds;
    
    self.edgesForExtendedLayout = UIRectEdgeNone;

//    [self setupMJRefreshHeader];
}

//- (void)setupMJRefreshHeader {
//    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(LoadNewData)];
//    self.tableView.mj_header.automaticallyChangeAlpha = YES;
//    [self.tableView.mj_header beginRefreshing];
//   
//    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(LoadMoreData)];
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)LoadNewData {
        [SVProgressHUD show];
        NSString *str2 = [USER_DEFAULT objectForKey:@"user_token"];
        NSDictionary *dic = @{@"access_token":str2};
        [BYSHttpTool GET:APP_FAVORITE_LIST Parameters:dic  Success:^(id responseObject) {
            NSLog(@"%@",responseObject);
            NSArray *array = responseObject[@"data"];
            
        
            _modelmutoArray = [NSMutableArray array];

            for (NSInteger i = 0; i < array.count; i++) {
                  _model = [[CollectionModel alloc]initWithDictionary:array[i] error:nil];

                [_modelmutoArray addObject:_model];
                NSLog(@"%@",_modelmutoArray);
                [self.tableView reloadData];

            }
            
            if (self.modelmutoArray.count == 0 || self.modelmutoArray == nil || [self.modelmutoArray isKindOfClass:[NSNull class]]) {
                
                _label = [[UILabel alloc]initWithFrame:CGRectMake(self.view.center.x-50, self.view.center.y-50, 100, 50)];
                _label.text = @"暂无数据";
                _label.font =[UIFont systemFontOfSize:15];
                _label.textAlignment = NSTextAlignmentCenter;
                [self.tableView addSubview:_label];
            }else
            {
                [_label removeFromSuperview];
            }

            [SVProgressHUD dismiss];

            
         
        } Failure:^(NSError *error) {
            NSLog(@"%@",error);
            [self.tableView.mj_header endRefreshing];
            [SVProgressHUD showErrorWithStatus:@"服务器未响应,请稍候再试..."];

        }
         ];
}
-(void)LoadMoreData
{
    NSString *str = @"http://192.168.0.103:7021/api/favorite/list";
    NSString *str2 = [USER_DEFAULT objectForKey:@"user_token"];
    NSDictionary *dic = @{@"access_token":str2};
    [BYSHttpTool GET:str Parameters:dic  Success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        
        
        [self.tableView.mj_header endRefreshing];
        
    } Failure:^(NSError *error) {
        NSLog(@"%@",error);
        [self.tableView.mj_header endRefreshing];
        [SVProgressHUD showErrorWithStatus:@"服务器未响应,请稍候再试..."];
        
    }
     ];

}
#pragma mark - Table view data source

- (IBAction)black:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self deleteTableviewCell:indexPath.row];
        [self.modelmutoArray removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}


-(void)deleteTableviewCell:(NSInteger)index;
{
    
    _model = self.modelmutoArray[index];
    NSLog(@"///%@",_model.goods_id);


    
    [BYSHttpTool POST:APP_FAVORITE_REMOVE Parameters:[HttpParameters delete_collectionAddress_id:_model.goods_id] Success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        
    } Failure:^(NSError *error) {
        
    }];
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)ind
{
    return @"删除";
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _modelmutoArray.count;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SearhDetailViewController *goodsDetail = [[SearhDetailViewController  alloc]init];
    _model = _modelmutoArray[indexPath.row];

    goodsDetail.indexName = _model.goods_id;
    [self.navigationController pushViewController:goodsDetail animated:YES];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CollectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CollectTableViewCell" forIndexPath:indexPath];
    _model = _modelmutoArray[indexPath.row];
    NSString *salePrice = [NSString stringWithFormat:@"¥%@", _model.sales_price];
    NSMutableAttributedString *markMutoAttributeSting = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"¥%@",_model.market_price]];
    [markMutoAttributeSting addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0,markMutoAttributeSting.length)];
    
    
    cell.goods_name.text = _model.goods_name;
    cell.market_price.attributedText = markMutoAttributeSting;
    cell.sales_price.text = salePrice;
   

    [cell.imageview sd_setImageWithURL:[NSURL URLWithString:_model.image]placeholderImage:nil options:0 completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        cell.imageview.image = image;
    }];
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = NO;
    [self LoadNewData];
    

    self.title = @"我的收藏";
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    self.navigationController.navigationBarHidden = YES;
    
}
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
