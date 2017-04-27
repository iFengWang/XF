//
//  JSPatchManager.m
//  XF
//
//  Created by zyb-frank  on 17/4/6.
//  Copyright © 2017年 free. All rights reserved.
//

#import "JSPatchManager.h"
//#import <JSPatchPlatform/JSPatch.h>
#import <JSPatch/JPEngine.h>

@implementation JSPatchManager
+ (void)setupJsPatchModule {
    //JSPatchPerform
    //    [JSPatch startWithAppKey:@"250116f1adfe1eb1"];
    //    [JSPatch sync];
    //    [JSPatch testScriptInBundle];
    
    // 调js脚本
    //    [JPEngine startEngine];
    //    NSString *path = [[NSBundle mainBundle] pathForResource:@"main" ofType:@"js"];
    //    NSString *script = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    //    [JPEngine evaluateScript:script];
    
    // 直接执行js
    //    [JPEngine evaluateScript:@"\
    //     var alertView = require('UIAlertView').alloc().init();\
    //     alertView.setTitle('Alert');\
    //     alertView.setMessage('AlertView from js'); \
    //     alertView.addButtonWithTitle('OK');\
    //     alertView.show(); \
    //     "];
}
@end
