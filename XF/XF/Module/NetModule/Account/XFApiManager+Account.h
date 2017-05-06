//
//  XFApiManager+Account.h
//  XF
//
//  Created by zyb-frank  on 17/5/6.
//  Copyright © 2017年 free. All rights reserved.
//

#import "XFApiManager.h"

typedef NS_ENUM (NSUInteger, XFThird) {
    XFWeixin = 0,           //微信登录
    XFQQ = 1,               //QQ登录
};

@interface XFApiManager (Account)
/**
 用户名密码登录
 
 @param userName 用户名
 @param password 密码
 */
- (void)loginWithUserName:(NSString*)userName password:(NSString*)password;
/**
 手机号密码登录
 
 @param mobile 手机号
 @param password 密码
 */
- (void)loginWithMobile:(NSInteger)mobile password:(NSString*)password;
/**
 第三方登录
 
 @param third 第三方枚举值
 @param token 登录凭证
 */
- (void)loginWithThird:(XFThird)third token:(NSString*)token;
@end
