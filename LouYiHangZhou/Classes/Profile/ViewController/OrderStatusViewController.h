//
//  OrderStatusViewController.h
//  LouYiHangZhou
//
//  Created by 远深 on 16/4/20.
//  Copyright © 2016年 Luo Yi TECHNOLOGY. All rights reserved.
//

#import "HomeViewController.h"
typedef void (^htmlIndex)(NSString *htmlName);

@interface OrderStatusViewController : HomeViewController
@property (nonatomic, copy)htmlIndex htmlIndex;

-(void)returnText:(htmlIndex)block;

@end
