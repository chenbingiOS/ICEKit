//
//  ICENetwork.m
//  DemoProduct
//
//  Created by ttouch on 15/11/6.
//  Copyright © 2015年 iCE. All rights reserved.
//

#import "ICENetwork.h"
// md5加密
#import <CommonCrypto/CommonDigest.h>


#pragma mark - NSString扩展
/**
 *  NSString扩展
 */
@implementation NSString (ICENetwork)

// md5
- (NSString *)md5
{
    if (self == nil || self.length == 0)
    {
        return nil;
    }
    
    const char *value = [self UTF8String];
    unsigned char outputBuffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5(value, (CC_LONG)strlen(value), outputBuffer);
    
    NSMutableString *outputString = [[NSMutableString alloc] initWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for (NSInteger i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
    {
        [outputString appendFormat:@"%02x",outputBuffer[i]];
    }
    
    return outputString;
}

// 编码
- (NSString *)encode
{
    NSString *outputString  = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,
                                                                                                    (CFStringRef)self,
                                                                                                    NULL,
                                                                                                    (CFStringRef)@"!*'();:@&amp;=+$,/?%#[]",
                                                                                                    kCFStringEncodingUTF8
                                                                                                    ));
    
    outputString            = [outputString stringByReplacingOccurrencesOfString:@"<null>" withString:@""];
    
    return outputString;
}

// 解码
- (NSString *)decode
{
    NSString *outputString = (NSString *)CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,
                                                                                                                   (__bridge CFStringRef)self,
                                                                                                                   CFSTR(""),
                                                                                                                   kCFStringEncodingUTF8
                                                                                                                   ));
    return outputString;
}

// 字符串转字典对象
- (id)object
{
    id object = nil;
    @try
    {
        NSData *data    = [self dataUsingEncoding:NSUTF8StringEncoding];;
        object          = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    }
    @catch (NSException *exception)
    {
        NSLog(@"%s [Line %d] JSON字符串转换成对象出错了-->\n%@",__PRETTY_FUNCTION__, __LINE__,exception);
    }
    @finally
    {
        
    }
    return object;
}

@end


#pragma mark - NSObject扩展
/**
 *  NSObject扩展
 */
@implementation NSObject (ICENetwork)

// json转字符串
- (NSString *)json
{
    NSString *jsonString = @"";
    @try {
        NSData *jsonData    = [NSJSONSerialization dataWithJSONObject:self options:0 error:nil];
        jsonString          = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    @catch (NSException *exception) {
        NSLog(@"%s [Line %d] 对象转换成JSON字符串出错了-->\n%@",__PRETTY_FUNCTION__, __LINE__,exception);
    }
    @finally {
    }
    return jsonString;
}

@end

@interface ICENetwork ()

@property (nonatomic, strong) AFHTTPRequestOperationManager *operationManager; ///< http请求管理器

@end

@implementation ICENetwork

+ (id)sharedInstance {
    DEFINE_SHARED_INSTANCE_USING_BLOCK(^{
        return [[self alloc] init];
    });
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        // http接口请求管理器
        _operationManager = [AFHTTPRequestOperationManager manager];
        _operationManager.responseSerializer.acceptableContentTypes = nil;
        
        // 设置缓存
        NSURLCache *urlCache = [NSURLCache sharedURLCache];
        
        // 设置缓存的大小为5MB
        [urlCache setMemoryCapacity:5*1024*1024];
        [NSURLCache setSharedURLCache:urlCache];
    }
    return self;
}
/********************************************************************************************/
#pragma mark - 上传文件
- (AFHTTPRequestOperation *)uploadToUrl:(NSString *)url
                                 params:(NSDictionary *)params
                                  files:(NSArray *)files
                               complete:(void (^)(BOOL successed, NSDictionary *result))complete
{
    return [self uploadToUrl:url params:params files:files process:nil complete:complete];
}
//---------------
//  上传文件
//---------------
// 上传文件，可以查看进度 process_block



- (AFHTTPRequestOperation *)uploadToUrl:(NSString *)url
                                 params:(NSDictionary *)params
                                  files:(NSArray *)files
                                process:(void (^)(NSInteger writedBytes, NSInteger totalBytes))process
                               complete:(void (^)(BOOL successed, NSDictionary *result))complete
{
    params = [[self getRequestBodyWithParams:params] copy];
    
    NSLog(@"post request url:  %@  \npost params:  %@",url,params);
    
    NSMutableArray *mutableOperations = [NSMutableArray array];
    
    AFHTTPRequestSerializer *serializer = [AFHTTPRequestSerializer serializer];
    for (NSDictionary *fileItem in files) {
        NSMutableURLRequest *request = [serializer multipartFormRequestWithMethod:@"POST" URLString:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            //        for (NSDictionary *fileItem in files) {
            id value = [fileItem objectForKey:@"file"];        //支持四种数据类型：NSData、UIImage、NSURL、NSString
            NSString *name = [fileItem objectForKey:@"key"];            //文件字段的key
            NSString *fileName = [fileItem objectForKey:@"name"];       //文件名称
            NSString *mimeType = [fileItem objectForKey:@"type"];       //文件类型
            mimeType = mimeType ? mimeType : @"image/jpeg";
            name = name ? name : @"file";
            
            if ([value isKindOfClass:[NSData class]]) {
                [formData appendPartWithFileData:value name:name fileName:fileName mimeType:mimeType];
            }else if ([value isKindOfClass:[UIImage class]]) {
                if (UIImagePNGRepresentation(value)) {  //返回为png图像。
                    [formData appendPartWithFileData:UIImagePNGRepresentation(value) name:name fileName:fileName mimeType:mimeType];
                }else {   //返回为JPEG图像。
                    [formData appendPartWithFileData:UIImageJPEGRepresentation(value, 0.5) name:name fileName:fileName mimeType:mimeType];
                }
            }else if ([value isKindOfClass:[NSURL class]]) {
                [formData appendPartWithFileURL:value name:name fileName:fileName mimeType:mimeType error:nil];
            }else if ([value isKindOfClass:[NSString class]]) {
                [formData appendPartWithFileURL:[NSURL URLWithString:value]  name:name fileName:fileName mimeType:mimeType error:nil];
            }
            //        }
        } error:nil];
        
        AFHTTPRequestOperation *operation = nil;
        operation = [_operationManager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
            id response = [operation.responseString object]?:operation.responseString;
            NSLog(@"post responseObject:  %@",response);
//            if (complete) {
//                complete(true,[self dictionaryWithData:responseObject]);
//            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"post error :  %@",error);
//            if (complete) {
//                complete(false,nil);
//            }
        }];
        [operation setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
            float progress = (float)totalBytesWritten / totalBytesExpectedToWrite;
            NSLog(@"upload process: %.0f%% (%lld/%lld)",100*progress,totalBytesWritten,totalBytesExpectedToWrite);
            if (process) {
                process((NSUInteger)totalBytesWritten,(NSUInteger)totalBytesExpectedToWrite);
            }
        }];
        [mutableOperations addObject:operation];
    }
    
    NSArray *operations = [AFURLConnectionOperation batchOfRequestOperations:mutableOperations progressBlock:^(NSUInteger numberOfFinishedOperations, NSUInteger totalNumberOfOperations) {
        NSLog(@"%ld of %ld complete", (long)numberOfFinishedOperations, (long)totalNumberOfOperations);
        
    } completionBlock:^(NSArray *operations) {
        NSLog(@"All operations in batch complete");
        if (complete) {
            complete(true,nil);
        }
        
    }];
    [[NSOperationQueue mainQueue] addOperations:operations waitUntilFinished:NO];
    
    return nil;
    
    //    AFHTTPRequestOperation *operation = nil;
    //    operation = [_operationManager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
    //        id response = [operation.responseString object]?:operation.responseString;
    //        NSLog(@"post responseObject:  %@",response);
    //        if (complete) {
    //            complete(true,[self dictionaryWithData:responseObject]);
    //        }
    //    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    //        NSLog(@"post error :  %@",error);
    //        if (complete) {
    //            complete(false,nil);
    //        }
    //    }];
    
    //    [operation setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
    //        float progress = (float)totalBytesWritten / totalBytesExpectedToWrite;
    //        NSLog(@"upload process: %.0f%% (%lld/%lld)",100*progress,totalBytesWritten,totalBytesExpectedToWrite);
    //        if (process) {
    //            process((NSUInteger)totalBytesWritten,(NSUInteger)totalBytesExpectedToWrite);
    //        }
    //    }];
    //    [operation start];
    
    //    return operation;
}

/*
 - (AFHTTPRequestOperation *)uploadToUrl:(NSString *)url
 params:(NSDictionary *)params
 files:(NSArray *)files
 process:(void (^)(NSInteger writedBytes, NSInteger totalBytes))process
 complete:(void (^)(BOOL successed, NSDictionary *result))complete
 {
 params = [[self getRequestBodyWithParams:params] copy];
 
 NSLog(@"post request url:  %@  \npost params:  %@",url,params);
 
 AFHTTPRequestSerializer *serializer = [AFHTTPRequestSerializer serializer];
 
 NSMutableURLRequest *request = [serializer multipartFormRequestWithMethod:@"POST" URLString:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
 for (NSDictionary *fileItem in files) {
 id value = [fileItem objectForKey:@"file"];        //支持四种数据类型：NSData、UIImage、NSURL、NSString
 NSString *name = [fileItem objectForKey:@"key"];            //文件字段的key
 NSString *fileName = [fileItem objectForKey:@"name"];       //文件名称
 NSString *mimeType = [fileItem objectForKey:@"type"];       //文件类型
 mimeType = mimeType ? mimeType : @"image/jpeg";
 name = name ? name : @"file";
 
 if ([value isKindOfClass:[NSData class]]) {
 [formData appendPartWithFileData:value name:name fileName:fileName mimeType:mimeType];
 }else if ([value isKindOfClass:[UIImage class]]) {
 if (UIImagePNGRepresentation(value)) {  //返回为png图像。
 [formData appendPartWithFileData:UIImagePNGRepresentation(value) name:name fileName:fileName mimeType:mimeType];
 }else {   //返回为JPEG图像。
 [formData appendPartWithFileData:UIImageJPEGRepresentation(value, 0.5) name:name fileName:fileName mimeType:mimeType];
 }
 }else if ([value isKindOfClass:[NSURL class]]) {
 [formData appendPartWithFileURL:value name:name fileName:fileName mimeType:mimeType error:nil];
 }else if ([value isKindOfClass:[NSString class]]) {
 [formData appendPartWithFileURL:[NSURL URLWithString:value]  name:name fileName:fileName mimeType:mimeType error:nil];
 }
 }
 } error:nil];
 
 AFHTTPRequestOperation *operation = nil;
 operation = [_operationManager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
 id response = [operation.responseString object]?:operation.responseString;
 NSLog(@"post responseObject:  %@",response);
 if (complete) {
 complete(true,[self dictionaryWithData:responseObject]);
 }
 } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
 NSLog(@"post error :  %@",error);
 if (complete) {
 complete(false,nil);
 }
 }];
 
 [operation setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
 float progress = (float)totalBytesWritten / totalBytesExpectedToWrite;
 NSLog(@"upload process: %.0f%% (%lld/%lld)",100*progress,totalBytesWritten,totalBytesExpectedToWrite);
 if (process) {
 process((NSUInteger)totalBytesWritten,(NSUInteger)totalBytesExpectedToWrite);
 }
 }];
 [operation start];
 
 return operation;
 }
 */

#pragma mark - 下载文件
- (AFHTTPRequestOperation *)downloadFromUrl:(NSString *)url
                                   filePath:(NSString *)filePath
                                   complete:(void (^)(BOOL successed, NSDictionary *response))complete
{
    return [self downloadFromUrl:url params:nil filePath:filePath process:nil complete:complete];
}
//---------------
//  下载文件
//---------------
// 下载文件，可以查看进度 process_block
- (AFHTTPRequestOperation *)downloadFromUrl:(NSString *)url
                                     params:(NSDictionary *)params
                                   filePath:(NSString *)filePath
                                    process:(void (^)(NSInteger readBytes, NSInteger totalBytes))process
                                   complete:(void (^)(BOOL successed, NSDictionary *response))complete
{
    AFHTTPRequestSerializer *serializer = [AFHTTPRequestSerializer serializer];
    NSMutableURLRequest *request = [serializer requestWithMethod:@"GET" URLString:url parameters:params error:nil];
    NSLog(@"get request url: %@",[request.URL.absoluteString decode]);
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer.acceptableContentTypes = nil;
    
    NSString *tmpPath = [filePath stringByAppendingString:@".tmp"];
    operation.outputStream = [[NSOutputStream alloc] initToFileAtPath:tmpPath append:NO];
    
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *mimeTypeArray = @[@"text/html", @"application/json"];
        NSError *moveError = nil;
        if ([mimeTypeArray containsObject:operation.response.MIMEType]) {
            //返回的是json格式数据
            responseObject = [self dictionaryWithData:[NSData dataWithContentsOfFile:tmpPath]];
            [[NSFileManager defaultManager] removeItemAtPath:tmpPath error:nil];
            NSLog(@"get responseObject:  %@",responseObject);
        }else{
            [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
            [[NSFileManager defaultManager] moveItemAtPath:tmpPath toPath:filePath error:&moveError];
        }
        
        if (complete && !moveError) {
            complete(true,responseObject);
        }else{
            complete?complete(false,responseObject):nil;
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"get error :  %@",error);
        
        //        [operation resume];
        
        //        [[NSFileManager defaultManager] removeItemAtPath:tmpPath error:nil];
        if (complete) {
            complete(false,nil);
        }
    }];
    [operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
        float progress = (float)totalBytesRead / totalBytesExpectedToRead;
        NSLog(@"download process: %.0f%% (%lld/%lld)",100*progress,totalBytesRead,totalBytesExpectedToRead);
        if (process) {
            process((NSUInteger)totalBytesRead,(NSUInteger)totalBytesExpectedToRead);
        }
    }];
    
    [operation start];
    
    return operation;
}
/********************************************************************************************/
#pragma mark - 发起http网络请求
- (void)requestToUrl:(NSString *)url
          httpMethod:(NSString *)httpMethod
            useCache:(BOOL)useCache
              params:(NSDictionary *)params
            complete:(void (^)(BOOL successed, NSDictionary *result))complete
{
    NSMutableURLRequest *request = [self requestWithUrl:url httpMethod:httpMethod useCache:useCache params:params];
    void (^requestSuccessBlock)(AFHTTPRequestOperation *operation, id responseObject) = ^(AFHTTPRequestOperation *operation, id responseObject)
    {
        [self logWithOperation:operation httpMethod:httpMethod params:params];
        complete ? complete(true, [self dictionaryWithData:responseObject]) : nil;
    };
    void (^requestFailureBlock)(AFHTTPRequestOperation *operation, NSError *error) = ^(AFHTTPRequestOperation *operation, NSError *error)
    {
        [self logWithOperation:operation httpMethod:httpMethod params:params];
        complete ? complete(false, nil) : nil;
    };
    
    AFHTTPRequestOperation *operation = nil;
    if (useCache)
    {
        operation = [self cacheOperationWithRequest:request success:requestSuccessBlock failure:requestFailureBlock];
    }
    else
    {
        operation = [_operationManager HTTPRequestOperationWithRequest:request success:requestSuccessBlock failure:requestFailureBlock];
    }
    [_operationManager.operationQueue addOperation:operation];
}

#pragma mark - 返回请求request
- (NSMutableURLRequest *)requestWithUrl:(NSString *)url
                             httpMethod:(NSString *)httpMethod
                               useCache:(BOOL)useCache
                                 params:(NSDictionary *)params
{
    params = [[self getRequestBodyWithParams:params] copy];
    
    AFHTTPRequestSerializer *serializer = [AFHTTPRequestSerializer serializer];
    NSMutableURLRequest *request        = [serializer requestWithMethod:httpMethod URLString:url parameters:params error:nil];
    
    // 设置超时时间
    [request setTimeoutInterval:20];
    
    // 追加用户KEY
    //    [request addValue: @"6f8372f84cec104675a8bed65856c77c" forHTTPHeaderField: @"apikey"];
    
    // 使用了缓存
    if (useCache)
    {
        [request setCachePolicy:NSURLRequestReturnCacheDataElseLoad];
    }
    
    return request;
}

#pragma mark - 返回请求体的参数字典
- (NSMutableDictionary *)getRequestBodyWithParams:(NSDictionary *)params
{
    // 请求体字典赋值
    NSMutableDictionary *requestBody = params ? [params mutableCopy] : [[NSMutableDictionary alloc] init];
    
    // 遍历参数体里的数据
    for (NSString *key in [params allKeys])
    {
        id value = [params objectForKey:key];
        if ([value isKindOfClass:[NSDate class]])
        {
            [requestBody setValue:@([value timeIntervalSince1970]*1000) forKey:key];
        }
        
        if ([value isKindOfClass:[NSDictionary class]] || [value isKindOfClass:[NSArray class]])
        {
            [requestBody setValue:[value json] forKey:key];
        }
    }
    
    //    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    //    if (token)
    //    {
    //        [requestBody setObject:token forKey:@"token"];
    //    }
    //    [requestBody setObject:@"ios" forKey:@"genus"];
    
    return requestBody;
}

#pragma mark - 日志
- (void)logWithOperation:(AFHTTPRequestOperation *)operation httpMethod:(NSString *)httpMethod params:(NSDictionary *)params
{
    if ([[httpMethod uppercaseString] isEqualToString:@"GET"])
    {
        NSLog(@"\nget request url : %@  \n",[operation.request.URL.absoluteString decode]);
    }
    else
    {
        NSLog(@"\n%@ request url : %@  \npost params:  %@\n",[httpMethod lowercaseString],[operation.request.URL.absoluteString decode],params);
    }
    
    if (operation.error)
    {
        NSLog(@"\n%@ error : %@",[httpMethod lowercaseString],operation.error);
    }
    else
    {
        id response = [operation.responseString object]?:operation.responseString;
        NSLog(@"\n%@ responseObject : %@",[httpMethod lowercaseString],response);
    }
}

#pragma mark - 缓存数据请求
- (AFHTTPRequestOperation *)cacheOperationWithRequest:(NSURLRequest *)urlRequest
                                              success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                              failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    AFHTTPRequestOperation *operation = [_operationManager HTTPRequestOperationWithRequest:urlRequest success:^(AFHTTPRequestOperation *operation, id responseObject){
        
        NSCachedURLResponse *cachedURLResponse = [[NSURLCache sharedURLCache] cachedResponseForRequest:urlRequest];
        
        // store in cache
        cachedURLResponse = [[NSCachedURLResponse alloc] initWithResponse:operation.response data:operation.responseData userInfo:nil storagePolicy:NSURLCacheStorageAllowed];
        [[NSURLCache sharedURLCache] storeCachedResponse:cachedURLResponse forRequest:urlRequest];
        
        success(operation,responseObject);
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (error.code == kCFURLErrorNotConnectedToInternet)
        {
            NSCachedURLResponse *cachedResponse = [[NSURLCache sharedURLCache] cachedResponseForRequest:urlRequest];
            if (cachedResponse != nil && [[cachedResponse data] length] > 0)
            {
                success(operation, cachedResponse.data);
            }
            else
            {
                failure(operation, error);
            }
        }
        else
        {
            failure(operation, error);
        }
    }];
    
    return operation;
}

#pragma mark - 数据转换
- (id)dictionaryWithData:(id)data
{
    NSDictionary *object = data;
    if ([data isKindOfClass:[NSData class]])
    {
        object = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    }
    
    if ([data isKindOfClass:[NSString class]])
    {
        object = [data object];
    }
    
    return object?:data;
}
/********************************************************************************************/

#pragma mark - 外部请求对象方法
// POST 请求
- (void)postRequestToUrl:(NSString *)url
                  params:(NSDictionary *)params
                complete:(void (^)(BOOL successed, NSDictionary *result))complete
{
    [self requestToUrl:url httpMethod:@"POST" useCache:YES params:params complete:complete];
}

// GET 请求
- (void)getRequestToUrl:(NSString *)url
                 params:(NSDictionary *)params
               complete:(void (^)(BOOL successed, NSDictionary *result))complete
               useCache:(BOOL)useCache
{
    [self requestToUrl:url httpMethod:@"GET" useCache:useCache params:params complete:complete];
}

#pragma mark - 外部请求类方法
// POST 请求
+ (void)postRequestToUrl:(NSString *)url
                  params:(NSDictionary *)params
                complete:(void (^)(BOOL successed, NSDictionary *result))complete {
    [[ICENetwork sharedInstance] postRequestToUrl:url params:params complete:complete];
}

// GET 请求
+ (void)getRequestToUrl:(NSString *)url
                 params:(NSDictionary *)params
               complete:(void (^)(BOOL successed, NSDictionary *result))complete
{
    [self getRequestToUrl:url params:params complete:complete useCache:NO];
}

// GET 请求
+ (void)getRequestToUrl:(NSString *)url
                 params:(NSDictionary *)params
               complete:(void (^)(BOOL successed, NSDictionary *result))complete
               useCache:(BOOL)useCache
{
    [[ICENetwork sharedInstance] getRequestToUrl:url params:params complete:complete useCache:useCache];
}
@end
