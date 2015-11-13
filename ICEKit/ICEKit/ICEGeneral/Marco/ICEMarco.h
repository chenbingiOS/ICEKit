//
//  ICEMarco.h
//  DemoProduct
//
//  Created by ttouch on 15/11/4.
//  Copyright © 2015年 iCE. All rights reserved.
//

#ifndef ICEMarco_h
#define ICEMarco_h

/********************************************************************************************/
/** 日志输出宏 */
#ifdef DEBUG
#define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define DLog(...)
#endif
/********************************************************************************************/
/** 警告窗 */
#define __kShowAlert(_msg_)  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:_msg_ delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];\
[alert show];
/********************************************************************************************/
/** 获取设备系统版本号 */
#define __kDeviceVersion                [[[UIDevice currentDevice] systemVersion] floatValue]
/********************************************************************************************/
/** 获取屏幕高宽 **/
#define __kScreenHeight                 [UIScreen mainScreen].bounds.size.height
#define __kScreenWidth                  [UIScreen mainScreen].bounds.size.width
/********************************************************************************************/
/** 颜色 16进制 **/
#define __kColorWithRGB(rgbValue)       [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
/** 颜色 RGBA 透明度为 a (自定义) **/
#define __kColorWithRGBA(r,g,b,a)       [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
/** 颜色 RGB  透明度为1 **/
#define __kColorWithRGBA1(r,g,b)        [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
/** 颜色 随机生成 **/
#define __kColorWithArc4random          [UIColor colorWithRed:0.1+0.1*(arc4random()%10) green:0.1+0.1*(arc4random()%10) blue:0.1+0.1*(arc4random()%10) alpha:0.1+0.1*(arc4random()%10)]
/********************************************************************************************/
/** 永久NSUserDefaults 存储对象 NSUserDefaults保存的文件在tmp文件夹里 */
#define DEFINE_PERSISTENT_SET_OBJECT(object, key)                       \
({                                                                      \
NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];       \
[defaults setObject:object forKey:key];                                 \
[defaults synchronize];                                                 \
})
/** 取出 NSUserDefaults 永久存储的对象 */
#define DEFINE_PERSISTENT_GET_OBJECT(key)  [[NSUserDefaults standardUserDefaults] objectForKey:key]
/** 清除 NSUserDefaults 保存的所有数据  */
#define DEFINE_PERSISTENT_REMOVE_ALLDATA   [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:[[NSBundle mainBundle] bundleIdentifier]]
/** 清除 NSUserDefaults 保存的指定数据  */
#define DEFINE_PERSISTENT_REMOVE(_key)                                  \
({                                                                      \
NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];       \
[defaults removeObjectForKey:_key];                                     \
[defaults synchronize];                                                 \
})
/********************************************************************************************/
/** 创建单例对象 */
#define DEFINE_SHARED_INSTANCE_USING_BLOCK(block)               \
static dispatch_once_t pred = 0;                                \
__strong static id _sharedObject = nil;                         \
dispatch_once(&pred, ^{                                         \
_sharedObject = block();                                        \
});                                                             \
return _sharedObject;                                           \
/** 单例宏的使用
+ (id)sharedInstance {
    DEFINE_SHARED_INSTANCE_USING_BLOCK(^{
        return [[self alloc] init];
    });
}
*/
/********************************************************************************************/
/** 内存管理 */
#if ! __has_feature(objc_arc) // Non-ARC
#define ICEAutorelease(__v) ([__v autorelease]);
#define ICEReturnAutoreleased ICEAutorelease
#define ICERetain(__v) ([__v retain]);
#define ICEReturnRetained FMDBRetain
#define ICERelease(__v) if (__v != nil) {                       \
[__v release];                                                  \
__v = nil;                                                      \
} else {                                                        \
__v = nil;                                                      \
}
#define ICEDispatchQueueRelease(__v) (dispatch_release(__v));
#else // ARC
#define ICEAutorelease(__v)
#define ICEReturnAutoreleased(__v) (__v)
#define ICERetain(__v)
#define ICEReturnRetained(__v) (__v)
#define ICERelease(__v)
#endif
/********************************************************************************************/
/** 主要是警告信息，在非ARC项目中没有这个警告 消除:performSelector may cause a leak because its selector is unknown */
#define __kSuppressPerformSelectorLeakWarning(Stuff)            \
do {                                                            \
_Pragma("clang diagnostic push")                                \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff;                                                          \
_Pragma("clang diagnostic pop")                                 \
} while (0)
/************************************************************************************************/

#endif /* ICEMarco_h */
