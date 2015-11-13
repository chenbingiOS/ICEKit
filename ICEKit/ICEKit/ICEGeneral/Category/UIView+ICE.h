//
//  UIView+ICE.h
//  DemoProduct
//
//  Created by ttouch on 15/11/4.
//  Copyright © 2015年 iCE. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  @author 陈冰, 15-11-04  (创建)
 *
 *  此文件里的方法是 View 的分类扩展方法，方便的获取 View 的 上，下，左，右 坐标
 *
 *  @since 1.0
 */
CGPoint CGRectGetCenter(CGRect rect);
CGRect  CGRectMoveToCenter(CGRect rect, CGPoint center);
@interface UIView (ICE)

@property CGPoint origin;
@property CGSize size;

@property (readonly) CGPoint bottomLeft;
@property (readonly) CGPoint bottomRight;
@property (readonly) CGPoint topRight;

@property CGFloat height;
@property CGFloat width;

@property CGFloat top;
@property CGFloat left;

@property CGFloat bottom;
@property CGFloat right;

@property CGFloat x;
@property CGFloat y;

@property CGFloat centerX;
@property CGFloat centerY;

/** 通过偏移 */
- (void) moveBy: (CGPoint) delta;
/** 缩放 */
- (void) scaleBy: (CGFloat) scaleFactor;
/** 确保两个尺寸配合在给定大小的缩放 */
- (void) fitInSize: (CGSize) aSize;

@end
