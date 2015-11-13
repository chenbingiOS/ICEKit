//
//  UIViewController+ICEUUPhoto.h
//  DemoProduct
//
//  Created by ttouch on 15/11/5.
//  Copyright © 2015年 iCE. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UUPhotoActionSheet;

@interface UIViewController (ICEUUPhoto)

/** 配置UUPhoto 设置照片最大选择数量 */
- (void)configUUPhotoWithMaxSelected:(NSInteger)aNum;

/** 显示照片选项 */
- (void)showUUPhoto;

/** 还是有问题 如果没有选择图片，就有可能不会移除 */
- (void)removeUUPhoto;
@end
