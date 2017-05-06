//
//  XFAccountApiManager.m
//  XF
//
//  Created by zyb-frank  on 17/4/28.
//  Copyright © 2017年 free. All rights reserved.
//

#import "XFAccountApiManager.h"

@implementation XFAccountApiManager

- (void)loginWithUserName:(NSString*)userName password:(NSString*)password block:(returnBlock)block {
    NSDictionary *param = @{
                            @"userName":userName,
                            @"password":password
                            };
    
    [self postRequestWithRouter:XF_USERLOGIN Param:param Block:^(id result, NSError *error) {
        if ([self.delegate respondsToSelector:@selector(successWithResponse:)]) {
            //
        }
    }];
}

- (void)loginWithMobile:(NSInteger)mobile password:(NSString*)password block:(returnBlock)block {
    NSDictionary *param = @{
                            @"mobile":@(mobile),
                            @"password":password
                            };
    
    [self postRequestWithRouter:XF_USERLOGIN Param:param Block:^(id result, NSError *error) {
        if ([self.delegate respondsToSelector:@selector(successWithResponse:)]) {
            //
        }
    }];
}

- (void)loginWithThird:(XFThird)third token:(NSString*)token block:(returnBlock)block {
    //
}
@end
