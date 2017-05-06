//
//  XFUpDownManager.m
//  XF
//
//  Created by zyb-frank  on 17/4/28.
//  Copyright © 2017年 free. All rights reserved.
//

#import "XFUpDownManager.h"

@implementation XFUpDownManager
- (void)downLoadTaskWithParam:(NSDictionary*)param progress:(progressBlock)progress success:(netSuccessBlock)block {
    NSURL *file = [NSURL fileURLWithPath:@""];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"/upload"]];
    NSURLSessionUploadTask *task = [[XFUpDownManager sharedInstance] uploadTaskWithRequest:request fromFile:file progress:^(NSProgress * _Nonnull uploadProgress) {
        DLog(@"上传进度...%lf", 1.0*uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        DLog(@"上传完成",nil);
    }];
    [task resume];
}


- (void)upLoadTaskWithParam:(NSDictionary*)param progress:(progressBlock)progress success:(netSuccessBlock)block {
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

@end
