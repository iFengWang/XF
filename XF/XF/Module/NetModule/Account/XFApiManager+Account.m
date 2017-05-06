//
//  XFApiManager+Account.m
//  XF
//
//  Created by zyb-frank  on 17/5/6.
//  Copyright © 2017年 free. All rights reserved.
//

#import "XFApiManager+Account.h"

@implementation XFApiManager (Account)
- (void)loginWithUserName:(NSString*)userName password:(NSString*)password {
    NSDictionary *param = @{
                            @"userName":userName,
                            @"password":password
                            };
    [self postRequestWithRouter:XFROUTER_USERLOGIN param:param progress:^(NSProgress * _Nonnull progress) {
        //
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable result) {
        if ([self.delegate respondsToSelector:@selector(successWithResponse:)]) {
            [self.delegate successWithResponse:result];
        }
    } fail:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //
    }];
}

- (void)loginWithMobile:(NSInteger)mobile password:(NSString*)password
{
    NSDictionary *param = @{
                            @"mobile":@(mobile),
                            @"password":password
                            };
    [self postRequestWithRouter:XFROUTER_USERLOGIN param:param progress:^(NSProgress * _Nonnull progress) {
        //
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable result) {
        if ([self.delegate respondsToSelector:@selector(successWithResponse:)]) {
            [self.delegate successWithResponse:result];
        }
    } fail:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //
    }];
}

- (void)loginWithThird:(XFThird)third token:(NSString*)token {
    //
}
@end
