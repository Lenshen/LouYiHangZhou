//
//  PayTwoViewController.m
//  踏踏海
//
//  Created by 远深 on 16/5/13.
//  Copyright © 2016年 Luo Yi TECHNOLOGY. All rights reserved.
//

#import "PayTwoViewController.h"
#import "Order.h"
#import "DataSigner.h"
#import <AlipaySDK/AlipaySDK.h>
#import "WebViewJSBridge.h"
#import "UIViewController+StoryboardFrom.h"
#import "AddReceptionViewController.h"
#import "SearhDetailViewController.h"
#import "AlipayModel.h"
@interface PayTwoViewController ()<UIWebViewDelegate,OpenWebviewDelegate>
@property (nonatomic ,strong)WebViewJSBridge *bridge;
@property (nonatomic ,strong)UIWebView *webview;
@property (nonatomic ,strong)AlipayModel *model;
@property (nonatomic ,strong)NSDictionary *aplipayDic;

@end

@implementation PayTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    
}
- (void)setUpWebview:(NSString *)indexName;
{
    
    _webview = [[UIWebView alloc]initWithFrame:CGRectMake(0,64, self.view.frame.size.width, self.view.frame.size.height-64)];
    _webview.delegate = self;
    _webview.scrollView.scrollEnabled = YES;
    
    
    NSString *mainBundleDirectory = [[NSBundle mainBundle] bundlePath];
    
    NSString *path1 = [mainBundleDirectory  stringByAppendingPathComponent:@"web"];
    NSURL *baseURL = [NSURL fileURLWithPath:path1];
    
    //    NSString *path = [[NSBundle mainBundle] pathForResource:htmlName ofType:@"html"];
    
    _bridge = [WebViewJSBridge bridgeForWebView:_webview withSuperDelegate:self];
    _bridge.openWebviewDelegate = self;
    
    NSString *str = [NSString stringWithFormat:@"web/order-detail.html?id=%@",indexName] ;
    NSString *path = [mainBundleDirectory stringByAppendingPathComponent:str];
    
    NSURLRequest *request1 = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"file://%@",[path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]]]];
    NSLog(@"%@",request1);
    
    
    [_webview loadRequest:request1];

    [self.view addSubview:_webview];
}

//s
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
    self.title = @"订单详情";
    self.automaticallyAdjustsScrollViewInsets = NO
    ;
    
    [self setUpWebview:self.indexName];
    NSLog(@"%@",self.indexName);
    
    
    
}


- (void)viewWillDisappear:(BOOL)animated
{
    
    [super viewWillDisappear:YES];
    self.navigationController.navigationBarHidden = YES;
    if ([self.navigationController.viewControllers indexOfObject:self]==NSNotFound){
        
        //用户点击了返回按钮
         [self.navigationController popToRootViewControllerAnimated:YES];

        
    }
    
    [super viewWillDisappear:animated];
    
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
