//
//  ICETools.m
//  YiYuanYun
//
//  Created by 陈冰 on 15/5/12.
//  Copyright (c) 2015年 Glacier. All rights reserved.
//

#import "ICETools.h"
#import "math.h"

@implementation ICETools

/**
 *  判断手机号格式是否正确
 *
 *  @param mobileNum 传入字符串
 *
 *  @return YES，格式正确；NO，格式不正确
 *
 *  @since 1.0
 */
+ (BOOL)isMobileNumber:(NSString *)mobileNum {
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189,177
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189,177
     22         */
    NSString * CT = @"^1((33|53|8[09]|77)[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm     = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu     = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct     = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    } else {
        return NO;
    }
}

/**
 *  电子邮件
 *
 *  @param email 传入字符串
 *
 *  @return YES，格式正确；NO，格式不正确
 *
 *  @since 1.0
 */
+ (BOOL)isEmail:(NSString *)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

/**
 *  qq
 *
 *  @param qqNum 传入字符串
 *
 *  @return YES，格式正确；NO，格式不正确
 *
 *  @since 1.0
 */
+ (BOOL)isQqNumber:(NSString *)qqNum {
    NSString *qqstr = @"[1-9][0-9]{4,}";
    NSPredicate *qqTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",qqstr];
    return [qqTest evaluateWithObject:qqNum];
}

/**
 *  银行卡
 *
 *  @param bankCardNumber 传入字符串
 *
 *  @return YES，格式正确；NO，格式不正确
 *
 *  @since 1.0
 */
+ (BOOL)isBankCardNumber: (NSString *)bankCardNumber {
    BOOL flag;
    if (bankCardNumber.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{15,30})";
    NSPredicate *bankCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [bankCardPredicate evaluateWithObject:bankCardNumber];
}

/**
 *  对输入的字符串进行是否为空验证
 *
 *  @param str         需要进行验证的字符串
 *  @param warningText 警告文本，如果为空，则显示
 *
 *  @return 字符串不为空，则返回YES，否则返回NO
 *
 *  @since 1.0
 */
+ (BOOL)isStringIsNull:(NSString *)str WarningText:(NSString *)warningText {
    if ([str isEqualToString:@""]) {
        [[[UIAlertView alloc] initWithTitle:@"提示" message:warningText delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
        return NO;
    }
    return YES;
}

/**
 *  用正则表达式对输入的字符串进行合法检测
 *
 *  @param trimmedString 需要检测的字符串
 *  @param regex         进行匹配的正则表达式
 *
 *  @return 如果合法，返回YES,否则返回NO
 *
 *  @since 1.0
 */
+ (BOOL)isStringIsRight:(NSString *)trimmedString andRegexString:(NSString *)regex {
    NSPredicate *predicateTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if([predicateTest evaluateWithObject:trimmedString]){
        return NO;
    } else {
        return YES;
    }
}

/**
 *  判断文件夹是否存在，
 *
 *  @param path       传入文件夹名称
 *
 *  @return bool 返回文件夹是否存在
 */
+ (BOOL)isExistFile:(NSString *)path {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir = FALSE;
    BOOL isDirExist = [fileManager fileExistsAtPath:path isDirectory:&isDir];
    if(!(isDirExist && isDir)) {
        return false;
    }
    return true;
}

/**
 *  检查对象是否是一个字典
 *
 *  @param mDictionary 需要检查的对象
 *
 *  @return 是否是一个字典
 *
 *  @since 1.0
 */
+ (BOOL)isNSDictionary:(id)mDictionary {
    if (mDictionary && [mDictionary isKindOfClass:[NSDictionary class]]) {
        return YES;
    }
    return NO;
}

/**
 *  检查对象是否是一个数组
 *
 *  @param mArray 需要检查的对象
 *
 *  @return 是否是一个数组
 *
 *  @since 1.0
 */
+ (BOOL)isNSArray:(id)mArray {
    if (mArray && [mArray isKindOfClass:[NSArray class]]) {
        return YES;
    }
    return NO;
}

/**
 *  判断是否登录,已登录返回YES，未登录返回NO
 *  注意：该方法仅判断是都存在token，不能保证token未过期
 *
 *  @return YES
 *
 *  @since 1.0
 */
+ (BOOL)isLogin {
    //    if ([SSKeychain passwordForService:kAccessToken account:SSKeychainAcountName]) {
    //        return YES;
    //    }else{
    return NO;
    //    }
}

/**
 *  绘制view的边界，Test方法使用
 *
 *  @since 1.0
 */
+ (void)viewBoderOfTest:(UIView *)view {
    //    if(DEV_TEST)
    {
        view.layer.borderColor = [UIColor redColor].CGColor;
        view.layer.borderWidth = 1;
    }
}

/**
 *  通用的警告框提示
 *
 *  @param title       警告框的Title
 *  @param message     警告框的内容
 *  @param cancelTitle 取消按钮的名字
 *
 *  @since 1.0
 */
+ (void)alertFormatofTitle:(NSString *)title withMessage:(NSString *)message withCancelBtnTitle:(NSString *)cancelTitle {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:cancelTitle otherButtonTitles:nil];
    [alert show];
}

/**
 *  返回随机颜色
 *
 *  @return UIColor
 *
 *  @since 1.0
 */
+ (UIColor *)colorLightRandom {
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 );  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}

/**
 *  根据RGB返回UIColor。
 *
 *  @param  red、green、blue:范围0—255。
 *  @param  alpha:透明度。
 *
 *  return  UIColor
 *
 *  @since 1.0
 */
+ (UIColor *)colorRed:(NSInteger)red green:(NSInteger)green blue:(NSInteger)blue alpha:(CGFloat)alpha {
    UIColor *color = [UIColor colorWithRed:red/255.f green:green/255.f blue:blue/255.f alpha:alpha];
    return color;
}

/**
 *  根据十六进制颜色值返回UIColor。
 *
 *  @param  hexColor:十六进制颜色值。
 *
 *  return  UIColor。
 *
 *  @since 1.0
 */
+ (UIColor *)colorFromHex:(NSInteger)hexColor {
    return [UIColor colorWithRed:((float) ((hexColor & 0xFF0000) >> 16)) / 0xFF
                           green:((float) ((hexColor & 0xFF00)   >> 8))  / 0xFF
                            blue:((float)  (hexColor & 0xFF))            / 0xFF
                           alpha:1.0];
}


/**
 * 将UIColor变换为UIImage
 *
 *  @param  color    颜色对象
 *
 *  return  theImage 图片对象
 *
 *  @since 1.0
 */
+ (UIImage *)imageCreateWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

/**
 *  将image压缩为800x598的大小，
 *
 *  @param image       传入uiimage
 *
 *  @return 返回已经转好的uiimage
 */
+ (UIImage *)imageScale:(UIImage *)image {
    CGSize size = CGSizeMake(800, 598);
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

/**
 *  压缩图片尺寸,方便上传服务器
 *
 *  @param img  原始图片
 *  @param size 要压缩到的尺寸
 *
 *  @return 压缩好的图片
 *
 *  @since 1.0
 */
+ (UIImage *)imageScale:(UIImage *)img size:(CGSize)size{
    // 创建一个bitmap的context
    CGSize imgSize = img.size;
    if (imgSize.width * imgSize.height < 480000) {  // 500KB 以下就不压缩了
        return img;
    }
    
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
    [img drawInRect:CGRectMake(0,0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage =UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    //返回新的改变大小后的图片
    return scaledImage;
}

/**
 *  保持原来的长宽比，生成一个缩略图
 *
 *  @param img  原始图片
 *  @param size 要压缩到的尺寸
 *
 *  @return 压缩好的图片
 *
 *  @since 1.0
 */
+ (UIImage *)imageThumbnail:(UIImage *)image size:(CGSize)asize {
    UIImage *newimage;
    if (nil == image) {
        newimage = nil;
    }
    else{
        CGSize oldsize = image.size;
        CGRect rect;
        if (asize.width/asize.height > oldsize.width/oldsize.height) {
            rect.size.width = asize.height*oldsize.width/oldsize.height;
            rect.size.height = asize.height;
            rect.origin.x = (asize.width - rect.size.width)/2;
            rect.origin.y = 0;
        }
        else {
            rect.size.width = asize.width;
            rect.size.height = asize.width*oldsize.height/oldsize.width;
            rect.origin.x = 0;
            rect.origin.y = (asize.height - rect.size.height)/2;
        }
        UIGraphicsBeginImageContext(asize);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
        UIRectFill(CGRectMake(0, 0, asize.width, asize.height));//clear background
        [image drawInRect:rect];
        newimage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    return newimage;
}

/**
 *  剪切图片
 *
 *  @param image      原始图片
 *  @param mCGRect    需要的尺寸
 *  @param centerBool 是否居中剪切
 *
 *  @return 剪切后图片
 *
 *  @since 1.0
 */
+ (UIImage*)imageThumbnail:(UIImage *)image mCGRect:(CGRect)mCGRect centerBool:(BOOL)centerBool {
    
    /*如若centerBool为Yes则是由中心点取mCGRect范围的图片*/
    
    float imgwidth = image.size.width;
    float imgheight = image.size.height;
    float viewwidth = mCGRect.size.width;
    float viewheight = mCGRect.size.height;
    CGRect rect;
    if(centerBool)
        rect = CGRectMake((imgwidth-viewwidth)/2, (imgheight-viewheight)/2, viewwidth, viewheight);
    else{
        if (viewheight < viewwidth) {
            if (imgwidth <= imgheight) {
                rect = CGRectMake(0, 0, imgwidth, imgwidth*viewheight/viewwidth);
            }else {
                float width = viewwidth*imgheight/viewheight;
                float x = (imgwidth - width)/2 ;
                if (x > 0) {
                    rect = CGRectMake(x, 0, width, imgheight);
                }else {
                    rect = CGRectMake(0, 0, imgwidth, imgwidth*viewheight/viewwidth);
                }
            }
        }else {
            if (imgwidth <= imgheight) {
                float height = viewheight*imgwidth/viewwidth;
                if (height < imgheight) {
                    rect = CGRectMake(0, 0, imgwidth, height);
                }else {
                    rect = CGRectMake(0, 0, viewwidth*imgheight/viewheight, imgheight);
                }
            }else {
                float width = viewwidth*imgheight/viewheight;
                if (width < imgwidth) {
                    float x = (imgwidth - width)/2 ;
                    rect = CGRectMake(x, 0, width, imgheight);
                }else {
                    rect = CGRectMake(0, 0, imgwidth, imgheight);
                }
            }
        }
    }
    
    CGImageRef subImageRef = CGImageCreateWithImageInRect(image.CGImage, rect);
    CGRect smallBounds = CGRectMake(0, 0, CGImageGetWidth(subImageRef), CGImageGetHeight(subImageRef));
    
    UIGraphicsBeginImageContext(smallBounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, smallBounds, subImageRef);
    UIImage* smallImage = [UIImage imageWithCGImage:subImageRef];
    UIGraphicsEndImageContext();
    
    return smallImage;
}

/**
 *  将image转90,180,270度的方法
 *
 *  @param image       传入uiimage
 *  @param orientation image 的 旋转角度
 *
 *  @return 返回已经转好的uiimage
 */
+ (UIImage *)image:(UIImage *)image rotation:(UIImageOrientation)orientation {
    long double rotate = 0.0;
    CGRect rect;
    float translateX = 0;
    float translateY = 0;
    float scaleX = 1.0;
    float scaleY = 1.0;
    
    switch (orientation) {
        case UIImageOrientationLeft:
            rotate = M_PI_2;
            rect = CGRectMake(0, 0, image.size.height, image.size.width);
            translateX = 0;
            translateY = -rect.size.width;
            scaleY = rect.size.width/rect.size.height;
            scaleX = rect.size.height/rect.size.width;
            break;
        case UIImageOrientationRight:
            rotate = 3 * M_PI_2;
            rect = CGRectMake(0, 0, image.size.height, image.size.width);
            translateX = -rect.size.height;
            translateY = 0;
            scaleY = rect.size.width/rect.size.height;
            scaleX = rect.size.height/rect.size.width;
            break;
        case UIImageOrientationDown:
            rotate = M_PI;
            rect = CGRectMake(0, 0, image.size.width, image.size.height);
            translateX = -rect.size.width;
            translateY = -rect.size.height;
            break;
        default:
            rotate = 0.0;
            rect = CGRectMake(0, 0, image.size.width, image.size.height);
            translateX = 0;
            translateY = 0;
            break;
    }
    
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    //做CTM变换
    CGContextTranslateCTM(context, 0.0, rect.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextRotateCTM(context, rotate);
    CGContextTranslateCTM(context, translateX, translateY);
    
    CGContextScaleCTM(context, scaleX, scaleY);
    //绘制图片
    CGContextDrawImage(context, CGRectMake(0, 0, rect.size.width, rect.size.height), image.CGImage);
    
    UIImage *newPic = UIGraphicsGetImageFromCurrentImageContext();
    
    return newPic;
}

//添加图片缩略参数
+ (NSURL *)makeAppendScaleParagramWithImageAddress:(NSString *)str {
    NSString *strPath = [NSString stringWithFormat:@"%@?imageMogr2/thumbnail/240x240!",str];
    NSURL *url = [NSURL URLWithString:strPath];
    return url;
}

//添加图片缩略参数
+ (NSString *)appendScaleParagramWithImageAddress:(NSString *)str {
    NSString *strPath = [NSString stringWithFormat:@"%@?imageMogr2/thumbnail/240x240!",str];
    return strPath;
}

/**
 * 获取指定宽度width,字体大小fontSize,字符串value的高度
 *
 * @param value     待计算的字符串
 * @param fontSize  字体的大小
 * @param Width     限制字符串显示区域的宽度
 *
 * @result float    返回的高度
 *
 *  @since 1.0
 */
+ (CGFloat)heightForString:(NSString *)value andWidth:(float)width{
    //获取当前文本的属性
    NSAttributedString *attrStr = [[NSAttributedString alloc]
                                   initWithString:value
                                   attributes:@{
                                                NSFontAttributeName : [UIFont fontWithName:@"ZhaimiMedium-" size:15],
                                                NSForegroundColorAttributeName : [UIColor colorWithRed:86.0/255.0 green:90.0/255.0 blue:92.0/255.0 alpha:1.0]
                                                }];
    NSRange range = NSMakeRange(0, attrStr.length);
    // 获取该段attributedString的属性字典
    NSDictionary *dic = [attrStr attributesAtIndex:0 effectiveRange:&range];
    // 计算文本的大小
    CGSize sizeToFit = [value boundingRectWithSize:CGSizeMake(width - 16, MAXFLOAT) // 用于计算文本绘制时占据的矩形块
                                           options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading // 文本绘制时的附加选项
                                        attributes:dic        // 文字的属性
                                           context:nil].size; // context上下文。包括一些信息，例如如何调整字间距以及缩放。该对象包含的信息将用于文本绘制。该参数可为nil
    return sizeToFit.height;
}


/**
 *  根据字数的不同决定size的大小
 *
 *  @since 1.0
 */
+ (CGSize)boundingRectWithSize:(CGSize)size withText:(NSString *)text withfont:(UIFont *)font {
    NSDictionary *attribute = @{NSFontAttributeName: font};
    CGSize retSize = [text boundingRectWithSize:size
                                        options:\
                      NSStringDrawingTruncatesLastVisibleLine |
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                     attributes:attribute
                                        context:nil].size;
    return retSize;
}


/**
 *  获取字符串的size
 *
 *  @param aString 原始字符串
 *
 *  @return 字符串的size
 *
 *  @since 1.0
 */
+ (CGSize)getStringRect:(NSString*)aString {
    CGSize size;
    if (!aString) {
        return CGSizeMake(0, 0);
    }
    NSAttributedString* atrString = [[NSAttributedString alloc] initWithString:aString];
    NSRange range = NSMakeRange(0, atrString.length);
    NSDictionary* dic = [atrString attributesAtIndex:0 effectiveRange:&range];
    if ([([[UIDevice currentDevice] systemVersion]) floatValue] >= 7.0) {
        CGSize mSize =  CGSizeMake(150, 200);
        size = [aString boundingRectWithSize:mSize  options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    } else {
        size = [atrString size];
    }
    return  size;
}

+ (CGSize)getStringRect:(NSString*)aString withSize:(CGSize)mSize {
    CGSize size;
    if (!aString) {
        return CGSizeMake(0, 0);
    }
    NSAttributedString* atrString = [[NSAttributedString alloc] initWithString:aString];
    NSRange range = NSMakeRange(0, atrString.length);
    NSDictionary* dic = [atrString attributesAtIndex:0 effectiveRange:&range];
    if ([([[UIDevice currentDevice] systemVersion]) floatValue] >= 7.0) {
        //        CGSize mSize =  CGSizeMake(200, 200);
        size = [aString boundingRectWithSize:mSize  options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    } else {
        size = [atrString size];
    }
    return  size;
}

/**
 *  时间戳转换标准时间
 *
 *  @since 1.0
 */
+ (NSString *)timeStandard:(NSString *)timeStamp {
    double lastactivityInterval = [timeStamp doubleValue];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:lastactivityInterval];
    NSString *dateString = [formatter stringFromDate:date];
    return dateString;
}

/**
 *  标准时间转换时间戳
 *
 *  @since 1.0
 */
+ (NSString *)timeStamp:(NSString *)timeStandard {
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSDate *date = [formatter dateFromString:timeStandard];
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[date timeIntervalSince1970]];
    return timeSp;
}


/**
 *  格式化时间
 *
 *  @since 1.0
 */
+ (NSString *)timeDate:(NSString *)aString {
    if ([aString isEqualToString:@""]) {
        return @"";
    }
    return [NSString stringWithFormat:@"%@ %@",[aString substringWithRange:NSMakeRange(0, 10)],[aString substringWithRange:NSMakeRange(11, 5)]];
}

/**
 *  格式化时间字符串
 *
 *  @return 时间字符串
 *
 *  @since 1.0
 */
+ (NSString *)timeString:(NSDate *)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息。
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
}

/**
 * 计算指定时间与当前的时间差
 *
 * @param compareDate   某一指定时间
 *
 * @return 多少(秒or分or天or月or年)+前 (比如，3天前、10分钟前)
 *
 *  @since 1.0
 */
+ (NSString *)timeCompareCurrent:(NSDate *)compareDate {
    NSTimeInterval  timeInterval = [compareDate timeIntervalSinceNow];
    timeInterval =  [[NSDate date] timeIntervalSinceNow] - timeInterval;
    int temp = 0;
    NSString *result;
    if (timeInterval < 60) {
        result = [NSString stringWithFormat:@"刚刚"];
    }
    else if((temp = timeInterval/60) <60){
        result = [NSString stringWithFormat:@"%d分前",temp];
    }
    
    else if((temp = temp/60) <24){
        result = [NSString stringWithFormat:@"%d小前",temp];
    }
    
    else if((temp = temp/24) <30){
        result = [NSString stringWithFormat:@"%d天前",temp];
    }
    
    else if((temp = temp/30) <12){
        result = [NSString stringWithFormat:@"%d月前",temp];
    }
    else{
        temp = temp/12;
        result = [NSString stringWithFormat:@"%d年前",temp];
    }
    
    return  result;
}

/**
 *  友好时间
 *
 *  @param dataTime 时间
 *
 *  @return 友好时间
 *
 *  @since 1.0
 */
+ (NSString *)timeFindendliy:(NSString *)dataTime{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //设置格式 年yyyy 月 MM 日dd 小时hh(HH) 分钟 mm 秒 ss MMM单月 eee周几 eeee星期几 a上午下午
    //与字符串保持一致
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //现在的时间转换成字符串
    NSDate * nowDate = [NSDate date];
    NSString * noewTime = [formatter stringFromDate:nowDate];
    //参数字符串转化成时间格式
    NSDate * date = [formatter dateFromString:dataTime];
    //参数时间距现在的时间差
    NSTimeInterval time = -[date timeIntervalSinceNow];
    NSLog(@"%f",time);
    //上述时间差输出不同信息
    if (time < 60) {
        return @"刚刚";
        
    }else if (time <3600){
        int minute = time/60;
        NSString * minuteStr = [NSString stringWithFormat:@"%d分钟前",minute];
        return  minuteStr;
        
    }else {
        //如果年不同输出某年某月某日
        if ([[dataTime substringToIndex:4] isEqualToString:[noewTime substringToIndex:4]]) {
            //截取字符串从下标为5开始 2个
            NSRange rangeM = NSMakeRange(5, 2);
            //如果月份不同输出某月某日某时
            if ([[dataTime substringWithRange:rangeM]isEqualToString:[noewTime substringWithRange:rangeM]]) {
                NSRange rangD = NSMakeRange(8, 2);
                //如果日期不同输出某日某时
                if ([[dataTime substringWithRange:rangD]isEqualToString:[noewTime substringWithRange:rangD]]) {
                    NSRange rangeSSD = NSMakeRange(11, 5);
                    NSString * Rstr = [NSString stringWithFormat:@"今日%@",[dataTime substringWithRange:rangeSSD]];
                    return  Rstr;
                }else{
                    NSRange rangSD = NSMakeRange(5, 5);
                    return [dataTime substringWithRange:rangSD];
                }
            }else{
                NSRange rangeSM = NSMakeRange(5,5);
                return [dataTime substringWithRange:rangeSM];
            }
        }else{
            return [dataTime substringToIndex:10];
        }
    }
}

/**
 *  检查字符串Object 是否为空，如果为<null>等，则统一为@""
 *
 *  @param object 需要检查的字符串
 *
 *  @return 返回修改好的字符串
 *
 *  @since 1.0
 */
+(NSString *)strCheckPostObject:(id)object {
    if ([object isEqual:[NSNull class]]) {
        return [NSString stringWithFormat:@""];
    } else if([object isKindOfClass:[NSNull class]]) {
        return [NSString stringWithFormat:@""];
    } else {
        if (object == nil || [object isEqualToString:@"<null>"] || [object isEqualToString:@"(null)"])  {
            return [NSString stringWithFormat:@""];
        }
        return object;
    }
    return [NSString stringWithFormat:@""];
}

/**
 *  截取字符串
 *
 *  @param str 传入str
 *
 *  @return 返回str
 *
 *  @since 1.0
 */
+ (NSString *)strFromStr:(NSString *)str withIndex:(NSInteger )index {
    NSString *strBack;
    if (str.length > index) {
        strBack = [NSString stringWithFormat:@"%@...",[str substringToIndex:index]];
    } else {
        strBack = str;
    }
    return strBack;
}


/**
 *  返回字段payMethod    英文转中文
 *
 *  @param url 剪切图的URL
 *
 *  @return 原始图的URL
 *
 *  @since 1.0
 */
+ (NSString *)strBackPayMethodInChinese:(NSString *)pyStr {
    if ([pyStr isEqualToString:@"cash"]) {
        return @"货到付款";
    }
    else if ([pyStr isEqualToString:@"alipay"]) {
        return @"支付宝";
    }
    else if ([pyStr isEqualToString:@"balance"])
    {
        return @"余额支付";
    }
    else if ([pyStr isEqualToString:@"wechar"])
    {
        return @"微信支付";
    }
    return pyStr;
}

/**
 *  获取共享文件夹的路径
 *
 *  @param filePath 文件名称
 *
 *  @return 带共享文件夹的文件路径
 *
 *  @since 1.0
 */
+ (NSString*)shareFilePath:(NSString*)filePath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent: filePath];
}


/**
 *  获取原始图的URL
 *
 *  @param url 剪切图的URL
 *
 *  @return 原始图的URL
 *
 *  @since 1.0
 */
+ (NSString*)sortImageUrl:(NSString*)url {
    NSArray* items = [url componentsSeparatedByString:@".JPG"];
    if (items.count < 2) {
        items = [url componentsSeparatedByString:@".jpg"];
    }
    if (items.count < 2) {
        return url;
    }
    
    NSString* result = items[items.count- 2];
    result =  [result substringToIndex:[result length]-2];
    result = [result stringByAppendingString:@".jpg"];
    return result;
}

/**
 *  返回Array所描述的字符串
     字典格式如下：
     @[@{@"string":@"单价",@"isMainColor":@NO},
     @{@"string":strPrice,@"isMainColor":@YES},
     @{@"string":totalPrice,@"isMainColor":@NO}]
 *
 *  @param strArray 字符串Array
 *
 *  @return NSAttributedString
 *
 *  @since 1.0
 */
+ (NSAttributedString *)getAttributedStringWithArray:(NSArray *)strArray withFont:(UIFont *)font {
    NSMutableAttributedString *str = [NSMutableAttributedString new];
    for (NSDictionary *item in strArray) {
        UIColor *color = [item[@"isMainColor"] boolValue] ? [UIColor colorWithRed:50.0/255.0 green:162.0/255.0 blue:248.0/255.0 alpha:1.0] : [UIColor colorWithRed:165/255.0 green:165/255.0 blue:165/255.0 alpha:1.0];
        NSMutableAttributedString *p1 = [[NSMutableAttributedString alloc]
                                         initWithString:item[@"string"]
                                         attributes:@{
                                                      NSFontAttributeName : font,
                                                      NSForegroundColorAttributeName :color
                                                      }];
        [str appendAttributedString:p1];
    }
    return str;
}

/**
 *  返回icofont NSAttributedString
 *
 *  @param strArray 描述数组
 *
 *  @return NSAttributedString
 *
 *  @since 1.0
 */
+(NSAttributedString *)getIcoFontWithArray:(NSArray *)strArray {
    NSMutableAttributedString *str = [NSMutableAttributedString new];
    for (NSDictionary *item in strArray) {
        CGFloat fontSize = [item[@"fontSize"] floatValue];
        UIColor *color = [item[@"isMainColor"] boolValue] ? [UIColor colorWithRed:50.0/255.0 green:162.0/255.0 blue:248.0/255.0 alpha:1.0] : [UIColor colorWithRed:165/255.0 green:165/255.0 blue:165/255.0 alpha:1.0];
        UIFont *font = [item[@"isIcoFont"] boolValue] ? [UIFont fontWithName:@"iconfont" size:fontSize] : [UIFont fontWithName:@"ZhaimiMedium-" size:fontSize];
        NSMutableAttributedString *p1 = [[NSMutableAttributedString alloc]
                                         initWithString:item[@"string"]
                                         attributes:@{
                                                      NSFontAttributeName : font,
                                                      NSForegroundColorAttributeName :color
                                                      }];
        [str appendAttributedString:p1];
    }
    return str;
}

/**
 *  返回NSAttributedString，左侧String为灰色，右侧为kMainColor
 *
 *  @param firstStr 左侧String
 *  @param lastStr  右侧String
 *  @param fontSize 字体大小
 *
 *  @return 返回NSAttributedString
 *
 *  @since 1.0
 */
+(NSAttributedString *)getAttributedStringWithFirstString:(NSString *)firstStr
                                               firstColor:(UIColor *)firstColor
                                            andLastString:(NSString *)lastStr
                                                lastColor:(UIColor *)lastColor
                                             withFontSize:(CGFloat )fontSize
{
    UIFont *font = [UIFont fontWithName:@"ZhaimiMedium-" size:fontSize];
    NSMutableAttributedString *p1 = [[NSMutableAttributedString alloc]
                                     initWithString:firstStr
                                     attributes:@{
                                                  NSFontAttributeName : font,
                                                  NSForegroundColorAttributeName :firstColor
                                                  }];
    NSMutableAttributedString *p2 = [[NSMutableAttributedString alloc]
                                     initWithString:lastStr
                                     attributes:@{
                                                  NSFontAttributeName : font,
                                                  NSForegroundColorAttributeName :lastColor
                                                  }];
    [p1 appendAttributedString:p2];
    return p1;
}

/**
 *  返回IcoFont NSAttributedString，左侧String为灰色，右侧为kMainColor
 *
 *  @param firstStr 左侧String
 *  @param lastStr  右侧String
 *  @param fontSize 字体大小
 *
 *  @return 返回NSAttributedString
 *
 *  @since 1.0
 */
+(NSAttributedString *)getIcoFontAttributedStringWithFirstString:(NSString *)firstStr
                                                      firstColor:(UIColor *)firstColor
                                                       firstFont:(UIFont *)firstFont
                                                   andLastString:(NSString *)lastStr
                                                       lastColor:(UIColor *)lastColor
                                                        lastFont:(UIFont *)lastFont
{
    NSMutableAttributedString *p1 = [[NSMutableAttributedString alloc]
                                     initWithString:firstStr
                                     attributes:@{
                                                  NSFontAttributeName : firstFont,
                                                  NSForegroundColorAttributeName :firstColor
                                                  }];
    NSMutableAttributedString *p2 = [[NSMutableAttributedString alloc]
                                     initWithString:lastStr
                                     attributes:@{
                                                  NSFontAttributeName : lastFont,
                                                  NSForegroundColorAttributeName :lastColor
                                                  }];
    [p1 appendAttributedString:p2];
    return p1;
}

/*
 2个坐标距离
 常用到如image1.transform = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(335));
 CGAffineTransformMakeRotation中要填的是弧度，所以要转换一下。
 下面是两个宏，来实现互转
 1。弧度转角度
 #define RADIANS_TO_DEGREES(radians) ((radians) * (180.0 / M_PI))
 NSLog(@”Output radians as degrees: %f”, RADIANS_TO_DEGREES(0.785398));
 2。角度转弧度
 // Degrees to radians
 #define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)
 NSLog(@”Output degrees as radians: %f”, DEGREES_TO_RADIANS(45));
 M_PI 定义在Math.h内，其值为3.14159265358979323846264338327950288
 */
#define RADIANS_TO_DEGREES(radians) ((radians) * (180.0 / M_PI))
#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)
+ (NSString *)locationWithLatitude:(NSString *)firstLatitude withLongitude:(NSString *)firstLongitude WithLatitude:(NSString *)secondLatitude withLongitude:(NSString *)secondLongitude {
    double firLat = [firstLatitude doubleValue];
    double secLat = [secondLatitude doubleValue];
    double firLng = [firstLongitude doubleValue];
    double secLng = [secondLongitude doubleValue];
    
    double theta = firLng - secLng;
    double miles = (sin(DEGREES_TO_RADIANS(firLat)) * sin(DEGREES_TO_RADIANS(secLat))) + (cos(DEGREES_TO_RADIANS(firLat)) * cos(DEGREES_TO_RADIANS(secLat)) * cos(DEGREES_TO_RADIANS(theta)));
    miles = acos(miles);
    miles = RADIANS_TO_DEGREES(miles);
    miles = miles * 60 * 1.1515;// 英里
    //    double feet = miles * 5280; // 英尺
    double kilometers = miles * 1.609344; // 千米
    kilometers = kilometers * 1000;
    kilometers = round(kilometers);
    NSString *milsStr = [NSString stringWithFormat:@"%0.f", kilometers];
    return milsStr;
}

@end
