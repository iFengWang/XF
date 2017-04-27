//
//  XFNetEnginee.h
//  XF
//
//  Created by Frank on 16/9/17.
//  Copyright © 2016年 free. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface XFNetEngine : AFHTTPSessionManager

/**
 *	@brief	生成全局唯一实例
 *
 *	@return XFNetEngine唯一实例
 */
+ (id)sharedInstance;


@end
