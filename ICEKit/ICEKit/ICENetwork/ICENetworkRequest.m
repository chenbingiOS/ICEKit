//
//  ICENetworkRequest.m
//  DemoProduct
//
//  Created by 陈冰 on 15/11/7.
//  Copyright © 2015年 iCE. All rights reserved.
//

#import "ICENetworkRequest.h"
#import "ICENetwork.h"
#import "ICEHUD.h"

@implementation ICENetworkRequest

+ (void)POST:(NSString *)url params:(NSDictionary *)aParams complete:(void (^)(NSDictionary *result))complete {
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        [ICEHUD HUDShow];
    });
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [ICENetwork postRequestToUrl:url params:aParams complete:^(BOOL successed, NSDictionary *result) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                [ICEHUD HUDHide];
                if (successed) {
                    if ([result[@"status"] isEqual:@(1)]) {
                        complete(result[@"data"]);
                    } else {
                        [ICEHUD HUDShowHint:result[@"msg"]];
                        [JDStatusBarNotification showWithStatus:result[@"msg"] dismissAfter:3.0f];
                    }
                } else {
                    [JDStatusBarNotification showWithStatus:NSLocalizedString(@"errMsg.net", @"Net Error") dismissAfter:3.0f];
                }
            });
        }];
    });
}

+ (void)GET:(NSString *)url params:(NSDictionary *)aParams complete:(void (^)(NSDictionary *result))complete {
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        [ICEHUD HUDShow];
    });
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [ICENetwork getRequestToUrl:url params:aParams complete:^(BOOL successed, NSDictionary *result) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                [ICEHUD HUDHide];
                if (successed) {
                    if ([result[@"errNum"] isEqual:@(0)]) {
                        complete(result[@"retData"]);
                    } else {
                        [ICEHUD HUDShowHint:result[@"errMsg"]];
                        [JDStatusBarNotification showWithStatus:result[@"errMsg"] dismissAfter:3.0f];
                    }
                } else {
                    [JDStatusBarNotification showWithStatus:NSLocalizedString(@"errMsg.net", @"Net Error") dismissAfter:3.0f];
                }
            });
        }];
    });
}

+ (void)upload:(NSString *)url
        params:(NSDictionary *)aParams
         files:(NSArray *)files
       process:(void (^)(NSInteger writedBytes, NSInteger totalBytes))process
      complete:(void (^)(NSDictionary *result))complete {
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        [ICEHUD HUDShow];
    });
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [[ICENetwork sharedInstance]
         uploadToUrl:url
         params:aParams
         files:files
         process:process
         complete:^(BOOL successed, NSDictionary *result) {
             dispatch_async(dispatch_get_main_queue(), ^{
                 [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                 [ICEHUD HUDHide];
                 if (successed) {
                     if ([result[@"status"] isEqual:@(0)]) {
                         complete(result[@"data"]);
                     } else {
                         [ICEHUD HUDShowHint:result[@"msg"]];
                         [JDStatusBarNotification showWithStatus:result[@"msg"] dismissAfter:3.0f];
                     }
                 } else {
                     [JDStatusBarNotification showWithStatus:NSLocalizedString(@"errMsg.net", @"Net Error") dismissAfter:3.0f];
                 }
             });
         }];
    });
}

@end
