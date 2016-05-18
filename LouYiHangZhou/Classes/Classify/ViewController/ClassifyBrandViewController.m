//
//  ClassifyBrandViewController.m
//  进口零食
//
//  Created by 远深 on 16/5/5.
//  Copyright © 2016年 Luo Yi TECHNOLOGY. All rights reserved.
//

#import "ClassifyBrandViewController.h"
#import "WebViewJSBridge.h"
#import "ClassifyTableViewCell.h"


@interface ClassifyBrandViewController ()<OpenWebviewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    BOOL _tableviewBool;
    NSInteger i ;
    NSArray *_titles;


}
@property (nonatomic, strong)UIWebView *webView;
@property (nonatomic, strong)WebViewJSBridge *bridge;
@property (nonatomic, strong)UIView *headview;
@property (nonatomic, strong)UITableView *tableview;
@property (nonatomic, strong)UIView *tableLowView;
@property (nonatomic, strong)NSArray *brandArray;
@property (nonatomic, strong)NSArray *brandImageArray;
@property (nonatomic, strong)NSArray *redBrandImageArray;
@property (nonatomic, strong)UILabel *titleLabel;
@property (nonatomic, strong)NSArray *typeidArray;
@property (nonatomic, strong)UIImageView *downImageView;



@end

@implementation ClassifyBrandViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   

}

- (void)setUpWebview
{
    _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    //    _webView.delegate = self;
    
    NSString *mainBundleDirectory = [[NSBundle mainBundle] bundlePath];
    
    
    NSString *htmlStr = [NSString stringWithFormat:@"web/goods.html?brandid=%@&typeid=%@",self._brandid,self._typeid];
    NSString *path = [mainBundleDirectory stringByAppendingPathComponent:htmlStr];
    
    
    
    
    _bridge = [WebViewJSBridge bridgeForWebView:_webView withSuperDelegate:self];
    _bridge.openWebviewDelegate = self;
    
    
    NSURLRequest *request1 = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"file://%@",[path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]]]];
    NSLog(@"%@",request1);
    
    [self.webView loadRequest:request1];
    [self.view addSubview:_webView];

}
- (void) updateWebview

{
    NSString *mainBundleDirectory = [[NSBundle mainBundle] bundlePath];
    
    
    NSString *htmlStr = [NSString stringWithFormat:@"web/goods.html?brandid=%@&typeid=%@",self._brandid,self._typeid];
    NSString *path = [mainBundleDirectory stringByAppendingPathComponent:htmlStr];

    NSURLRequest *request1 = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"file://%@",[path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]]]];
    NSLog(@"%@",request1);
    
    [self.webView loadRequest:request1];
}


#pragma mark viewWillAppear
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    if (!_webView) {
        [self setUpWebview];
        
    }else
    {
        return;
    }

    self.navigationController.navigationBarHidden = NO;
    
    [self initNaviHeadView];
    
    
}
-(void)initNaviHeadView
{
    _headview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 200, 44)];
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 44)];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.font = [UIFont systemFontOfSize:18];
    NSString *typeid = [NSString stringWithFormat:@"%@",self._typeid];
    
    
    if ([typeid isEqualToString:self.typeidArray[0]]) {
           _titleLabel.text = self.brandArray[0];
        
    }else if([typeid isEqualToString:self.typeidArray[1]])
    {
          _titleLabel.text = self.brandArray[1];
    }else if([typeid isEqualToString:self.typeidArray[2]])
    {
           _titleLabel.text = self.brandArray[2];
    }else if([typeid isEqualToString:self.typeidArray[3]])
    {
          _titleLabel.text = self.brandArray[3];
    }else if([typeid isEqualToString:self.typeidArray[4]])
    {
          _titleLabel.text= self.brandArray[4];
    }else if([typeid isEqualToString:self.typeidArray[5]])
    {
          _titleLabel.text=self.brandArray[5];
    }else if([typeid isEqualToString:self.typeidArray[6]])
    {
          _titleLabel.text = self.brandArray[6];
    }else if([typeid isEqualToString:self.typeidArray[7]])
    {
           _titleLabel.text = self.brandArray[7];
    }
    
    
    _titleLabel.textColor = [UIColor whiteColor];
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:18],};
    
    CGSize textSize = [_titleLabel.text boundingRectWithSize:CGSizeMake(100, 100) options:NSStringDrawingTruncatesLastVisibleLine attributes:attributes context:nil].size;
    
    
    _downImageView = [[UIImageView alloc]initWithFrame:CGRectMake(_headview.center.x+textSize.width/2+2, _headview.center.y-5, 13, 10)];
    _downImageView.backgroundColor = [UIColor clearColor];
    
    _downImageView.image = [UIImage imageNamed:@"下拉"];
    
    
    
    _headview.backgroundColor = [UIColor clearColor];
    UITapGestureRecognizer *singeTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapchick)];
    [_headview addGestureRecognizer:singeTap];
    [_headview addSubview:_titleLabel];
    [_headview addSubview:_downImageView];
    
    self.navigationItem.titleView = _headview;

}

-(void)tapchick
{
    
    if (!_tableviewBool) {
        _tableviewBool = YES;
        
        [self.view addSubview:self.tableview];
        [self.view addSubview:self.tableLowView];
    [UIView animateWithDuration:0.2 animations:^{
        _downImageView.transform = CGAffineTransformMakeRotation(M_PI);
    } completion:nil];
        

        
    }else
    {
        _tableviewBool = NO;
        [self.tableview removeFromSuperview];
        [self.tableLowView removeFromSuperview];
        [UIView animateWithDuration:0.2 animations:^{
            _downImageView.transform = CGAffineTransformMakeRotation(0);
        } completion:nil];
    }


    
    
}
-(UIView *)tableLowView
{
    if (!_tableLowView) {
        _tableLowView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.tableview.frame), kScreenWidth, kScreenHeight-self.tableview.frame.size.height-64)];
        _tableLowView.alpha = 0.4;
        _tableLowView.backgroundColor = [UIColor blackColor];
    }
    return _tableLowView;
}

-(NSArray *)brandImageArray
{
    if (_brandImageArray == nil) {
        _brandImageArray = @[[UIImage imageNamed:@"小甜点"],[UIImage imageNamed:@"小魅力"],[UIImage imageNamed:@"小恋爱"],[UIImage imageNamed:@"小妈咪"],[UIImage imageNamed:@"小礼盒"],[UIImage imageNamed:@"小海龟"],[UIImage imageNamed:@"小全家"],[UIImage imageNamed:@"小猛兽"]];
    }
    return _brandImageArray;
}

-(NSArray *)redBrandImageArray
{
    if (_brandImageArray == nil) {
        _brandImageArray = @[[UIImage imageNamed:@"红色甜点"],[UIImage imageNamed:@"红色魅力"],[UIImage imageNamed:@"红色恋爱"],[UIImage imageNamed:@"红色妈咪"],[UIImage imageNamed:@"红色礼盒"],[UIImage imageNamed:@"红色海归"],[UIImage imageNamed:@"红色全家"],[UIImage imageNamed:@"红色猛兽"]];
    }
    return _brandImageArray;
}

-(NSArray *)typeidArray
{
    if (_typeidArray == nil) {
        _typeidArray = @[@"117",@"118",@"119",@"120",@"121",@"122",@"123",@"124"];
    }
    return _typeidArray;
}

-(NSArray *)brandArray
{
    if (_brandArray == nil) {
        _brandArray = @[@"午后茶点",@"魅力爆款",@"恋爱小食",@"妈咪天下",@"缤纷礼盒",@"海货归来",@"全家分享",@"猛兽专区"];
    }
    return _brandArray;
}
-(UITableView *)tableview
{
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, 44*8)];
        _tableview.alpha = 1.0;
        _tableview.delegate = self;
        _tableview.dataSource = self;
    }
    return _tableview;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 8;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ClassifyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"classifyTableViewCell" ];
    if (cell == nil) {
         cell = [[ClassifyTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"classifyTableViewCell"];
    }
    
    cell.textLabel.text = self.brandArray[indexPath.row];
    
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    
    cell.imageview.image = self.brandImageArray[indexPath.row];

  
    

    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _titleLabel.text = self.brandArray[indexPath.row];
    self._typeid = self.typeidArray[indexPath.row];
    [self updateWebview];
    [self.tableview removeFromSuperview];
    [self.tableLowView removeFromSuperview];
    [UIView animateWithDuration:0.2 animations:^{
        _downImageView.transform = CGAffineTransformMakeRotation(0);
    } completion:nil];
}
-(void)viewWillDisappear:(BOOL)animated

{
    self.navigationController.navigationBarHidden = YES;
    
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
