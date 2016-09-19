//
//  XFNetEnginee.m
//  XF
//
//  Created by Frank on 16/9/17.
//  Copyright © 2016年 free. All rights reserved.
//

#import "XFNetEngine.h"
#import "XFHelper.h"

@implementation XFNetEngine

+ (id)sharedInstance {
    static XFNetEngine * _engine = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        _engine = [[XFNetEngine alloc] initWithBaseURL:[NSURL URLWithString:kServerURL]];
        [_engine addBascDataToHeader];
    });
    return _engine;
}

// Header中的基础数据
- (void)addBascDataToHeader {
    XFConfig * config = [XFConfig sharedInstance];
    [self.requestSerializer setValue:[config appVersion] forHTTPHeaderField:@"appname"];
    [self.requestSerializer setValue:[config appVersion] forHTTPHeaderField:@"appversion"];
    [self.requestSerializer setValue:[config deviceSystemName] forHTTPHeaderField:@"osname"];
    [self.requestSerializer setValue:[config deviceSystemVersion] forHTTPHeaderField:@"osversion"];
    [self.requestSerializer setValue:[config deviceName] forHTTPHeaderField:@"devicename"];
    [self.requestSerializer setValue:[config deviceName] forHTTPHeaderField:@"devicemodel"];
    [self.requestSerializer setValue:[config deviceName] forHTTPHeaderField:@"deviceid"];
    [self.requestSerializer setValue:[XFHelper dateToTimeStamp:[NSDate dateWithTimeIntervalSinceNow:0]] forHTTPHeaderField:@"timestamp"];
    [self.requestSerializer setValue:[config userToken] forHTTPHeaderField:@"authentication"];
}

@end
