//
//  SearchViewController.m
//  LouYiHangZhou
//
//  Created by 远深 on 16/4/14.
//  Copyright © 2016年 Luo Yi TECHNOLOGY. All rights reserved.
//

#import "SearchViewController.h"
#import "BYSHttpTool.h"
#import "HttpParameters.h"
@interface SearchViewController ()<UISearchBarDelegate,UISearchDisplayDelegate>
@property (strong, nonatomic) IBOutlet UISearchDisplayController *searchDisplayController;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic) NSMutableArray  *dataList;
@property (strong,nonatomic) NSMutableArray *responseArray;

@property (strong,nonatomic) NSMutableArray  *searchList;

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.searchDisplayController.searchBar.delegate = self;
    for (UIView *view in self.searchDisplayController.searchBar.subviews)
    {
        if ([view isKindOfClass:NSClassFromString(@"UISeacrchBackground")])
        {
            [view removeFromSuperview];
            break;
        }
        if ([view isKindOfClass:NSClassFromString(@"UIView")]&&view.subviews.count > 0 )
        {
            [[view.subviews objectAtIndex:0]removeFromSuperview];
        }
       
    
    
}
  

}
- (IBAction)black:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        
         return [self.searchList count];
        
        
    }else
    {
       return  [self.searchList count];
    }
    
}
    
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *flag=@"cellFlag";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:flag];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:flag];
    }
    if (tableView==self.searchDisplayController.searchResultsTableView) {
        [cell.textLabel setText:self.searchList[indexPath.row]];
    }
    else{
        [cell.textLabel setText:self.dataList[indexPath.row]];
    }
    return cell;
}
- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString{
        NSPredicate *preicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@", searchString];
    if (self.searchList!= nil) {
        [self.searchList removeAllObjects];
    }
    //过滤数据
    [BYSHttpTool POST:APP_GOOD_SEARCH Parameters:[HttpParameters search_goods:searchString page_index:@"1" page_size:@"10"] Success:^(id responseObject) {
        NSDictionary *dic = responseObject;
        _responseArray  = dic[@"data"];
        NSLog(@"%@",_responseArray);
        if (_responseArray != nil && ![_responseArray isKindOfClass:[NSNull class]] && _responseArray.count != 0)
 {
            if (_responseArray.count != 0) {
                for (NSInteger i=0; i<_responseArray.count; i++) {
                    NSDictionary *dic = _responseArray[i];
                    NSString *str = dic[@"goods_name"];
                    _dataList =[[NSMutableArray alloc]init];
                    [_dataList
                     addObject:str];
                    NSLog(@"%@%@",_dataList,str);
                    self.searchList= [NSMutableArray arrayWithArray:_dataList];
                    [self.tableView reloadData];
                    [self.searchDisplayController.searchResultsTableView reloadData];
                }
                
                
            }else
            {
                NSLog(@"meishuju");
                
            }

            
        }
        
        

       
        
        

        
    } Failure:^(NSError *error) {
        NSLog(@"%@",error)
    }];
   

    
    //刷新表格
   
    return YES;
}
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    [searchBar setShowsCancelButton:YES animated:YES];
    
    for(UIView *view in  [[[searchBar subviews] objectAtIndex:0] subviews]) {
        
        if([view isKindOfClass:[NSClassFromString(@"UINavigationButton") class]]) {
            UIButton * cancel =(UIButton *)view;
            [cancel setTitle:@"取消" forState:UIControlStateNormal];
        
        }
    }
  
}
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    NSLog(@"搜索Begin");
    return YES;
}
- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar{
    NSLog(@"搜索End");
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
