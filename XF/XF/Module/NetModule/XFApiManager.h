//
//  XFNetEnginee.h
//  XF
//
//  Created by Frank on 16/9/17.
//  Copyright © 2016年 free. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

typedef NS_ENUM (NSUInteger, XFError) {
    XFErrorUnKnow = -1,             //未知错误
    XFErrorNoNet = 0,               //网络错误
    XFErrorParse = 1,               //解析错误
};

@protocol XFApiManagerDelegate <NSObject>
- (void)successWithResponse:(id)response;
- (void)failWithResponse:(id)response;
@end

@interface XFApiManager : AFHTTPSessionManager
@property (nonatomic, weak) id<XFApiManagerDelegate> delegate;
/**
 *	@brief	生成全局唯一实例
 *
 *	@return XFNetEngine唯一实例
 */
+ (id)sharedInstance;
- (void)postRequestWithRouter:(NSString*)router Param:(NSDictionary*)param Block:(returnBlock)block;
- (void)getRequestWithRouter:(NSString*)router Param:(NSDictionary*)param Block:(returnBlock)block;
@end
