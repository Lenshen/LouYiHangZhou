//
//  MessageModel.h
//  进口零食
//
//  Created by 远深 on 16/5/4.
//  Copyright © 2016年 Luo Yi TECHNOLOGY. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface MessageModel : JSONModel
@property (strong, nonatomic) NSString* _id;
@property (strong, nonatomic) NSString* is_read;
@property (strong, nonatomic) NSString* create_date;
@property (strong, nonatomic) NSString* alert;
@property (strong, nonatomic) NSString* msg_id;

@end
