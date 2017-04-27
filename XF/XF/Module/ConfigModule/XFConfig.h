//
//  XFConfig.h
//  XFMainApp
//
//  Created by Frank on 15/5/13.
//  Copyright (c) 2015年 iFengWang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    KXF = 0,
    KQQ,
    KSINA,
    KWEIXIN,
}EUserType;


@interface XFConfig : NSObject


/**
 *	@brief	生成单例
 *
 *	@return	返回KPConfigInfo实例，全局唯一
 */
+ (XFConfig*)sharedInstance;

/**
 *	@brief	判断设备系统版本是否是iOS7以上
 *
 *	@return	为真iOS7以上
 */
- (BOOL)isGreateriOSVersion:(NSInteger)version;


//用户相关信息******************************************

//用户基本信息------------------------
/**
 *	@brief	用户ID
 */
@property(nonatomic, strong) NSString* userId;
/**
 *	@brief	用户类型
 */
@property(nonatomic, assign) EUserType userType;
/**
 *	@brief	用户名
 */
@property(nonatomic, strong) NSString* userName;
/**
 *	@brief	用户密码
 */
@property(nonatomic, strong) NSString* userPassword;
/**
 *	@brief	用户TOKEN
 */
@property(nonatomic, strong) NSString* userToken;

//用户扩展信息------------------------
/**
 *	@brief	是否开启仅在WIFI网络上传下载
 */
@property(nonatomic, assign) BOOL isOnlyWifi;


//APP相关信息******************************************
/**
 *  @brief  APP在appleStore的唯一标识
 */
@property (nonatomic, strong, readonly) NSString * appleStoreId;
/**
 *	@brief	APP名称
 */
@property(nonatomic, strong, readonly) NSString * appName;
/**
 *	@brief	APP版本
 */
@property(nonatomic, strong, readonly) NSString * appVersion;
/**
 *	@brief	APP Build版本
 */
@property(nonatomic, strong, readonly) NSString * appBuildVersion;
/**
 *	@brief	APP Identify
 */
@property(nonatomic, strong, readonly) NSString * appIdentify;


//设备相关信息******************************************
/**
 *	@brief	openUDID 40位
 */
@property(nonatomic, strong,readonly) NSString * deviceUDID;
/**
 *	@brief	设备名称
 */
@property(nonatomic, strong,readonly) NSString * deviceName;
/**
 *	@brief	设备电量值 e.g. 0 .. 1.0. -1.0 if UIDeviceBatteryStateUnknown
 */
@property(nonatomic, assign,readonly) float      deviceBatteryLevel;
/**
 *	@brief	电源当前状态 UIDeviceBatteryStateUnknown if monitoring disabled
 */
@property(nonatomic, assign,readonly) UIDeviceBatteryState deviceBatteryState;
/**
 *	@brief	系统名称
 */
@property(nonatomic, strong,readonly) NSString * deviceSystemName;
/**
 *	@brief	系统版本
 */
@property(nonatomic, strong,readonly) NSString * deviceSystemVersion;
/**
 *	@brief	设备信息 如(iPhone4/iPhone4S...)
 */
@property(nonatomic, strong,readonly) NSString * devicePlatform;
/**
 *	@brief	摄像头是否可用
 */
@property(nonatomic, assign,readonly) BOOL deviceCameraIsAvailable;
/**
 *	@brief	前置摄像头是否可用
 */
@property(nonatomic, assign,readonly) BOOL deviceFrontCameraIsAvailable;
/**
 *	@brief	当前设备是否是iPad
 */
@property(nonatomic, assign,readonly) BOOL deviceIsPad;
/**
 *	@brief	当前设备是否是iPhone
 */
@property(nonatomic, assign,readonly) BOOL deviceIsPhone;
/**
 *	@brief	当前设备是否越狱
 */
@property(nonatomic, assign, readonly) BOOL deviceIsJailbreak;


@end
