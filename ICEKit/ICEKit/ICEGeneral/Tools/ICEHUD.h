//
//  ICEHUD.h
//  DemoProduct
//
//  Created by ttouch on 15/11/9.
//  Copyright © 2015年 iCE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
/**
 *  @author 陈冰, 15-11-12 17:49:13 (更新)
 *
 *  此文件里的方法是 系统全局工具类方法
 *
 *  @since 1.1
 *
 *  添加了 + (void)HUDShowHint:(NSString *)hint view:(UIView *)view;
 */
@interface ICEHUD : NSObject

/** 隐藏HUD */
+ (void)HUDHide;

/** 显示HUD */
+ (void)HUDShow;

/** 显示HUD 添加描述*/
+ (void)HUDShowHint:(NSString *)hint;

/** 显示HUD 添加描述 显示在某个视图上*/
+ (void)HUDShowHint:(NSString *)hint view:(UIView *)view;

@end
