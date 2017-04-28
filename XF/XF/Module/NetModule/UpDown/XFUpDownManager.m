//
//  XFUpDownManager.m
//  XF
//
//  Created by zyb-frank  on 17/4/28.
//  Copyright © 2017年 free. All rights reserved.
//

#import "XFUpDownManager.h"

@implementation XFUpDownManager
+(void)downLoadTaskWithParam:(NSDictionary *)param ProgressBlock:(onProgressBlock)progress Block:(onReturnBlock)block {
    NSURL *url = [NSURL URLWithString:@"/download"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSessionDownloadTask *task = [[XFUpDownManager sharedInstance] downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        DLog(@"下载进度...%lf",1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        DLog(@"默认下载地址:%@",targetPath);
        NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
        return [NSURL URLWithString:filePath];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        DLog(@"下载完成:%@--%@",response,filePath);
    }];
    [task resume];
}

+(void)upLoadTaskWithParam:(NSDictionary *)param ProgressBlock:(onProgressBlock)progress Block:(onReturnBlock)block {
    NSURL *file = [NSURL fileURLWithPath:@""];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"/upload"]];
    NSURLSessionUploadTask *task = [[XFUpDownManager sharedInstance] uploadTaskWithRequest:request fromFile:file progress:^(NSProgress * _Nonnull uploadProgress) {
        DLog(@"上传进度...%lf", 1.0*uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        DLog(@"上传完成",nil);
    }];
    [task resume];
}

+(void)getDataFromServerWithParam:(NSDictionary *)param Block:(onReturnBlock)block {
    
}

+ (void)postDataToServerWithParam:(NSDictionary*)param Block:(onReturnBlock)block {
    [[XFUpDownManager sharedInstance] POST:@"" parameters:@"" constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        //
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        //
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //
    }];
}

+(void)putDataToServerWithParam:(NSDictionary *)param Block:(onReturnBlock)block {
    
}

+(void)deleteDataToServerWithParam:(NSDictionary *)param Block:(onReturnBlock)block {
    
}
@end
