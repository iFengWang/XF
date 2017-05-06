//
//  XFAccountApiManager.h
//  XF
//
//  Created by zyb-frank  on 17/4/28.
//  Copyright © 2017年 free. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XFApiManager.h"

typedef NS_ENUM (NSUInteger, XFThird) {
    XFWeixin = 0,           //微信登录
    XFQQ = 1,               //QQ登录
};

@interface XFAccountApiManager : XFApiManager

/**
 用户名密码登录

 @param userName 用户名
 @param password 密码
 @param block 回调
 */
- (void)loginWithUserName:(NSString*)userName password:(NSString*)password block:(returnBlock)block;
/**
 手机号密码登录

 @param mobile 手机号
 @param password 密码
 @param block 回调
 */
- (void)loginWithMobile:(NSInteger)mobile password:(NSString*)password block:(returnBlock)block;
/**
 第三方登录

 @param third 第三方枚举值
 @param token 登录凭证
 @param block 回调
 */
- (void)loginWithThird:(XFThird)third token:(NSString*)token block:(returnBlock)block;

@end
