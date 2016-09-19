//
//  XFUser.m
//  XF
//
//  Created by Frank on 16/9/18.
//  Copyright © 2016年 free. All rights reserved.
//

#import "XFUser.h"

@implementation XFUser

+ (id)shareInstance {
    static XFUser * _u = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        _u = [[XFUser alloc] init];
    });
    return _u;
}

@end
