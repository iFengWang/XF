//
//  XFDefine.h
//  XF
//
//  Created by zyb-frank  on 17/2/20.
//  Copyright © 2017年 free. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *const XFErrorDomain;

typedef NS_ENUM (NSUInteger, XFError) {
    XFErrorUnKnow = -1,             //未知错误
    XFErrorNoNet = 0,               //网络错误
    XFErrorParse = 1,               //解析错误
};

typedef NS_OPTIONS(NSUInteger, XFPowerRight) {
    XFNoRight = 0,                  //用户无权限
    XFBrowerRight = 1 << 0,         //只有浏览仅限
    XFEditRight = 1 << 1,           //修改权限
    XFDeleteRight = 1 << 2,         //删除权限
    XFAddRight = 1 << 3,            //增加权限
};

@interface XFDefine : NSObject

@end
