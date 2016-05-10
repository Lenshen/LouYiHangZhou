//
//  WLZ_ShoppIngCarModel.h
//  WLZ_ShoppingCart
//
//  Created by lijiarui on 15/12/14.
//  Copyright © 2015年 lijiarui. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "WLZ_ShopViewModel.h"


@interface WLZ_ShoppIngCarModel : NSObject







@property(nonatomic,copy)NSString *image;
@property(nonatomic,copy)NSString *goods_name;
@property(nonatomic,copy)NSString *sale_price;
@property(nonatomic,copy)NSString *original_price;
@property(nonatomic,copy)NSString *qty;
@property(nonatomic,copy)NSString *goods_id;
@property(nonatomic,copy)NSString *total;
@property(nonatomic,copy)NSString *cart_id;
@property(nonatomic,copy)NSString *sku_name;






@property(nonatomic,assign)BOOL isSelect;



@property(nonatomic,assign)NSInteger type;

@property(nonatomic,strong)WLZ_ShopViewModel *vm;
@end
