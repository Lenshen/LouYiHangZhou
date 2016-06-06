//
//  OrderStatusViewController.m
//  LouYiHangZhou
//
//  Created by 远深 on 16/4/20.
//  Copyright © 2016年 Luo Yi TECHNOLOGY. All rights reserved.
//

#import "OrderStatusViewController.h"
#import "ProfileViewController.h"
#import "UIViewController+StoryboardFrom.h"
#import "ChangePassWordViewController.h"
#import "WebViewJSBridge.h"
#import "Order.h"
#import "DataSigner.h"
#import <AlipaySDK/AlipaySDK.h>
#import "AlipayModel.h"


@interface OrderStatusViewController ()<UIWebViewDelegate,OpenWebviewDelegate>
@property (nonatomic, strong)WebViewJSBridge *bridge;
@property (nonatomic, strong)UIWebView *webView;
@property (nonatomic ,strong)AlipayModel *model;
@property (nonatomic ,strong)NSDictionary *aplipayDic;


@end

@implementation OrderStatusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"%@",self.indexName);
   


    

    
}

-(void)updateWebview:(NSString *)htmlName
{
    NSString *mainBundleDirectory = [[NSBundle mainBundle] bundlePath];
    
    NSString *str3 = [NSString stringWithFormat:@"web/orders.html?status=%@",htmlName];
    
    NSString *path = [mainBundleDirectory stringByAppendingPathComponent:str3];
    
    NSURLRequest *request1 = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"file://%@",[path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]]]];
    NSLog(@"%@",request1);
    
    [_webView loadRequest:request1];
}
-(void)setUpWebview:(NSString *)htmlName
{
  _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64)];
    _webView.delegate = self;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSString *mainBundleDirectory = [[NSBundle mainBundle] bundlePath];
        
        
        _bridge = [WebViewJSBridge bridgeForWebView:_webView withSuperDelegate:self];
        _bridge.openWebviewDelegate = self;
        
        
         NSString *htmlStr = [NSString stringWithFormat:@"web/orders.html?status=%@",htmlName];
        NSString *path = [mainBundleDirectory stringByAppendingPathComponent:htmlStr];
        
        NSURLRequest *request1 = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"file://%@",[path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]]]];
        
        [self.webView loadRequest:request1];
        NSLog(@"%@",[NSThread currentThread]);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.view addSubview:_webView];
            
        });
    });
    


    

    
    
}
-(void)payMoney:(NSDictionary *)dic
{
    
    self.aplipayDic = dic;
    _model = [[AlipayModel alloc]initWithDictionary:self.aplipayDic error:nil];
    
    NSLog(@"%@-------%@-------",_model,dic);
    
    [self alipayactionRsa_private:_model.rsa_private order_id:_model.order_id partner:_model.partner seller:_model.seller goods_name:_model.goods_name goods_price:_model.goods_price];
    
    
}


-(void)alipayactionRsa_private:(NSString *)private order_id:(NSString *)order_id partner:(NSString *)partner seller:(NSString *)seller goods_name:(NSString *)goods_name goods_price:(NSString *)goods_price;
{
    
    
    
    /*============================================================================*/
    /*============================================================================*/
    /*============================================================================*/
    
    //partner和seller获取失败,提示
    if ([partner length] == 0 ||
        [seller length] == 0 ||
        [private length] == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"缺少partner或者seller或者私钥。"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        
    }
    
    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    Order *order = [[Order alloc] init];
    order.partner = partner;
    order.sellerID = seller;
    order.outTradeNO = order_id; //订单ID（由商家自行制定）
    order.subject = goods_name; //商品标题
    //    order.body = @"测试别紧张"; //商品描述
    //    order.totalFee = [NSString stringWithFormat:@"%@",goods_price]; //商品价格
    order.totalFee = [NSString stringWithFormat:@"0.01"];
    order.notifyURL =  @"http://www.xxx.com"; //回调URL
    
    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay = @"30m";
    order.showURL = @"m.alipay.com";
    
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    NSString *appScheme = @"tatahai";
    
    //将商品信息拼接成字符串
    NSString *orderSpec = [order description];
    NSLog(@"orderSpec = %@",orderSpec);
    
    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    id<DataSigner> signer = CreateRSADataSigner(private);
    NSString *signedString = [signer signString:orderSpec];
    
    //将签名成功字符串格式化为订单字符串,请严格按照该格式
    NSString *orderString = nil;
    if (signedString != nil) {
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                       orderSpec, signedString, @"RSA"];
        
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSLog(@"reslut = %@",resultDic);
        }];
    }
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = NO;
    self.title = @"订单状态";
   
   [self setUpWebview:self.indexName];

 
}

-(void)viewWillDisappear:(BOOL)animated

{
    self.navigationController.navigationBarHidden = YES;
    self.webView = nil;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    _webView = nil;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
