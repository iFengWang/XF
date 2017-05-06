//
//  NSObject+Extent.m
//  XF
//
//  Created by zyb-frank  on 17/4/6.
//  Copyright © 2017年 free. All rights reserved.
//

#import "NSObject+Extent.h"
#import "Aspects.h"

@implementation NSObject (Extent)

+ (void)load {
    
    [UIViewController aspect_hookSelector:@selector(viewWillAppear:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo) {
        NSLog(@"Appear:---viewWillAppear---> %@", NSStringFromClass([aspectInfo.instance class]));
    } error:nil];
    
    
    [UIViewController aspect_hookSelector:@selector(viewWillDisappear:) withOptions:AspectPositionBefore usingBlock:^(id<AspectInfo> aspectInfo) {
        NSLog(@"Appear:---viewWillDisappear---> %@", NSStringFromClass([aspectInfo.instance class]));
    } error:nil];
    
    
    [UIViewController aspect_hookSelector:NSSelectorFromString(@"dealloc") withOptions:AspectPositionBefore usingBlock:^(id<AspectInfo> aspectInfo) {
        NSLog(@"Appear:---dealloc---> %@", NSStringFromClass([aspectInfo.instance class]));
    } error:nil];
    
}

- (id)valueForUndefinedKey:(NSString *)key {
    NSLog(@"get--出现异常，该key不存在%@",key);
    return nil;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    NSLog(@"set--出现异常，该key不存在%@",key);
}


//- (void)doesNotRecognizeSelector:(SEL)aSelector {
//
//}
//
//#pragma mark - 1.补救措施添加动态方法
//+(BOOL)resolveClassMethod:(SEL)sel {
//    return NO;
//}
//+(BOOL)resolveInstanceMethod:(SEL)sel {
//    return NO;
//}
//
//#pragma mark - 2.将SEL转发到可响应对象上
//- (id)forwardingTargetForSelector:(SEL)aSelector {
//    return nil;
//}
//
//#pragma mark - 3.消息转发
//- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
//    return nil;
//}
//- (void)forwardInvocation:(NSInvocation *)anInvocation {
//
//}

@end
