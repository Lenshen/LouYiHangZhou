//
//  HistoryLabel.m
//  进口零食
//
//  Created by 远深 on 16/4/27.
//  Copyright © 2016年 Luo Yi TECHNOLOGY. All rights reserved.
//

#import "HistoryLabel.h"

#define HORIZONTAL_PADDING  10.0f
#define VERTICAL_PADDING    7.0f
#define LABEL_MARGIN        20.0f
#define BOTTOM_MARGIN       20.0f

//random color
#define RANDOMCOLOR [UIColor colorWithRed:random()%255/255.0 green:random()%255/255.0 blue:random()%255/255.0 alpha:1];
@interface HistoryLabel()
{
    UIButton *_button;
    int _totalHeight;
    CGRect _previousFrame;
}
@end

@implementation HistoryLabel
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _totalHeight = 0;
        self.frame = frame;
    }
    return self;
}
-(void)setArrayTagWithLabelArray:(NSArray *)array
{
    _previousFrame = CGRectZero;
    
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self setupBtnWithNSString:obj index:idx];
        
    }];
                                       
    if (_historyBackgroundColor) {
        self.backgroundColor = _historyBackgroundColor;
    }else
    {
        self.backgroundColor = [UIColor whiteColor];
    }
    
}

- (void)setupBtnWithNSString:(NSString *)str index:(NSInteger)index
{
    
    _button = [UIButton buttonWithType:UIButtonTypeCustom];
    _button.tag = index;
    _button.frame = CGRectZero;
    if (_historySignalColor) {
        _button.backgroundColor = _historySignalColor;
    }else
    {
      
        _button.backgroundColor = RANDOMCOLOR;
    }
    
    
    _button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [_button setTitle:str forState:UIControlStateNormal];
    
    _button.titleLabel.font = [UIFont systemFontOfSize:15.0f];

    _button.layer.cornerRadius = 2;
    
    
    [_button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    
    [_button addTarget:self action:@selector(clickhandle:) forControlEvents:UIControlEventTouchUpInside];
    NSDictionary *attribute = @{NSFontAttributeName:[UIFont systemFontOfSize:15.0f]};
    CGSize StrSize = [str sizeWithAttributes:attribute];
    StrSize.width += HORIZONTAL_PADDING * 2;
    StrSize.height += VERTICAL_PADDING *2;
    ///新的 SIZE
    CGRect  NewRect = CGRectZero;
    
    if (_previousFrame.origin.x + _previousFrame.size.width + StrSize.width + LABEL_MARGIN > self.bounds.size.width) {
        NewRect.origin = CGPointMake(10, _previousFrame.origin.y + StrSize.height + BOTTOM_MARGIN);
        _totalHeight += StrSize.height + BOTTOM_MARGIN;
    }else {
        NewRect.origin = CGPointMake(_previousFrame.origin.x + _previousFrame.size.width + LABEL_MARGIN, _previousFrame.origin.y);
        
        
    }
    NewRect.size = StrSize;
    [_button setFrame:NewRect];
    _previousFrame = _button.frame;
    [self setHight:self andHight:_totalHeight + StrSize.height +BOTTOM_MARGIN];
    [self addSubview:_button];
    
    
    
   
    
}
- (void)setHight:(UIView *)view andHight:(CGFloat)hight
{
    CGRect tempFrame = view.frame;
    tempFrame.size.height = hight;
    view.frame = tempFrame;
}
- (void)clickhandle:(UIButton *)sender
{
    if ([self.historyDelegate respondsToSelector:@selector(clickhandle:)]) {
        [self.historyDelegate clickhandle:sender];
    }
}
@end
