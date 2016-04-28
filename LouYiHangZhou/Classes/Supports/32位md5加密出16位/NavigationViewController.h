//
//  NavigationViewController.h
//  LuoYi
//
//  Created by 远深 on 16/3/30.
//  Copyright © 2016年 Luo Yi TECHNOLOGY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NavigationViewController : UINavigationController
{
    BOOL _changing;

}
@property(nonatomic, retain)UIView *alphaView;
-(void)setAlph;
@end
