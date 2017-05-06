//
//  XFUpDownManager.h
//  XF
//
//  Created by zyb-frank  on 17/4/28.
//  Copyright © 2017年 free. All rights reserved.
//

#import "XFApiManager.h"

@interface XFUpDownManager : XFApiManager
/**
 *	@brief	创建一个下载任务
 *
 *	@param 	param       参数
 *	@param 	progress 	下载进度回调
 *	@param 	block       完成下载的回调
 *
 *	@return    nil
 */
- (void)downLoadTaskWithParam:(NSDictionary*)param progress:(progressBlock)progress success:(netSuccessBlock)block;

/**
 *	@brief	创建一个上传任务
 *
 *	@param 	param       参数
 *	@param 	progress 	 上传进度
 *	@param 	block        完成上传的回调
 *
 *	@return     nil
 */
- (void)upLoadTaskWithParam:(NSDictionary*)param progress:(progressBlock)progress success:(netSuccessBlock)block;
@end
