//
//  AddressModel.h
//  LouYiHangZhou
//
//  Created by 远深 on 16/4/21.
//  Copyright © 2016年 Luo Yi TECHNOLOGY. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface AddressModel : JSONModel
@property (strong, nonatomic) NSString* address;
@property (strong, nonatomic) NSString* city;
@property (strong, nonatomic) NSString* area;
@property (strong, nonatomic) NSString* full_name;
@property (strong, nonatomic) NSString* mobile;
@property (strong, nonatomic) NSString* province;
@property BOOL is_default;
@property (strong, nonatomic) NSString* address_id;
//@property (strong, nonatomic) NSString* address;

@end
