//
//  ICEReach.m
//  DemoProduct
//
//  Created by ttouch on 15/11/6.
//  Copyright © 2015年 iCE. All rights reserved.
//

#import "ICEReach.h"
#import "Reachability.h"

@interface ICEReach ()
@property(nonatomic, strong) Reachability *hostReach;
@property(nonatomic, strong) Reachability *localWiFiReach;
@property(nonatomic, strong) Reachability *internetConnectionReach;
@end

@implementation ICEReach

+ (id)sharedInstance {
    DEFINE_SHARED_INSTANCE_USING_BLOCK(^{
        return [[self alloc] init];
    });
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.hasEnableConnect = YES;
        self.isShowJDStatus = YES;
    }
    return self;
}

//---------------------------------
//  检测网络连接
//---------------------------------
- (void)settingHostReach {
    _hostReach = [Reachability reachabilityWithHostname:@"www.baidu.com"];
    [_hostReach startNotifier];
    __weak typeof(self) weakSelf = self;
    _hostReach.reachableBlock = ^(Reachability * reachability) {
        NSString * temp = [NSString stringWithFormat:@"HostReach Block Says Reachable(%@)", reachability.currentReachabilityString];
        NSLog(@"%@", temp);
        [weakSelf enableConnect:reachability];
    };
    _hostReach.unreachableBlock = ^(Reachability * reachability) {
        NSString * temp = [NSString stringWithFormat:@"HostReach Block Says Unreachable(%@)", reachability.currentReachabilityString];
        NSLog(@"%@", temp);
        [weakSelf unEnableConnect:reachability];
    };
}

- (void)settingLocalWiFiReach {
    _localWiFiReach = [Reachability reachabilityForLocalWiFi];
    // we ONLY want to be reachable on WIFI - cellular is NOT an acceptable connectivity
    _localWiFiReach.reachableOnWWAN = NO;
    [_localWiFiReach startNotifier];
    __weak typeof(self) weakSelf = self;
    _localWiFiReach.reachableBlock = ^(Reachability * reachability)
    {
        NSString * temp = [NSString stringWithFormat:@"LocalWIFI Block Says Reachable(%@)", reachability.currentReachabilityString];
        NSLog(@"%@", temp);
        [weakSelf enableConnect:reachability];
    };
    
    _localWiFiReach.unreachableBlock = ^(Reachability * reachability)
    {
        NSString * temp = [NSString stringWithFormat:@"LocalWIFI Block Says Unreachable(%@)", reachability.currentReachabilityString];
        
        NSLog(@"%@", temp);
        [weakSelf unEnableConnect:reachability];
    };
}

- (void)settingInternetConnectionReach{
    // create a Reachability object for the internet
    _internetConnectionReach = [Reachability reachabilityForInternetConnection];
    [_internetConnectionReach startNotifier];
    __weak typeof(self) weakSelf = self;
    _internetConnectionReach.reachableBlock = ^(Reachability * reachability) {
        NSString * temp = [NSString stringWithFormat:@" InternetConnection Says Reachable(%@)", reachability.currentReachabilityString];
        NSLog(@"%@", temp);
        [weakSelf enableConnect:reachability];
    };
    
    _internetConnectionReach.unreachableBlock = ^(Reachability * reachability) {
        NSString * temp = [NSString stringWithFormat:@"InternetConnection Block Says Unreachable(%@)", reachability.currentReachabilityString];
        NSLog(@"%@", temp);
        [weakSelf unEnableConnect:reachability];
    };
}

- (void)enableConnect:(Reachability *)reachability {
    self.hasEnableConnect = YES;
    NSString *strCurReach = [NSString stringWithFormat:@"%@ %@", reachability.currentReachabilityString, NSLocalizedString(@"errMsg.reaHas", @"Has been connected")];
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.isShowJDStatus) {
            [JDStatusBarNotification showWithStatus:strCurReach dismissAfter:2.0f];
        }
    });
}

- (void)unEnableConnect:(Reachability *)reachability {
    self.hasEnableConnect = NO;
    NSString *strCurReach = [NSString stringWithFormat:@"%@ %@", reachability.currentReachabilityString, NSLocalizedString(@"errMsg.reaLose", @"Lose connection")];
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.isShowJDStatus) {
            [JDStatusBarNotification showWithStatus:strCurReach dismissAfter:2.0f];
        }
    });
}


@end
