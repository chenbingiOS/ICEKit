//
//  UIView+ICE.m
//  DemoProduct
//
//  Created by ttouch on 15/11/4.
//  Copyright © 2015年 iCE. All rights reserved.
//

#import "UIView+ICE.h"

CGPoint CGRectGetCenter(CGRect rect)
{
    CGPoint pt;
    pt.x = CGRectGetMidX(rect);
    pt.y = CGRectGetMidY(rect);
    return pt;
}

CGRect CGRectMoveToCenter(CGRect rect, CGPoint center)
{
    CGRect newrect   = CGRectZero;
    newrect.origin.x = center.x-CGRectGetMidX(rect);
    newrect.origin.y = center.y-CGRectGetMidY(rect);
    newrect.size     = rect.size;
    return newrect;
}

@implementation UIView (ICE)

/**
 *  Retrieve and set the origin
    重新得到并设置原点
 *
 *  @since 1.0
 */
- (CGPoint) origin {
    return self.frame.origin;
}

- (void) setOrigin: (CGPoint) aPoint {
    CGRect newframe = self.frame;
    newframe.origin = aPoint;
    self.frame      = newframe;
}

/**
 *  Retrieve and set the size
    重新得到并设置大小
 *
 *  @since 1.0
 */
- (CGSize) size {
    return self.frame.size;
}

- (void) setSize: (CGSize) aSize {
    CGRect newframe = self.frame;
    newframe.size   = aSize;
    self.frame      = newframe;
}

/**
 *  Query other frame locations 
    获取边的位置
 *
 *  @since 1.0
 */
- (CGPoint) bottomRight {
    CGFloat x = self.frame.origin.x + self.frame.size.width;
    CGFloat y = self.frame.origin.y + self.frame.size.height;
    return CGPointMake(x, y);
}

- (CGPoint) bottomLeft {
    CGFloat x = self.frame.origin.x;
    CGFloat y = self.frame.origin.y + self.frame.size.height;
    return CGPointMake(x, y);
}

- (CGPoint) topRight {
    CGFloat x = self.frame.origin.x + self.frame.size.width;
    CGFloat y = self.frame.origin.y;
    return CGPointMake(x, y);
}

/**
 *  Retrieve and set height, width, top, bottom, left, right
    重新得到并设置高度、宽度、顶部、底部、左、右
 *
 *  @since 1.0
 */
- (CGFloat) height {
    return self.frame.size.height;
}

- (void) setHeight: (CGFloat) newheight {
    CGRect newframe      = self.frame;
    newframe.size.height = newheight;
    self.frame           = newframe;
}

- (CGFloat) width {
    return self.frame.size.width;
}

- (void) setWidth: (CGFloat) newwidth {
    CGRect newframe     = self.frame;
    newframe.size.width = newwidth;
    self.frame          = newframe;
}

- (CGFloat) top {
    return self.frame.origin.y;
}

- (void) setTop: (CGFloat) newtop {
    CGRect newframe   = self.frame;
    newframe.origin.y = newtop;
    self.frame        = newframe;
}

- (CGFloat) left {
    return self.frame.origin.x;
}

- (void) setLeft: (CGFloat) newleft {
    CGRect newframe   = self.frame;
    newframe.origin.x = newleft;
    self.frame        = newframe;
}

- (CGFloat) bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void) setBottom: (CGFloat) newbottom {
    CGRect newframe   = self.frame;
    newframe.origin.y = newbottom - self.frame.size.height;
    self.frame        = newframe;
}

- (CGFloat) right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void) setRight: (CGFloat) newright {
    CGFloat delta       = newright - (self.frame.origin.x + self.frame.size.width);
    CGRect newframe     = self.frame;
    newframe.origin.x  += delta ;
    self.frame          = newframe;
}

- (CGFloat)x {
    return self.frame.origin.x;
}

- (void)setX:(CGFloat)x {
    CGRect frame    = self.frame;
    frame.origin.x  = x;
    self.frame      = frame;
}

- (CGFloat)y {
    return self.frame.origin.y;
}

- (void)setY:(CGFloat)y {
    CGRect frame    = self.frame;
    frame.origin.y  = y;
    self.frame      = frame;
}

- (CGFloat)centerX {
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX {
    CGPoint center  = self.center;
    center.x        = centerX;
    self.center     = center;
}

- (CGFloat)centerY {
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY {
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

/**
 *  Move via offset
    通过偏移
 *
 *  @since 1.0
 */
- (void) moveBy: (CGPoint) delta {
    CGPoint newcenter = self.center;
    newcenter.x += delta.x;
    newcenter.y += delta.y;
    self.center = newcenter;
}

/**
 *  Scaling
    缩放
 *
 *  @since 1.0
 */
- (void) scaleBy: (CGFloat) scaleFactor {
    CGRect newframe = self.frame;
    newframe.size.width *= scaleFactor;
    newframe.size.height *= scaleFactor;
    self.frame = newframe;
}

/**
 *  Ensure that both dimensions fit within the given size by scaling down
    确保两个尺寸配合在给定大小的缩放
 *
 *  @since 1.0
 */
- (void) fitInSize: (CGSize) aSize {
    CGFloat scale;
    CGRect newframe = self.frame;
    
    if (newframe.size.height && (newframe.size.height > aSize.height))
    {
        scale = aSize.height / newframe.size.height;
        newframe.size.width *= scale;
        newframe.size.height *= scale;
    }
    
    if (newframe.size.width && (newframe.size.width >= aSize.width))
    {
        scale = aSize.width / newframe.size.width;
        newframe.size.width *= scale;
        newframe.size.height *= scale;
    }
    
    self.frame = newframe;	
}

@end
