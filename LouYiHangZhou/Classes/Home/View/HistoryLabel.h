//
//  HistoryLabel.h
//  进口零食
//
//  Created by 远深 on 16/4/27.
//  Copyright © 2016年 Luo Yi TECHNOLOGY. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol historyLableDelegeate <NSObject>

- (void)clickhandle:(UIButton *)sender;


@end
@interface HistoryLabel : UIView

@property (nonatomic, strong)UIColor *historyBackgroundColor;

@property (nonatomic, strong)UIColor *historySignalColor;

@property (nonatomic) id<historyLableDelegeate> historyDelegate;

-(void)setArrayTagWithLabelArray:(NSArray *)array;

@end
