//
//  ICENetworkRequest.h
//  DemoProduct
//
//  Created by 陈冰 on 15/11/7.
//  Copyright © 2015年 iCE. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ICENetworkRequest : NSObject

+ (void)POST:(NSString *)url params:(NSDictionary *)aParams complete:(void (^)(NSDictionary *result))complete;

+ (void)GET:(NSString *)url params:(NSDictionary *)aParams complete:(void (^)(NSDictionary *result))complete;

+ (void)upload:(NSString *)url
        params:(NSDictionary *)aParams
         files:(NSArray *)files
       process:(void (^)(NSInteger writedBytes, NSInteger totalBytes))process
      complete:(void (^)(NSDictionary *result))complete;

//+ (void)download:(NSString *)url params:(NSDictionary *)aParams complete:(void (^)(NSDictionary *result))complete;
@end
