//
//  XFObject.m
//  XFMainApp
//
//  Created by Frank on 15/5/13.
//  Copyright (c) 2015年 iFengWang. All rights reserved.
//

#import "XFObject.h"

@implementation XFObject

#pragma mark - 1.补救措施添加动态方法
+(BOOL)resolveClassMethod:(SEL)sel {
    return NO;
}
+(BOOL)resolveInstanceMethod:(SEL)sel {
    return NO;
}

#pragma mark - 2.将SEL转发到可响应对象上
- (id)forwardingTargetForSelector:(SEL)aSelector {
    return nil;
}

#pragma mark - 3.消息转发
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    return nil;
}
- (void)forwardInvocation:(NSInvocation *)anInvocation {
    
}

@end
