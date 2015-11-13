//
//  AppDelegate+GeTui.m
//  kuaile
//
//  Created by ttouch on 15/9/15.
//  Copyright (c) 2015年 ttouch. All rights reserved.
//

#import "AppDelegate+GeTui.h"

#import "ICEPublic.h"

//------------------------------------
// 个推
//------------------------------------
#import "GeTuiSdk.h"
#define kAppId           @"8o33AhyApE7fzXSP01ORY8"
#define kAppKey          @"tCCKfjUkEw7WSGHAVhoBAA"
#define kAppSecret       @"WcXmQ21ykR6rv2ATgIS1I6"

NSString* const NotificationCategoryIdent  = @"ACTIONABLE";
NSString* const NotificationActionOneIdent = @"ACTION_ONE";
NSString* const NotificationActionTwoIdent = @"ACTION_TWO";

@interface AppDelegate () <GeTuiSdkDelegate>

@end

@implementation AppDelegate (GeTui)

//----------------------------------------
// 个推
//----------------------------------------
#pragma mark -初始化个推
- (void)initGeTui:(NSDictionary *)launchOptions {
    NSError *error = nil;
    
    [GeTuiSdk startSdkWithAppId:kAppId appKey:kAppKey appSecret:kAppSecret delegate:self error:&error];
    
    //[2]:注册APNS
    [self registerRemoteNotification];
    
    //［2-EXT]: 获取启动时收到的APN数据
    NSDictionary* message=[launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    
    if (message) {
        NSString*payloadMsg = [message objectForKey:@"payload"];
        
        NSString*record = [NSString stringWithFormat:@"[APN]%@,%@",[NSDate date],payloadMsg];
        NSLog(@"record00 = %@",record);
        //[_viewController logMsg:record];
    }
}

- (void)registerRemoteNotification {
    
#ifdef __IPHONE_8_0
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        //IOS8 新的通知机制category注册
        UIMutableUserNotificationAction *action1;
        action1 = [[UIMutableUserNotificationAction alloc] init];
        [action1 setActivationMode:UIUserNotificationActivationModeBackground];
        [action1 setTitle:@"取消"];
        [action1 setIdentifier:NotificationActionOneIdent];
        [action1 setDestructive:NO];
        [action1 setAuthenticationRequired:NO];
        
        UIMutableUserNotificationAction *action2;
        action2 = [[UIMutableUserNotificationAction alloc] init];
        [action2 setActivationMode:UIUserNotificationActivationModeBackground];
        [action2 setTitle:@"回复"];
        [action2 setIdentifier:NotificationActionTwoIdent];
        [action2 setDestructive:NO];
        [action2 setAuthenticationRequired:NO];
        
        UIMutableUserNotificationCategory *actionCategory;
        actionCategory = [[UIMutableUserNotificationCategory alloc] init];
        [actionCategory setIdentifier:NotificationCategoryIdent];
        [actionCategory setActions:@[action1, action2]
                        forContext:UIUserNotificationActionContextDefault];
        
        NSSet *categories = [NSSet setWithObject:actionCategory];
        UIUserNotificationType types = (UIUserNotificationTypeAlert|
                                        UIUserNotificationTypeSound|
                                        UIUserNotificationTypeBadge);
        
        UIUserNotificationSettings *settings;
        settings = [UIUserNotificationSettings settingsForTypes:types categories:categories];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        
    } else {
        UIRemoteNotificationType apn_type = (UIRemoteNotificationType)(UIRemoteNotificationTypeAlert|
                                                                       UIRemoteNotificationTypeSound|
                                                                       UIRemoteNotificationTypeBadge);
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:apn_type];
    }
#else
    UIRemoteNotificationType apn_type = (UIRemoteNotificationType)(UIRemoteNotificationTypeAlert|
                                                                   UIRemoteNotificationTypeSound|
                                                                   UIRemoteNotificationTypeBadge);
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:apn_type];
#endif
    
}

#pragma mark 个推注册
///唤醒
- (void)application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    //[5] Background Fetch 恢复SDK 运行
    [GeTuiSdk resume];
    
    completionHandler(UIBackgroundFetchResultNewData);
}

#pragma mark 像APPLE请求Token
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    NSString *token = [[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    NSString *strDeviceToken = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"deviceToken:%@", strDeviceToken);
    DEFINE_PERSISTENT_SET_OBJECT(strDeviceToken, __kNotiDeviceToken);
    // [3]:向个推服务器注册deviceToken
    [GeTuiSdk registerDeviceToken:strDeviceToken];
}

#pragma mark 如果APNS注册失败通知个推服务器
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error {
    //[3-EXT]:如果APNS注册失败，通知个推服务器
    [GeTuiSdk registerDeviceToken:DEFINE_PERSISTENT_GET_OBJECT(__kNotiDeviceToken)];
}

#pragma mark 当用户点击状态栏的时会调用
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userinfo {
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    // [4-EXT]:处理APN
    NSString *payloadMsg = [userinfo objectForKey:@"payload"];
    NSLog(@"payloadMsg:%@",payloadMsg);
    
    NSString *record = [NSString stringWithFormat:@"[APN]%@, %@", [NSDate date], payloadMsg];
    
    NSLog(@"record11 = %@",record);
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"苹果" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
    [alertView show];
    //[_viewController logMsg:record];
}

#pragma mark 当用户点击状态栏的时会调用
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler {
    
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    // [4-EXT]:处理APN
    NSString *payloadMsg = [userInfo objectForKey:@"payload"];
    
    NSDictionary *aps = [userInfo objectForKey:@"aps"];
    
    NSNumber *contentAvailable = aps == nil ? nil : [aps objectForKeyedSubscript:@"content-available"];
    
    NSString *record = [NSString stringWithFormat:@"[APN]%@, %@, [content-available: %@]", [NSDate date], payloadMsg, contentAvailable];
    NSLog(@"record22 = %@",record);
    
    //初始化抢单页面
    //    ICESnatchViewController *iCESnatch = [[ICESnatchViewController alloc] initWithNibName:@"ICESnatchViewController" bundle:[NSBundle mainBundle]];
    
    //robOrder.orderId = [aps objectForKey:@"alert"];
    
    //可变数组
    //    NSMutableArray *array = [[NSMutableArray alloc] init];
    //    [array addObject:[aps objectForKey:@"alert"]];
    //    DEF_PERSISTENT_SET_OBJECT([NSArray arrayWithArray:array], DEF_USER_MUTABLE_ARY_ORDER);
    
    //    NSLog(@"DEF_PERSISTENT_GET_OBJECT%@",DEF_PERSISTENT_GET_OBJECT(DEF_USER_MUTABLE_ARY_ORDER));
    
    //    [nav pushViewController:iCESnatch animated:YES];
    
    completionHandler(UIBackgroundFetchResultNewData);
}

#pragma mark 启动GeTui
- (void)startSdkWith:(NSString *)appID appKey:(NSString *)appKey appSecret:(NSString *)appSecret {
    
    NSError *err = nil;
    //[1-1]:通过 AppId、 appKey 、appSecret 启动SDK
    [GeTuiSdk startSdkWithAppId:appID appKey:appKey appSecret:appSecret delegate:self error:&err];
    
    //[1-2]:设置是否后台运行开关
    [GeTuiSdk runBackgroundEnable:YES];
    
    //[1-3]:设置电子围栏功能，开启LBS定位服务 和 是否允许SDK 弹出用户定位请求
    [GeTuiSdk lbsLocationEnable:YES andUserVerify:YES];
}

- (void)stopSdk {
    [GeTuiSdk enterBackground];
}

//SDK启动成功返回clientId
#pragma mark - GeTuiSdkDelegate
- (void)GeTuiSdkDidRegisterClient:(NSString *)clientId {
    //[4-EXT-1]: 个推SDK已注册，返回clientId
    //获取完ClientID保存在本地
    DEFINE_PERSISTENT_SET_OBJECT(clientId, __kNotiClientID);
    if (DEFINE_PERSISTENT_GET_OBJECT(__kNotiDeviceToken))
    {
        [GeTuiSdk registerDeviceToken:DEFINE_PERSISTENT_GET_OBJECT(__kNotiDeviceToken)];
    }
}

//ios的话 可以把要跳转的信息写到setpushinfo的payload里面 客户端收到payload之后去解析跳转 也可以把跳转信息放到透传消息里面 客户端收到透传之后解析跳转
#pragma mark -SDK收到透传消息回调
- (void)GeTuiSdkDidReceivePayload:(NSString *)payloadId andTaskId:(NSString*)taskId andMessageId:(NSString*)aMsgId fromApplication:(NSString *)appId {
    
    //    DLog(@"payloadId %@", payloadId);
    //    DLog(@"taskId %@", taskId);
    //    DLog(@"aMsgId %@", aMsgId);
    //    DLog(@"appId %@", appId);
    
    [self showAlertView:aMsgId];
    
    //[4]:收到个推消息
    NSData *payload = [GeTuiSdk retrivePayloadById:payloadId];
    if (payload)
    {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:payload options:NSJSONReadingMutableContainers error:nil];
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            //发送订单请求
            NSLog(@"-----------------------------------------------------------收到透传");
            NSLog(@"%@", dict);
            if (dict[@"type"] != nil) {
                NSNumber *num = dict[@"type"];
                switch ([num integerValue]) {
                    case 0:
                    {
                    }
                        break;
                    case 1:
                    {
//                        // 收到订单推送
//                        [self sendOrderRequest:dict[@"data"]];
//                        dispatch_async(dispatch_get_main_queue(), ^{
//                            [JDStatusBarNotification showWithStatus:@"您有新的订单！" dismissAfter:5.0 styleName:ICEStyle1];
//                        });
                    }
                        break;
                    case 2:
                    {
//                        // 配单成功
//                        [self deployOrderRequest:dict[@"data"]];
//                        dispatch_async(dispatch_get_main_queue(), ^{
//                            [JDStatusBarNotification showWithStatus:@"您的订单已分配！" dismissAfter:5.0 styleName:ICEStyle1];
//                        });
                    }
                        break;
                    case 3:
                    {
//                        // 付款成功
//                        [self payMoneyOrderRequest:dict[@"data"]];
//                        dispatch_async(dispatch_get_main_queue(), ^{
//                            [JDStatusBarNotification showWithStatus:@"用户已付款！" dismissAfter:5.0 styleName:ICEStyle1];
//                        });
                    }
                        break;
                    default:
                        break;
                }
            }
        });
    }
}

#pragma mark -显示弹窗
- (void)showAlertView:(NSString *)string {
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:string delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alertView show];
    // 保存数据库数据
}

//SDK收到sendMessage消息回调
- (void)GeTuiSdkDidSendMessage:(NSString *)messageId result:(int)result {
    NSString *record = [NSString stringWithFormat:@"Received sendmessage:%@ result:%d", messageId, result];
    NSLog(@"record %ld",(long)record);
}

//SDK遇到错误回调
- (void)GeTuiSdkDidOccurError:(NSError *)error {
    //[EXT]:个推错误报告，集成步骤发生的任何错误都在这里通知，如果集成后，无法正常收到消息，查看这里的通知。
    NSLog(@"个推错误返回%ld %@",(long)error.code,error.localizedDescription);
}

//SDK运行状态通知
- (void)GeTuiSDkDidNotifySdkState:(SdkStatus)aStatus {
    NSLog(@"%d",aStatus);
}
//----------------------------------------
// 个推
//----------------------------------------

@end
