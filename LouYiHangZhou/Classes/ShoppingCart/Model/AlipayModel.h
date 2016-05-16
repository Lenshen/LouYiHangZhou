//
//  AlipayModel.h
//  踏踏海
//
//  Created by 远深 on 16/5/16.
//  Copyright © 2016年 Luo Yi TECHNOLOGY. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface AlipayModel : JSONModel
@property (nonatomic ,strong) NSString *seller;
@property (nonatomic ,strong) NSString *order_id;
@property (nonatomic ,strong) NSString *partner;
@property (nonatomic ,strong) NSString *goods_description;
@property (nonatomic ,strong) NSString *goods_price;
@property (nonatomic ,strong) NSString *rsa_private;
@property (nonatomic ,strong) NSString *goods_name;

@end
