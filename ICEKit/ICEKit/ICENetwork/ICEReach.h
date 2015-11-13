//
//  ICEReach.h
//  DemoProduct
//
//  Created by ttouch on 15/11/6.
//  Copyright © 2015年 iCE. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  @author 陈冰, 15-11-06 (创建)
 *
 *  此文件里的方法是 网络监测类
 *
 *  @since 1.0
 */
@interface ICEReach : NSObject

@property (nonatomic, assign) BOOL isShowJDStatus;                              ///< 是否显示状态栏提醒
@property (nonatomic, assign, getter=isEnableConnect) BOOL hasEnableConnect;    ///< 网络是否可用

+ (id)sharedInstance;

- (void)settingHostReach;

- (void)settingLocalWiFiReach;

- (void)settingInternetConnectionReach;

@end
