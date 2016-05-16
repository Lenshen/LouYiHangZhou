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


@end

@implementation ClassifyBrandViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
//    _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight/2)];
//    _tableview.delegate = self;
//    _tableview.dataSource = self;
//   
//    [self.view addSubview:_tableview];
    i = 0;
    // Do any additional setup after loading the view.
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
    NSLog(@"%@---------%@",self._typeid,self._brandid);

    self.navigationController.navigationBarHidden = NO;
//    _headview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 200, 44)];
//    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 44)];
//    label.textAlignment = NSTextAlignmentCenter;
//    label.font = [UIFont systemFontOfSize:18];
    NSString *typeid = [NSString stringWithFormat:@"%@",self._typeid];
    
    
    if ([typeid isEqualToString:@"117"]) {
        self.title = @"午后茶点";

    }else if([typeid isEqualToString:@"118"])
    {
        self.title = @"魅力爆款";
    }else if([typeid isEqualToString:@"119"])
    {
        self.title = @"恋爱小食";
    }else if([typeid isEqualToString:@"120"])
    {
        self.title = @"妈咪天下";
    }else if([typeid isEqualToString:@"121"])
    {
        self.title = @"缤纷礼盒";
    }else if([typeid isEqualToString:@"122"])
    {
        self.title = @"海货归来";
    }else if([typeid isEqualToString:@"123"])
    {
        self.title = @"全家分享";
    }else if([typeid isEqualToString:@"124"])
    {
       self.title = @"猛兽专区";
    }
    
//
//    label.textColor = [UIColor whiteColor];
//    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:18],};
//    
//
//    CGSize textSize = [label.text boundingRectWithSize:CGSizeMake(100, 100) options:NSStringDrawingTruncatesLastVisibleLine attributes:attributes context:nil].size;
//
//    
//    UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(_headview.center.x+textSize.width/2+2, _headview.center.y-5, 13, 10)];
//    imageview.backgroundColor = [UIColor clearColor];
//    imageview.image = [UIImage imageNamed:@"gray-drop-down"];
//    
//    
//    
//    _headview.backgroundColor = [UIColor clearColor];
//    UITapGestureRecognizer *singeTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapchick)];
//    [_headview addGestureRecognizer:singeTap];
//    [_headview addSubview:label];
////    [_headview addSubview:imageview];
//
//    self.navigationItem.titleView = _headview;
//    
    
}


-(void)tapchick
{

    i++;
    if (i%2 == 0) {
        _tableviewBool= YES;
        NSLog(@"yes----%ld",i%2);
        _tableview.hidden = YES;
     
    
        

    }else
    {
        _tableviewBool = NO;
        NSLog(@"no-----%ld",i);
        _tableview.hidden = YES;
    }
//

    
    
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
    
    cell.label.text = @"dddd";
    
    return cell;
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
