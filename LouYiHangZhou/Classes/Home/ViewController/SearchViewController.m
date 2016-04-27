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
#import <MJRefresh.h>
#import "HistoryLabel.h"
#define ScreenWidth   [UIScreen mainScreen].bounds.size.width

@interface SearchViewController ()<UISearchBarDelegate,UISearchDisplayDelegate,UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UISearchDisplayController *searchDisplayController;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic) NSMutableArray  *dataList;
@property (strong,nonatomic) NSMutableArray *responseArray;
@property (strong,nonatomic) NSString *searchStr;
@property (strong,nonatomic) NSMutableArray  *searchList;
@property (weak, nonatomic) IBOutlet UIButton *blackButton;
@property (strong, nonatomic) NSArray *clearArray;
@property (strong, nonatomic) HistoryLabel *history;
@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
      [self setupMJRefreshHeader];
    [self dismissSearchBarBlackground];
    self.tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    self.automaticallyAdjustsScrollViewInsets =NO;
    _history = [[HistoryLabel alloc]initWithFrame:CGRectMake(0,70, ScreenWidth,0)];
     _clearArray =   [NSArray arrayWithObjects:@"大家",@"你是什么",@"是不是呢",@"想要什么呢",@"吃大餐了哦哦哦",@"技术部的大牛",@"商场部的技术",@"全体人员注意了。开始了", nil];
    _history.historyBackgroundColor = [UIColor colorWithRed:239/255.0 green:238/255.0 blue:244/255.0 alpha:1];
    _history.historySignalColor = [UIColor colorWithRed:202/255.0 green:202/255.0 blue:202/255.0 alpha:1];
    [_history setArrayTagWithLabelArray:_clearArray];
    [self.tableView addSubview:_history];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(ScreenWidth/2.0 - 75 ,_history.frame.origin.y+_history.frame.size.height+40, 150, 30);
    [button.layer setBorderWidth:0.5];

    button.titleLabel.font = [UIFont boldSystemFontOfSize:15.0f];
    [button addTarget:self action:@selector(clearHistory:) forControlEvents:UIControlEventTouchUpInside];
    
    


    [button setTitle:@"清除历史纪录" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.tableView addSubview:button];


}
-(void)clearHistory:(id)sender
{
    _clearArray  = nil;
    [_history removeFromSuperview];

    
}
-(void)dismissSearchBarBlackground
{
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
- (void)setupMJRefreshHeader {
   
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(LoadMoreData)];
}

//-(void)LoadMoreData
//{
//    
//    //过滤数据
//    if (self.searchStr) {
//        NSInteger i = 0;
//        i++;
//        [BYSHttpTool POST:APP_GOOD_SEARCH Parameters:[HttpParameters search_goods:self.searchStr page_index:[NSString stringWithFormat:@"%ld",(long)i] page_size:@"10"] Success:^(id responseObject) {
//            NSDictionary *dic = responseObject;
//            _responseArray  = dic[@"data"];
//            NSLog(@"%@",_responseArray);
//            if (_responseArray != nil && ![_responseArray isKindOfClass:[NSNull class]] && _responseArray.count != 0)
//            {
//                
//                _dataList =[[NSMutableArray alloc]init];
//                
//                if (_responseArray.count != 0) {
//                    for (NSInteger i=0; i<_responseArray.count; i++) {
//                        NSDictionary *dic = _responseArray[i];
//                        NSString *str = dic[@"goods_name"];
//                        [_dataList
//                         addObject:str];
//                        NSLog(@"%@%@",_dataList,str);
//                        self.searchList= [NSMutableArray arrayWithArray:_dataList];
//                        [self.tableView reloadData];
//                        [self.searchDisplayController.searchResultsTableView reloadData];
//                    }
//                    
//                    
//                }else
//                {
//                    NSLog(@"meishuju");
//                    
//                }
//                
//                
//            }
//            
//            
//            
//            
//            
//            
//            
//            
//        } Failure:^(NSError *error) {
//            NSLog(@"%@",error)
//        }];
//        
//        
//
//        
//    }else
//        [self.tableView.mj_footer endRefreshing];
// }
//
- (IBAction)black:(id)sender {
    [self.searchDisplayController setActive:NO animated:YES];
    self.blackButton.enabled = YES;


    [self.navigationController popViewControllerAnimated:YES];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        
         return [self.searchList count];
        
        
    }else
    {
       return  0;
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"dididididi");
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString{
        NSPredicate *preicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@", searchString];
    if (self.searchList!= nil) {
        [self.searchList removeAllObjects];
    }
    //过滤数据
    [BYSHttpTool POST:APP_GOOD_SEARCH Parameters:[HttpParameters search_goods:searchString page_index:@"0" page_size:@"10"] Success:^(id responseObject) {
        NSDictionary *dic = responseObject;
        self.searchStr = searchString;
        _responseArray  = dic[@"data"];
        NSLog(@"%@",_responseArray);
        if (_responseArray != nil && ![_responseArray isKindOfClass:[NSNull class]] && _responseArray.count != 0)
 {
     
           _dataList =[[NSMutableArray alloc]init];

            if (_responseArray.count != 0) {
                for (NSInteger i=0; i<_responseArray.count; i++) {
                    NSDictionary *dic = _responseArray[i];
                    NSString *str = dic[@"goods_name"];
                    [_dataList
                     addObject:str];
                    NSLog(@"%@%@",_dataList,str);
                    self.searchList= [NSMutableArray arrayWithArray:_dataList];
                    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
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
            [cancel addTarget:self action:@selector(cancelbutton:) forControlEvents:UIControlEventTouchUpInside];
        
        }
    }
  
}
- (void)cancelbutton:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];

}
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    NSLog(@"搜索Begin");
    self.blackButton.enabled = NO;

    
    return YES;
}
- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar{
    NSLog(@"搜索End");
    [self.searchDisplayController setActive:NO animated:YES];
    self.blackButton.enabled = YES;



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
