//
//  SettingTableViewController.m
//  LouYiHangZhou
//
//  Created by 远深 on 16/4/11.
//  Copyright © 2016年 Luo Yi TECHNOLOGY. All rights reserved.
//

#import "SettingTableViewController.h"
#import "ProfileIMForViewController.h"
#import "UIViewController+StoryboardFrom.h"
#import "FeedBackViewController.h"
#import "BYSHttpTool.h"
#import "HttpParameters.h"

@interface SettingTableViewController ()
@property (strong, nonatomic) IBOutlet UILabel *clearCacheLabel;


@end

@implementation SettingTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self getCacheSize];
   }
-(void)getCacheSize
{
    NSString *cache =[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    CGFloat fileSize = [self folderSizeAtPath:cache];
    _clearCacheLabel.text = [NSString stringWithFormat:@"%.2fMB",fileSize];
}
- (IBAction)black:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark  tableview点击
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0 && indexPath.section == 0) {
        [self.navigationController pushViewController:[ProfileIMForViewController instanceFromStoryboard] animated:YES];
    }else if(indexPath.row == 0 && indexPath.section == 1)
    {
        [self.navigationController pushViewController:[FeedBackViewController instanceFromStoryboard] animated:YES];
    }else if (indexPath.row == 3 && indexPath.section == 1)
    {
        [self clearCache];
        
    }else if(indexPath.row == 0 && indexPath.section == 2)
    {
    
        [self.navigationController popViewControllerAnimated:YES];
        [BYSHttpTool GET:APP_USER_SIGOUT Parameters:[HttpParameters exitLogon:nil] Success:^(id responseObject) {
            NSLog(@"%@",responseObject);
            
        } Failure:^(NSError *error) {
            
        }];
        [USER_DEFAULT removeObjectForKey:@"avatar"];
        [USER_DEFAULT removeObjectForKey:@"mobile"];
        [USER_DEFAULT removeObjectForKey:@"sex"];
        [USER_DEFAULT removeObjectForKey:@"birth"];
        [USER_DEFAULT removeObjectForKey:@"user_token"];
        
    }
    
}
-(void)clearCache
{
   
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
                   , ^{
                       NSString *cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
                       
                       NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachPath];
                       NSLog(@"files :%lu",(unsigned long)[files count]);
                       for (NSString *p in files) {
                           NSError *error;
                           NSString *path = [cachPath stringByAppendingPathComponent:p];
                           if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
                               [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
                           }
                       }
                       [self performSelectorOnMainThread:@selector(clearCacheSuccess) withObject:nil waitUntilDone:YES];});
    
    
 
    
    

}


- (CGFloat)folderSizeAtPath:(NSString *)folderPath
{
    NSFileManager *manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath]) {
        return 0;
    }
    
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    
    NSString *fileName = nil;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil) {
        NSString *fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
    }
    return folderSize/(1024.0*1024.0);
}
- (long long)fileSizeAtPath:(NSString *)filePath
{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
    
}
-(void)clearCacheSuccess
{
    NSLog(@"清理成功");
       UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"清除成功" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
    [self getCacheSize];
    [self.tableView reloadData];
   
                                
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }else
        return 5;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
