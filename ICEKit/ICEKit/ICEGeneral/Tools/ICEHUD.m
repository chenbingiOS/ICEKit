//
//  ICEHUD.m
//  DemoProduct
//
//  Created by ttouch on 15/11/9.
//  Copyright © 2015年 iCE. All rights reserved.
//

#import "ICEHUD.h"
#import "MBProgressHUD.h"
#import <objc/runtime.h>

static const void *HUDKey = &HUDKey;

@implementation ICEHUD

+ (MBProgressHUD *)HUD{
    return objc_getAssociatedObject(self, HUDKey);
}

+ (void)setHUD:(MBProgressHUD *)HUD{
    objc_setAssociatedObject(self, HUDKey, HUD, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (void)HUDHide{
    [[self HUD] hide:YES];
    [[self HUD] removeFromSuperview];
}

+ (void)HUDShow {
    UIView *view        = [[UIApplication sharedApplication].delegate window];
    MBProgressHUD *HUD  = [[MBProgressHUD alloc] initWithView:view];
    HUD.color           = [[UIColor alloc] initWithWhite:0 alpha:0.5f];
    [view addSubview:HUD];
    [HUD show:YES];
    [self setHUD:HUD];
}

+ (void)HUDShowHint:(NSString *)hint {
    UIView *view                    = [[UIApplication sharedApplication].delegate window];
    MBProgressHUD *HUD              = [MBProgressHUD showHUDAddedTo:view animated:YES];
    HUD.color                       = [[UIColor alloc] initWithWhite:0 alpha:0.5f];
    HUD.mode                        = MBProgressHUDModeText;
    HUD.labelText                   = hint;
    HUD.margin                      = 8.0f;
    HUD.removeFromSuperViewOnHide   = YES;
    HUD.userInteractionEnabled      = NO;
    HUD.yOffset                     = __kScreenHeight/2.0*0.382;
    [HUD hide:YES afterDelay:3.0f];
}

+ (void)HUDShowHint:(NSString *)hint view:(UIView *)view {
    MBProgressHUD *HUD      = [[MBProgressHUD alloc] initWithView:view];
    HUD.color               = [[UIColor alloc] initWithWhite:0 alpha:0.5f];
    HUD.labelText           = hint;
    [view addSubview:HUD];
    [HUD show:YES];
    [self setHUD:HUD];
}
@end
