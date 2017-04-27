//
//  XFHelper.m
//  XFMainApp
//
//  Created by Frank on 15/5/13.
//  Copyright (c) 2015年 iFengWang. All rights reserved.
//

#import <CoreText/CoreText.h>
#import <mach/mach_time.h>

#import "XFHelper.h"
//#import "XFTextField.h"
//#import "XFTextView.h"


@implementation XFHelper
+ (NSString*)dateToTimeStamp:(NSDate*)d
{
//    NSTimeInterval a=[d timeIntervalSince1970]*1000;
    NSTimeInterval a=[d timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%f", a];
    NSString *result = [timeString componentsSeparatedByString:@"."][0];
    return result;
}

+ (NSDate*)timestampToDate:(NSString*)timestamp
{
    NSDate * d = [NSDate dateWithTimeIntervalSince1970:[timestamp longLongValue]];
    return d;
}

@end


