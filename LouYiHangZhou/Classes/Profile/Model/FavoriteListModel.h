//
//  FavoriteListModel.h
//  进口零食
//
//  Created by 远深 on 16/4/25.
//  Copyright © 2016年 Luo Yi TECHNOLOGY. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface FavoriteListModel : JSONModel
@property (strong, nonatomic) NSString* goods_id;
@property (strong, nonatomic) NSString* goods_name;
@property (strong, nonatomic) NSString* image;
@property (strong, nonatomic) NSString* sales_price;
@property (strong, nonatomic) NSString* market_price;
@property (strong, nonatomic) NSString* url;
@end

