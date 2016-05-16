//
//  NSString+MD5.h
//  LuoYi
//
//  Created by 远深 on 16/4/5.
//  Copyright © 2016年 Luo Yi TECHNOLOGY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (MD5)
-(NSString*) md5;
-(void)alert:(NSString *)message viewcontroller:(UIViewController *)viewcontroller;

-(void)alertAndViewcontroller:(UIViewController *)viewcontroller;

-(BOOL) isValidateMobile:(NSString *)mobile;
@end
