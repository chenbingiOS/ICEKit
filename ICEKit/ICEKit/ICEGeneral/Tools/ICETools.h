//
//  ICETools.h
//  YiYuanYun
//
//  Created by 陈冰 on 15/5/12.
//  Copyright (c) 2015年 Glacier. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 *  @author 陈冰, 15-11-12 17:24:13 (创建)
 *
 *  此文件里的方法是 系统全局工具类方法
 *
 *  @since 1.0
 */
@interface ICETools : NSObject

/** 验证手机号 */
+ (BOOL)isMobileNumber:(NSString *)mobileNum;

/** 验证电子邮件 */
+ (BOOL)isEmail:(NSString *)email;

/** 验证qq */
+ (BOOL)isQqNumber:(NSString *)qqNum;

/** 验证银行卡号 */
+ (BOOL)isBankCardNumber: (NSString *)bankCardNumber;

/** 对输入的字符串进行是否为空验证 */
+ (BOOL)isStringIsNull:(NSString *)str WarningText:(NSString *)warningText;

/** 用正则表达式对输入的字符串进行合法检测 */
+ (BOOL)isStringIsRight:(NSString *)trimmedString andRegexString:(NSString *)regex;

/** 判断文件夹是否存在 */
+ (BOOL)isExistFile:(NSString *)path;

/** 检查对象是否是一个字典 */
+ (BOOL)isNSDictionary:(id)mDictionary;

/** 检查对象是否是一个数组 */
+ (BOOL)isNSArray:(id)mArray;

/** 判断是否登录,已登录返回YES，未登录返回NO
 *  注意：该方法仅判断是都存在token，不能保证token未过期 */
+ (BOOL)isLogin;

/** 绘制view的边界，Test方法使用 */
+ (void)viewBoderOfTest:(UIView *)view;

/** 通用的警告框提示 */
+ (void)alertFormatofTitle:(NSString *)title withMessage:(NSString *)message withCancelBtnTitle:(NSString *)cancelTitle;

/** 返回随机颜色 */
+ (UIColor *)colorLightRandom;

/** 根据RGB返回UIColor */
+ (UIColor *)colorRed:(NSInteger)red green:(NSInteger)green blue:(NSInteger)blue alpha:(CGFloat)alpha;

/** 根据十六进制颜色值返回UIColor */
+ (UIColor *)colorFromHex:(NSInteger)hexColor;

/** 将UIColor变换为UIImage */
+ (UIImage *)imageCreateWithColor:(UIColor *)color;

/** 将image压缩为800x598的大小 */
+ (UIImage *)imageScale:(UIImage *)image;

/** 压缩图片尺寸，方便上传服务器  */
+ (UIImage *)imageScale:(UIImage *)img size:(CGSize)size;

/** 保持原来的长宽比，生成一个缩略图 */
+ (UIImage *)imageThumbnail:(UIImage *)image size:(CGSize)asize;

/** 剪切图片 */
+ (UIImage*)imageThumbnail:(UIImage *)image mCGRect:(CGRect)mCGRect centerBool:(BOOL)centerBool;

/** 将image转90,180,270度的方法 */
+ (UIImage *)image:(UIImage *)image rotation:(UIImageOrientation)orientation;

/** 添加图片缩略参数 */
+ (NSURL *)makeAppendScaleParagramWithImageAddress:(NSString *)str;

/** 添加图片缩略参数 */
+ (NSString *)appendScaleParagramWithImageAddress:(NSString *)str;

/** 获取指定宽度width,字体大小fontSize,字符串value的高度 */
+ (CGFloat)heightForString:(NSString *)value andWidth:(float)width;

/** 根据字数的不同决定size的大小 */
+ (CGSize)boundingRectWithSize:(CGSize)size withText:(NSString *)text withfont:(UIFont *)font;

/** 获取字符串的size */
+ (CGSize)getStringRect:(NSString *)aString;

+ (CGSize)getStringRect:(NSString *)aString withSize:(CGSize)mSize;

/** 时间戳转换标准时间 */
+ (NSString *)timeStandard:(NSString *)timeStamp;

/** 标准时间转换时间戳 */
+ (NSString *)timeStamp:(NSString *)timeStandard;

/** 格式化时间 */
+ (NSString *)timeDate:(NSString *)aString;

/** 格式化时间字符串 */
+ (NSString *)timeString:(NSDate *)date;

/** 计算指定时间与当前的时间差 */
+ (NSString *)timeCompareCurrent:(NSDate *)compareDate;

/** 友好时间 */
+ (NSString *)timeFindendliy:(NSString *)dataTime;

/** 检查字符串Object 是否为空，如果为<null>等，则统一为@""*/
+ (NSString *)strCheckPostObject:(NSString *)object;

/** 截取字符串 */
+(NSString *)strFromStr:(NSString *)str withIndex:(NSInteger )index;

/** 返回字段payMethod    英文转中文 */
+ (NSString *)strBackPayMethodInChinese:(NSString *)pyStr;

/** 获取共享文件夹的路径 */
+(NSString*)shareFilePath:(NSString*)filePath;

/** 获取原始图的URL */
+(NSString*)sortImageUrl:(NSString*)url;

/** 返回Array所描述的字符串 */
+ (NSAttributedString *)getAttributedStringWithArray:(NSArray *)strArray withFont:(UIFont *)font;

/** 返回icofont NSAttributedString */
+ (NSAttributedString *)getIcoFontWithArray:(NSArray *)strArray;

/** 返回NSAttributedString，左侧String为灰色，右侧为kMainColor */
+ (NSAttributedString *)getAttributedStringWithFirstString:(NSString *)firstStr
                                               firstColor:(UIColor *)firstColor
                                            andLastString:(NSString *)lastStr
                                                lastColor:(UIColor *)lastColor
                                             withFontSize:(CGFloat )fontSize;

/** 返回IcoFont NSAttributedString，左侧String为灰色，右侧为kMainColor */
+ (NSAttributedString *)getIcoFontAttributedStringWithFirstString:(NSString *)firstStr
                                                      firstColor:(UIColor *)firstColor
                                                       firstFont:(UIFont *)firstFont
                                                   andLastString:(NSString *)lastStr
                                                       lastColor:(UIColor *)lastColor
                                                        lastFont:(UIFont *)lastFont;

/** 2个坐标距离 */
+ (NSString *)locationWithLatitude:(NSString *)firstLatitude withLongitude:(NSString *)firstLongitude WithLatitude:(NSString *)secondLatitude withLongitude:(NSString *)secondLongitude;

@end
