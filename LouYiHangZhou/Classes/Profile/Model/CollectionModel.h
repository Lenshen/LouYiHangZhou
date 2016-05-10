//
//  CollectionModel.h
//  进口零食
//
//  Created by 远深 on 16/5/6.
//  Copyright © 2016年 Luo Yi TECHNOLOGY. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface CollectionModel : JSONModel
@property (copy, nonatomic) NSString* goods_name;
@property (copy, nonatomic) NSString* sales_price;
@property (copy, nonatomic) NSString* goods_id;
@property (copy, nonatomic) NSString* market_price;
@property (copy, nonatomic) NSString* image;


@end
