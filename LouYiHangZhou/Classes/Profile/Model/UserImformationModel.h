//
//  UserImformationModel.h
//  LouYiHangZhou
//
//  Created by 远深 on 16/4/8.
//  Copyright © 2016年 Luo Yi TECHNOLOGY. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface UserImformationModel : JSONModel
@property (strong, nonatomic) NSString* user_id;
@property (strong, nonatomic) NSString* user_name;
@property (strong, nonatomic) NSString* email;
@property (strong, nonatomic) NSString* mobile;
@property (strong, nonatomic) NSString* mobile_verified;
@property (strong, nonatomic) NSString* full_name;
@property (strong, nonatomic) NSString* level;
//积分
@property (strong, nonatomic) NSString* birth;
@property (strong, nonatomic) NSString* point;
@property (strong, nonatomic) NSString* sex;
//会员头像
@property (strong, nonatomic) NSString* avatar;
@property (strong, nonatomic) NSString* create_time;
+ (instancetype)sharedManager;


@end
