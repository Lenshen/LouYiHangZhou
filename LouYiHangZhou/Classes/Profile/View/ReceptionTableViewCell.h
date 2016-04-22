//
//  ReceptionTableViewCell.h
//  LouYiHangZhou
//
//  Created by 远深 on 16/4/11.
//  Copyright © 2016年 Luo Yi TECHNOLOGY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReceptionTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *mobileLable;
@property (weak, nonatomic) IBOutlet UIView *hideView;
@property (weak, nonatomic) IBOutlet UILabel *full_nameLable;
@property (weak, nonatomic) IBOutlet UILabel *addressLable;

@end
