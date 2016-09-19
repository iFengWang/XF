//
//  XFApi.h
//  XF
//
//  Created by Frank on 16/9/17.
//  Copyright © 2016年 free. All rights reserved.
//

#import "XFObject.h"

@interface XFApi : XFObject

/**
 *	@brief	创建一个下载任务
 *
 *	@param 	param       参数
 *	@param 	progress 	下载进度回调
 *	@param 	block       完成下载的回调
 *
 *	@return    nil
 */
+ (void)downLoadTaskWithParam:(NSDictionary*)param ProgressBlock:(onProgressBlock)progress Block:(onReturnBlock)block;

/**
 *	@brief	创建一个上传任务
 *
 *	@param 	param       参数
 *	@param 	progress 	 上传进度
 *	@param 	block        完成上传的回调
 *
 *	@return     nil
 */
+ (void)upLoadTaskWithParam:(NSDictionary*)param ProgressBlock:(onProgressBlock)progress Block:(onReturnBlock)block;


+ (void)postDataToServerWithParam:(NSDictionary*)param Block:(onReturnBlock)block;
+ (void)getDataFromServerWithParam:(NSDictionary*)param Block:(onReturnBlock)block;
+ (void)putDataToServerWithParam:(NSDictionary*)param Block:(onReturnBlock)block;
+ (void)deleteDataToServerWithParam:(NSDictionary*)param Block:(onReturnBlock)block;
@end
