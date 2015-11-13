//
//  ICENetwork.h
//  DemoProduct
//
//  Created by ttouch on 15/11/6.
//  Copyright © 2015年 iCE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface ICENetwork : NSObject

+ (id)sharedInstance;

// POST 请求
+ (void)postRequestToUrl:(NSString *)url
                  params:(NSDictionary *)params
                complete:(void (^)(BOOL successed, NSDictionary *result))complete;

// GET 请求
+ (void)getRequestToUrl:(NSString *)url
                 params:(NSDictionary *)params
               complete:(void (^)(BOOL successed, NSDictionary *result))complete;
// GET 请求
+ (void)getRequestToUrl:(NSString *)url
                 params:(NSDictionary *)params
               complete:(void (^)(BOOL successed, NSDictionary *result))complete
               useCache:(BOOL)useCache;

#pragma mark - 上传文件
/**
 *  暂停，恢复，取消
 */
//- (void)pause;
//- (void)resume;
//- (void)cancel;


/**
 *  上传文件
 *
 *  可以暂停、重新开启、取消 [operation pause]、[operation resume];、[operation cancel];
 *
 *  @param url      请求URL
 *  @param params   请求参数
 *  @param files    上传的文件数组，数组里为多个字典字
 *                  典里的key:
 *                  1、name: 文件名称（如：demo.jpg）
 *                  2、file: 文件   （支持四种数据类型：NSData、UIImage、NSURL、NSString）NSURL、NSString为文件路径
 *                  3、key : 文件对应字段的key（默认：file）
 *                  4、type: 文件类型（默认：image/jpeg）
 *                  示例： @[@{@"file":_headImg.currentBackgroundImage,@"name":@"head.jpg"}];
 *
 *  @param complete 上传完成
 *
 *  @return
 */
- (AFHTTPRequestOperation *)uploadToUrl:(NSString *)url
                                 params:(NSDictionary *)params
                                  files:(NSArray *)files
                               complete:(void (^)(BOOL successed, NSDictionary *result))complete;

// 可以查看进度 process_block
- (AFHTTPRequestOperation *)uploadToUrl:(NSString *)url
                                 params:(NSDictionary *)params
                                  files:(NSArray *)files
                                process:(void (^)(NSInteger writedBytes, NSInteger totalBytes))process
                               complete:(void (^)(BOOL successed, NSDictionary *result))complete;

#pragma mark - 下载文件
/*
 filePath : 下载文件的存储路径
 response : 接口返回的不是文件而是json数据
 process  : 进度
 */
/**
 *  下载文件
 *
 *  @param url      下载请求的URL
 *  @param filePath 下载文件的存储路径
 *  @param complete 下载完成
 *
 *  @return
 */
- (AFHTTPRequestOperation *)downloadFromUrl:(NSString *)url
                                   filePath:(NSString *)filePath
                                   complete:(void (^)(BOOL successed, NSDictionary *response))complete;

// 可以查看进度 process_block
- (AFHTTPRequestOperation *)downloadFromUrl:(NSString *)url
                                     params:(NSDictionary *)params
                                   filePath:(NSString *)filePath
                                    process:(void (^)(NSInteger readBytes, NSInteger totalBytes))process
                                   complete:(void (^)(BOOL successed, NSDictionary *response))complete;

@end
