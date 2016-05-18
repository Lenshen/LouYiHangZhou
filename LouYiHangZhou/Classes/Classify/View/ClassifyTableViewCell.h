//
//  ClassifyTableViewCell.h
//  进口零食
//
//  Created by 远深 on 16/5/10.
//  Copyright © 2016年 Luo Yi TECHNOLOGY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClassifyTableViewCell : UITableViewCell
@property (strong, nonatomic) UIImageView *imageview;
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end
