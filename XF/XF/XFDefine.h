//
//  XFDefine.h
//  XF
//
//  Created by zyb-frank  on 17/2/20.
//  Copyright © 2017年 free. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *const XFErrorDomain;


//常量的定义----------------------------------------------------------------------

#if DEBUG
#define     kServerURL         @"http://192.168.0.100"                             //测试服务器
#define     DLog(fmt, ...)     {NSLog((@"[Line:%d] - " fmt), __LINE__, ##__VA_ARGS__);}
#else
#define     kServerURL         @"http://www.baidu.com"                             //生产服务器
#define     DLog(...) {}
#endif

#define     kAppIDInAppStore   @"640970171"                                        //在AppleStore上的ID


//通知类型------------------------------------------------------------------------

#define     kNotifyNetStatusChange                  @"XF.global.netstatuschange"                        //网络变化通知
#define     kNotifyUserRegistered                   @"XF.global.userregistered"                         //用户注册通知
#define     kNotifyUserLogined                      @"XF.global.userlogined"                            //用户登录通知
#define     kNotifyUserLogouted                     @"XF.global.userlogouted"                           //用户登出通知
#define     kNotifyAppUpdate                        @"XF.global.appupdate"                              //APP升级通知

#define     kNotifyTimeInterval                 60*60*24*2                                              //本地通知频率2天

#define     kNotifyPostWithObj(n,o)              [[NSNotificationCenter defaultCenter] postNotificationName:n object:o]
#define     kNotifyAddObserver(n,s)             [[NSNotificationCenter defaultCenter] addObserver:self selector:s name:n object:nil]
#define     kNotifyRemoveObserver(n)           [[NSNotificationCenter defaultCenter] removeObserver:self name:n object:nil]

//block的回调--------------------------------------------------------------------

typedef void (^progressBlock)(NSProgress * _Nonnull progress);                              //上传或下载的回调
typedef void (^netSuccessBlock)(NSURLSessionDataTask * _Nonnull task, id _Nullable result);
typedef void (^netFailBlock)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error);


//枚举的定义----------------------------------------------------------------------

typedef NS_OPTIONS(NSUInteger, XFPowerRight) {
    XFNoRight = 0,                  //用户无权限
    XFBrowerRight = 1 << 0,         //只有浏览仅限
    XFEditRight = 1 << 1,           //修改权限
    XFDeleteRight = 1 << 2,         //删除权限
    XFAddRight = 1 << 3,            //增加权限
};
