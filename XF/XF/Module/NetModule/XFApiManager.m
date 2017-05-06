//
//  XFNetEnginee.m
//  XF
//
//  Created by Frank on 16/9/17.
//  Copyright © 2016年 free. All rights reserved.
//

#import "XFApiManager.h"
#import "XFHelper.h"

@implementation XFApiManager

+ (id)sharedInstance {
    static XFApiManager * _apiManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        _apiManager = [[XFApiManager alloc] initWithBaseURL:[NSURL URLWithString:kServerURL]];
        [_apiManager addBascDataToHeader];
    });
    return _apiManager;
}

// Header中的基础数据
- (void)addBascDataToHeader {
    XFConfig * config = [XFConfig sharedInstance];
    [self.requestSerializer setValue:[config appVersion] forHTTPHeaderField:@"appname"];
    [self.requestSerializer setValue:[config appVersion] forHTTPHeaderField:@"appversion"];
    [self.requestSerializer setValue:[config deviceSystemName] forHTTPHeaderField:@"osname"];
    [self.requestSerializer setValue:[config deviceSystemVersion] forHTTPHeaderField:@"osversion"];
    [self.requestSerializer setValue:[config deviceName] forHTTPHeaderField:@"devicename"];
    [self.requestSerializer setValue:[config deviceName] forHTTPHeaderField:@"devicemodel"];
    [self.requestSerializer setValue:[config deviceName] forHTTPHeaderField:@"deviceid"];
    [self.requestSerializer setValue:[XFHelper dateToTimeStamp:[NSDate dateWithTimeIntervalSinceNow:0]] forHTTPHeaderField:@"timestamp"];
    [self.requestSerializer setValue:[config userToken] forHTTPHeaderField:@"authentication"];
}


- (void)postRequestWithRouter:(NSString*)router
                        param:(NSDictionary*)param
                     progress:(progressBlock)progress
                      success:(netSuccessBlock)success
                         fail:(netFailBlock)fail {
    NSString *urlString = [NSString stringWithFormat:@"%@/%@", self.baseURL, router];
    [self POST:urlString parameters:param progress:^(NSProgress * _Nonnull uploadProgress) {
        //
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //
    }];
}

- (void)getRequestWithRouter:(NSString*)router
                       param:(NSDictionary*)param
                    progress:(progressBlock)progress
                     success:(netSuccessBlock)success
                        fail:(netFailBlock)fail {
    NSString *urlString = [NSString stringWithFormat:@"%@/%@", self.baseURL, router];
    [self GET:urlString parameters:param progress:^(NSProgress * _Nonnull uploadProgress) {
        //
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //
    }];
}

@end
