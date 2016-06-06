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
#import "MJRefresh.h"
#import "SearchModel.h"
#import "SearhDetailViewController.h"

#define ScreenWidth   [UIScreen mainScreen].bounds.size.width

@interface SearchViewController ()<UISearchBarDelegate,UISearchDisplayDelegate,UITableViewDataSource,UITableViewDelegate,historyLableDelegeate>


@property (strong, nonatomic) IBOutlet UISearchDisplayController *searchDisplayController;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic) NSMutableArray  *dataList;
@property (strong,nonatomic) NSMutableArray *responseArray;
@property (strong,nonatomic) NSString *searchStr;
@property (strong,nonatomic) NSMutableArray  *searchList;
@property (strong,nonatomic) NSMutableArray  *finallyMArry;
@property (strong,nonatomic) NSMutableArray *searTXT;
@property (weak, nonatomic) IBOutlet UIButton *blackButton;
@property (strong, nonatomic) HistoryLabel *history;
@property (strong,nonatomic) SearchModel *model;
@property (assign, nonatomic)NSInteger index;
@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.searchDisplayController.searchResultsTableView removeFromSuperview];
//    [self setupMJRefreshHeader];


    // Do any additional setup after loading the view.
    [self dismissSearchBarBlackground];
     self.searchDisplayController.searchResultsTableView.tableFooterView =  [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f,kScreenWidth, 0.001)];
    self.searchDisplayController.searchResultsTableView.delegate = self;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = NO;

    
    [self setupMJRefreshHeader];
    
    self.tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    
    
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    
    


}
-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:YES];
    _index = 0;
    
    if([USER_DEFAULT objectForKey:@"user_token"]) {
        [self setupHistoryView];

    }

}
-(void)clickhandle:(UIButton *)sender
{
    NSString *str = _searTXT[sender.tag];
    NSLog(@"%@",str);
   [self.searchDisplayController setActive:YES animated:YES];
   
    self.searchDisplayController.searchBar.text = str;
    
    [self changeCancelButtonText];
    
}
-(void)clearHistory:(id)sender
{
    [USER_DEFAULT removeObjectForKey:@"myArray"];
    [_history removeFromSuperview];

    
}

-(void)searchDisplayController:(UISearchDisplayController *)controller willShowSearchResultsTableView:(UITableView *)tableView
{
    [tableView setContentInset:UIEdgeInsetsZero];
    [tableView setScrollIndicatorInsets:UIEdgeInsetsZero];
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
   
    

    self.searchDisplayController.searchResultsTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self  refreshingAction:@selector(LoadMoreData)];
    self.searchDisplayController.searchResultsTableView.mj_footer.ignoredScrollViewContentInsetBottom = 20;
    
   
}

-(void)LoadMoreData
{
    
    //过滤数据
    if (self.searchStr) {
      
        _index++;
        [BYSHttpTool POST:APP_GOOD_SEARCH Parameters:[HttpParameters search_goods:self.searchStr page_index:[NSString stringWithFormat:@"%ld",(long)_index] page_size:@"10"] Success:^(id responseObject) {
            NSDictionary *dic = responseObject;
            _responseArray  = dic[@"data"];
            NSLog(@"%@－－－－－－%ld",_responseArray,(long)_index);
            if (_responseArray != nil && ![_responseArray isKindOfClass:[NSNull class]] && _responseArray.count != 0)
            {
                
                _dataList =[[NSMutableArray alloc]init];
                
                if (_responseArray.count != 0) {
                    for (NSInteger i=0; i<_responseArray.count; i++) {
                        NSDictionary *dic = _responseArray[i];
                        _model = [[SearchModel alloc]initWithDictionary:dic error:nil];
                        
                        
                        
                        [_searchList
                         addObject:_model];
                        
                        [self.searchDisplayController.searchResultsTableView reloadData];
                    }
                    [ self.searchDisplayController.searchResultsTableView.mj_footer endRefreshing];

                    
                }else
                {
                    NSLog(@"meishuju");
                    
                }
                
                
            }
            
            } Failure:^(NSError *error) {
            NSLog(@"%@",error);
            
            [self.searchDisplayController.searchResultsTableView.mj_footer endRefreshing];

        }];
        
        }else
        [self.searchDisplayController.searchResultsTableView.mj_footer endRefreshing];
 }

- (IBAction)black:(id)sender {
    [self.searchDisplayController setActive:NO animated:YES];
    self.blackButton.enabled = YES;


    [self.navigationController popViewControllerAnimated:YES];
    
    
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        
        NSLog(@"%lu",_searchList.count);
        
        return [self.searchList count];

    }else
    {
       return  0;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return 50;
    }
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *flag=@"cellFlag";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:flag];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:flag];
    }
    if (tableView==self.searchDisplayController.searchResultsTableView) {
        _model = self.searchList[indexPath.row];
        [cell.textLabel setText:_model.goods_name];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _model = _searchList[indexPath.row];
    SearhDetailViewController *searhDetailViewController = [[SearhDetailViewController alloc]init];
    searhDetailViewController.indexName = _model.goods_id;
    [self.navigationController pushViewController:searhDetailViewController animated:YES];
    
    
}


- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString{
  
    if (self.searchList!= nil) {
        [self.searchList removeAllObjects];
    }
    //过滤数据
    if (searchString.length != 0) {
        
        [BYSHttpTool POST:APP_GOOD_SEARCH Parameters:[HttpParameters search_goods:searchString page_index:@"0" page_size:@"10"] Success:^(id responseObject) {
            
            NSDictionary *dic = responseObject;
            self.searchStr = searchString;
            _responseArray  = dic[@"data"];
            NSLog(@"%@=========%@",responseObject,_responseArray);
            if (_responseArray != nil && ![_responseArray isKindOfClass:[NSNull class]] && _responseArray.count != 0)
            {
                
                _dataList =[[NSMutableArray alloc]init];
                
                if (_responseArray.count != 0) {
                    for (NSInteger i=0; i<_responseArray.count; i++) {
                        NSDictionary *dic = _responseArray[i];
                        _model = [[SearchModel alloc]initWithDictionary:dic error:nil];
                        
                        [_dataList addObject:_model];
                        
                        NSLog(@"%@",_dataList);
                        
                        self.searchList= [NSMutableArray arrayWithArray:_dataList];
                        
                        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
                        
                        
                        [self.searchDisplayController.searchResultsTableView reloadData];
                    }
                    NSLog(@"%@",self.searchDisplayController.searchResultsTableView);
                    
                    
                    
                    
                }else
                {
                    NSLog(@"meishuju");
                    
                }
                
                
            }
            
        } Failure:^(NSError *error) {
            NSLog(@"%@",error);
        }];
        

        
    }
    
    
    //刷新表格
   
    return YES;
}
-(NSMutableArray *)searTXT
{
    if (_searTXT==nil) {
        _searTXT = [[NSMutableArray alloc]init];
    }
    return _searTXT;
}

-(void)SearchText :(NSString *)seaTxt
{
    //读取数组NSArray类型的数据
    // NSArray --> NSMutableArray
    NSArray *myArray = [USER_DEFAULT arrayForKey:@"myArray"];
    _searTXT = [myArray mutableCopy];
    

    [self searTXT];
    
    if (seaTxt.length != 0 ) {
        
        [_searTXT addObject:seaTxt];

    }
    if(_searTXT.count > 5)
    {
        [_searTXT removeObjectAtIndex:0];
    }
    //将上述数据全部存储到NSUserDefaults中
   
    [USER_DEFAULT setObject:_searTXT forKey:@"myArray"];
   


}
-(void)readNSUserDefaults
{
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    //读取数组NSArray类型的数据
    NSArray *myArray = [userDefaultes arrayForKey:@"myArray"];
}



-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    [searchBar setShowsCancelButton:YES animated:YES];
    
    [self changeCancelButtonText];
  
}

-(void)changeCancelButtonText
{
    for(UIView *view in  [[[self.searchDisplayController.searchBar subviews] objectAtIndex:0] subviews]) {
        
        if([view isKindOfClass:[NSClassFromString(@"UINavigationButton") class]]) {
            UIButton * cancel =(UIButton *)view;
            [cancel setTitle:@"取消" forState:UIControlStateNormal];
            [cancel addTarget:self action:@selector(cancelbutton:) forControlEvents:UIControlEventTouchUpInside];
          
            [cancel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            self.searchDisplayController.searchBar.tintColor = [UIColor whiteColor];
            
        }
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
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
    self.blackButton.enabled = YES;
    NSLog(@"%@",searchBar.text);
    [self SearchText:searchBar.text];



    return YES;
}

- (void) setupHistoryView
{
    _history = [[HistoryLabel alloc]initWithFrame:CGRectMake(0,70, ScreenWidth,0)];
    
    _history.historyDelegate = self;
    
    
    NSArray *myArray = [USER_DEFAULT arrayForKey:@"myArray"];
    _searTXT = [myArray mutableCopy];
    _history.historyBackgroundColor = [UIColor colorWithRed:239/255.0 green:238/255.0 blue:244/255.0 alpha:1];
    _history.historySignalColor = [UIColor colorWithRed:202/255.0 green:202/255.0 blue:202/255.0 alpha:1];
    [_history setArrayTagWithLabelArray:_searTXT];
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
