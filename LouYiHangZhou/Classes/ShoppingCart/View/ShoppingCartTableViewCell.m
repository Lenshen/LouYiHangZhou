//
//  ShoppingCartTableViewCell.m
//  LouYiHangZhou
//
//  Created by 远深 on 16/4/12.
//  Copyright © 2016年 Luo Yi TECHNOLOGY. All rights reserved.
//

#import "ShoppingCartTableViewCell.h"

@implementation ShoppingCartTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
- (IBAction)plus:(id)sender {
   
    self.amount += 1;
    
//    self.plusBlock(self.amount,YES);
    
    [self showOrderNumbers:self.amount];
    
}
- (IBAction)minus:(id)sender {
    
    self.amount -= 1;
    
//    self.plusBlock(self.amount,NO);
    
    [self showOrderNumbers:self.amount];
}
-(void)showOrderNumbers:(NSUInteger)count
{
    self.orderCount.text = [NSString stringWithFormat:@"%lu",(unsigned long)self.amount];
    if (self.amount > 0)
    {
        [self.minus setHidden:NO];
        [self.orderCount setHidden:NO];
    }
    else
    {
//        [self.minus setHidden:YES];
//        [self.orderCount setHidden:YES];
        self.orderCount.text = @"0";
        self.minus.userInteractionEnabled = NO;
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
