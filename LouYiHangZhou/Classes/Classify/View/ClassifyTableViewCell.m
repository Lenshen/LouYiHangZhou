//
//  ClassifyTableViewCell.m
//  进口零食
//
//  Created by 远深 on 16/5/10.
//  Copyright © 2016年 Luo Yi TECHNOLOGY. All rights reserved.
//

#import "ClassifyTableViewCell.h"

@implementation ClassifyTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initContentView];
    }
    return self;
}

-(void)initContentView
{
    _imageview = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth/2-60, 22-10, 20, 20)];
    [self.contentView addSubview:_imageview];
    
}
@end
