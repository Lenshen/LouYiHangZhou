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

@interface ReceptionTableViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) AddressModel *model;
@property (nonatomic,strong)NSMutableArray *addressArrayM;
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
    [BYSHttpTool GET:@"http://192.168.0.103:7021/api/address/get" Parameters:[HttpParameters app_get_userImformation:nil ] Success:^(id responseObject) {
        NSArray *array = responseObject[@"data"];

        self.addressArrayM = [NSMutableArray arrayWithArray:array];
        NSLog(@"%@",_addressArrayM);
        
        [self.tableView reloadData];
        
        
    } Failure:^(NSError *error) {
        
    }];
}
-(void)viewWillAppear:(BOOL)animated
{
   
    [self getAddress];

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
    

    cell.addressLable.text = address;
    cell.full_nameLable.text = _model.full_name;
    cell.mobileLable.text = _model.mobile;
    
    return cell;
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        [self.addressArrayM removeObjectAtIndex:indexPath.row];
        [self deleteTableviewCell:indexPath.row];
        [self.addressArrayM removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];


        [self.tableView reloadData];
        
    }
    
}
-(void)deleteTableviewCell:(NSInteger )index;
{
    
    NSDictionary *dic = self.addressArrayM[index];
    
    [BYSHttpTool POST:@"http://192.168.0.103:7021/api/address/delete" Parameters:[HttpParameters delete_address:nil address_id:dic[@"address_id"]] Success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        
    } Failure:^(NSError *error) {
        
    }];
    }
-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
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
