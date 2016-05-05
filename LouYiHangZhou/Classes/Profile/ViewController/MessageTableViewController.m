//
//  MessageTableViewController.m
//  LouYiHangZhou
//
//  Created by 远深 on 16/4/11.
//  Copyright © 2016年 Luo Yi TECHNOLOGY. All rights reserved.
//

#import "MessageTableViewController.h"
#import "MessageTableViewCell.h"
#import "HttpParameters.h"
#import "BYSHttpTool.h"
#import "MessageModel.h"
#import "SVProgressHUD.h"
#import <MJRefresh.h>
#import "DatailMessageViewController.h"



@interface MessageTableViewController ()
@property (nonatomic, strong)MessageModel *model;
@property (strong, nonatomic) IBOutlet UITableView *tableview;

@property (nonatomic, strong)NSMutableArray *messageMArray;

@property BOOL is_read;
@end

@implementation MessageTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self setupMJRefreshHeader];
    self.tableview.tableFooterView.hidden = YES;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)setupMJRefreshHeader {
//    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(LoadNewData)];
//    self.tableView.mj_header.automaticallyChangeAlpha = YES;
//    [self.tableView.mj_header beginRefreshing];
    
    self.tableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(LoadMoreData)];

}


-(void)LoadMoreData
{
   
    NSInteger i = 1;
    i++;
    NSString *index = [NSString stringWithFormat:@"%ld",i];

    [BYSHttpTool GET:APP_USER_GETMESSAGE Parameters:[HttpParameters app_user_getMessagesPageindex:index]  Success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        NSArray *array  = responseObject[@"data"];
        [self.tableView.mj_header endRefreshing];
        for (NSInteger i = 0;i < array.count; i++) {
            _model = [[MessageModel alloc]initWithDictionary:array[i] error:nil];
            [_messageMArray addObject:_model];
            [self.tableView reloadData];
            NSInteger count = [responseObject[@"record_count"] integerValue];
            if (self.messageMArray.count == count) {
                self.tableview.tableFooterView.hidden = NO;
                [self.tableview.mj_footer endRefreshingWithNoMoreData];
            }
          
            
        }
        [self.tableview reloadData];
        
    } Failure:^(NSError *error) {
        NSLog(@"%@",error);
        [self.tableView.mj_header endRefreshing];
//        [SVProgressHUD showErrorWithStatus:@"服务器未响应,请稍候再试..."];
        
    }
     ];
    
}


- (IBAction)black:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DatailMessageViewController *datail = [[DatailMessageViewController alloc]init];
      _model = _messageMArray[indexPath.row];
    datail.labelText = _model.alert;
    [self.navigationController pushViewController:datail animated:YES];

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _messageMArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MessageTableViewCell" forIndexPath:indexPath];
    _model = _messageMArray[indexPath.row];
    NSString *year = [_model.create_date substringToIndex:4];
    NSString *mounth = [_model.create_date substringWithRange:NSMakeRange(4, 2)];
    NSString *date = [_model.create_date substringFromIndex:6];
    NSString *finaDate = [NSString stringWithFormat:@"%@-%@-%@",year,mounth,date];
    _is_read = [_model.is_read integerValue];
    
    if (_is_read) {
        cell.hideRedDog.hidden = YES;
    }else
    {
        cell.hideRedDog.hidden = NO;
    }

    cell.label.text = _model.alert;
    cell.datelabel.text = finaDate;
    
    
    
    
    return cell;
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
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = NO;
    self.title = @"我的消息";
    
    [BYSHttpTool GET:APP_USER_GETMESSAGE Parameters:[HttpParameters app_user_getMessagesPageindex:@"1"] Success:^(id responseObject) {
        
        NSLog(@"%@",responseObject);
        _messageMArray = [NSMutableArray array];
        NSArray *array  = responseObject[@"data"];
        for (NSInteger i = 0;i < array.count; i++) {
            _model = [[MessageModel alloc]initWithDictionary:array[i] error:nil];
            [_messageMArray addObject:_model];
            [self.tableView reloadData];
            NSLog(@"%@----------%@",_model,_messageMArray);


        }
       

        
        
    } Failure:^(NSError *error) {
        
        NSLog(@"%@",error);
        
        [SVProgressHUD showErrorWithStatus:@"服务器超时...."];
        
    }];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    self.navigationController.navigationBarHidden = YES;
    
}

@end
