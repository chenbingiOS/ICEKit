//
//  UIViewController+ICEUUPhoto.m
//  DemoProduct
//
//  Created by ttouch on 15/11/5.
//  Copyright © 2015年 iCE. All rights reserved.
//

#import "UIViewController+ICEUUPhoto.h"
#import <objc/runtime.h>
#import "UUPhotoActionSheet.h"
#import "UUPhoto-Macros.h"
#import "UUPhoto-Import.h"

static const void *UUPhotoActionSheetKey = &UUPhotoActionSheetKey;

@interface UIViewController () <UUPhotoActionSheetDelegate>
@property (nonatomic, strong) UUPhotoActionSheet *sheet;
@end

@implementation UIViewController (ICEUUPhoto)

- (UUPhotoActionSheet *)sheet{
    return objc_getAssociatedObject(self, UUPhotoActionSheetKey);
}

- (void)setSheet:(UUPhotoActionSheet *)sheet {
    objc_setAssociatedObject(self, UUPhotoActionSheetKey, sheet, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)configUUPhotoWithMaxSelected:(NSInteger)aNum {
    UUAssetManager *mana = [UUAssetManager sharedInstance];
    [mana sendSelectedPhotos:4];
    UUPhotoActionSheet *sheet = [[UUPhotoActionSheet alloc] initWithMaxSelected:aNum weakSuper:self];
    sheet.delegate = self;
    [self setSheet:sheet];
    UIView *view = [[UIApplication sharedApplication].delegate window];
    [view addSubview:sheet];
}

- (void)removeUUPhoto {
    [self.sheet removeFromSuperview];
}
#pragma mark - Event Response

- (void)showUUPhoto {
    [self.sheet showAnimation];
}

#pragma mark - Custom Deledate
/** 使用这个类需要实现该协议下的方法 */
//- (void)actionSheetDidFinished:(NSArray *)obj {    
//    NSLog(@"已发送 %lu 图片",(unsigned long)obj.count);
//    [self removeUUPhoto];
//}

@end
