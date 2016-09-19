//
//  XFHelper.h
//  XFMainApp
//
//  Created by Frank on 15/5/13.
//  Copyright (c) 2015年 iFengWang. All rights reserved.
//

#import "XFObject.h"

/**
 *  通用方法函数
 */
@interface XFHelper : XFObject

/**
 *  获取当前时间戳
 *
 *  @return       返回当前时间戳的字符形式
 */
+ (NSString*)dateToTimeStamp:(NSDate*)d;
/**
 *	@brief        根据时间戳转日期
 *
 *	@param      timestamp 	时间戳字符串
 *
 *	@return      日期类型
 */
+ (NSDate*)timestampToDate:(NSString*)timestamp;


@end