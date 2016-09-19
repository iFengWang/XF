//
//  XFConfig.m
//  XFMainApp
//
//  Created by Frank on 15/5/13.
//  Copyright (c) 2015年 iFengWang. All rights reserved.
//

#import "XFConfig.h"
#import <sys/types.h>
#import <sys/sysctl.h>
#import "DeviceUDID.h"

NSString *const kUserId				= @"xf_userId";
NSString *const kUserType           = @"xf_userType";
NSString *const kUserName			= @"xf_userName";
NSString *const kUserPassword		= @"xf_userPassword";
NSString *const kUserToken          = @"xf_userToken";
NSString *const kIsOnlyWifi			= @"xf_isOnlyWifi";
NSString *const kAppleStoreId       = @"640970171";

NSString *const kCydiaPath          = @"/Applications/Cydia.app";
NSString *const kAptPath            = @"/private/var/lib/apt";


@interface XFConfig()
@property (nonatomic,strong) NSUserDefaults * userDefault;
@end

@implementation XFConfig
+ (XFConfig*)sharedInstance
{
    static XFConfig * _config = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        _config = [[XFConfig alloc]init];
        _config.userDefault = [NSUserDefaults standardUserDefaults];
    });
    return _config;
}

- (BOOL)isGreateriOSVersion:(NSInteger)version
{
    return ([[[[UIDevice currentDevice] systemVersion] substringToIndex:1] intValue]>=version);
}

- (id)userInfoWithKey:(NSString *)key
{
    return [[self.userDefault dictionaryForKey:self.userId] objectForKey:key];
}

- (void)setUserInfoWithKey:(NSString *)key andValue:(id)value
{
    @synchronized(self)
    {
        NSMutableDictionary* userInfo = [NSMutableDictionary dictionaryWithDictionary:[self.userDefault dictionaryForKey:self.userId]];
        [userInfo setObject:value forKey:key];
        [self.userDefault setObject:userInfo forKey:self.userId];
        [self.userDefault synchronize];
    }
}

- (void)removeUserInfoWithKey:(NSString*)key
{
    @synchronized(self)
    {
        NSMutableDictionary* userInfo = [NSMutableDictionary dictionaryWithDictionary:[self.userDefault dictionaryForKey:self.userId]];
        [userInfo removeObjectForKey:key];
        [self.userDefault setObject:userInfo forKey:self.userId];
        [self.userDefault synchronize];
    }
}

#pragma mark - 用户信息*******************************************

-(NSString *)userId
{
    return [self.userDefault stringForKey:kUserId];
}
-(void)setUserId:(NSString *)userId
{
    [self.userDefault setObject:userId forKey:kUserId];
}


-(EUserType)userType
{
    return (EUserType)[[self userInfoWithKey:kUserType] intValue];
}
-(void)setUserAccountType:(EUserType)userType
{
    [self setUserInfoWithKey:kUserType andValue:[NSNumber numberWithInt:userType]];
}


-(NSString *)userName
{
    return [self userInfoWithKey: kUserName];
}
-(void)setUserName:(NSString *)userName
{
    [self setUserInfoWithKey:kUserName andValue:userName];
}

-(NSString *)userPassword
{
    return [self userInfoWithKey:kUserPassword];
}
-(void)setUserPassword:(NSString *)userPassword
{
    [self setUserInfoWithKey:kUserPassword andValue:userPassword];
}

-(NSString *)userToken
{
    return [self userInfoWithKey:kUserType];
}
-(void)setUserToken:(NSString *)userToken
{
    [self setUserInfoWithKey:kUserToken andValue:userToken];
}

-(BOOL)isOnlyWifi
{
    return [[self userInfoWithKey:kIsOnlyWifi] boolValue];
}
-(void)setIsOnlyWifi:(BOOL)isOnlyWifi
{
    [self setUserInfoWithKey:kIsOnlyWifi andValue:[NSNumber numberWithBool:isOnlyWifi]];
}

#pragma mark - APP信息*******************************************

-(NSString *)appleStoreId
{
    return kAppleStoreId;
}

-(NSString *)appName
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Name = [infoDictionary objectForKey:@"CFBundleDisplayName"];
    return app_Name;
}
-(NSString *)appVersion
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    return app_Version;
}
-(NSString *)appBuildVersion
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_build = [infoDictionary objectForKey:@"CFBundleVersion"];
    return app_build;
}
-(NSString *)appIdentify
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_identifier = [infoDictionary objectForKey:@"CFBundleIdentifier"];
    return app_identifier;
}

#pragma mark - 设备信息*******************************************

-(NSString *)deviceUDID
{
    if([self isGreateriOSVersion:7])
        return [[UIDevice currentDevice].identifierForVendor UUIDString];
    else
        return [DeviceUDID value];
}
-(NSString *)deviceName
{
    return [UIDevice currentDevice].name;
}
-(float)deviceBatteryLevel
{
    return [UIDevice currentDevice].batteryLevel;
}
-(UIDeviceBatteryState)deviceBatteryState
{
    return [UIDevice currentDevice].batteryState;
}
-(NSString *)deviceSystemName
{
    return [UIDevice currentDevice].systemName;
}
-(NSString *)deviceSystemVersion
{
    return [UIDevice currentDevice].systemVersion;
}
-(NSString *)devicePlatform
{
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
    free(machine);
    
    if ([platform isEqualToString:@"iPhone1,1"])    return @"iPhone 2G";
    if ([platform isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([platform isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([platform isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,2"])    return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,3"])    return @"iPhone 4 (CDMA)";
    if ([platform isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([platform isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    if ([platform isEqualToString:@"iPhone5,2"])    return @"iPhone 5 (GSM+CDMA)";
    if ([platform hasPrefix:@"iPhone5,3"])          return @"iPhone 5C (GSM)";
    if ([platform hasPrefix:@"iPhone5,4"])          return @"iPhone 5C (Global)";
    if ([platform hasPrefix:@"iPhone6,1"])          return @"iPhone 5S (GSM)";
    if ([platform hasPrefix:@"iPhone6,2"])          return @"iPhone 5S (Global)";
    
    if ([platform isEqualToString:@"iPod1,1"])      return @"iPod Touch (1 Gen)";
    if ([platform isEqualToString:@"iPod2,1"])      return @"iPod Touch (2 Gen)";
    if ([platform isEqualToString:@"iPod3,1"])      return @"iPod Touch (3 Gen)";
    if ([platform isEqualToString:@"iPod4,1"])      return @"iPod Touch (4 Gen)";
    if ([platform isEqualToString:@"iPod5,1"])      return @"iPod Touch (5 Gen)";
    
    if ([platform isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([platform isEqualToString:@"iPad1,2"])      return @"iPad 3G";
    if ([platform isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([platform isEqualToString:@"iPad2,2"])      return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([platform isEqualToString:@"iPad2,4"])      return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,5"])      return @"iPad Mini (WiFi)";
    if ([platform isEqualToString:@"iPad2,6"])      return @"iPad Mini";
    if ([platform isEqualToString:@"iPad2,7"])      return @"iPad Mini (GSM+CDMA)";
    if ([platform isEqualToString:@"iPad3,1"])      return @"iPad 3 (WiFi)";
    if ([platform isEqualToString:@"iPad3,2"])      return @"iPad 3 (GSM+CDMA)";
    if ([platform isEqualToString:@"iPad3,3"])      return @"iPad 3";
    if ([platform isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    if ([platform isEqualToString:@"iPad3,5"])      return @"iPad 4";
    if ([platform isEqualToString:@"iPad3,6"])      return @"iPad 4 (GSM+CDMA)";
    
    if ([platform isEqualToString:@"i386"])         return @"Simulator";
    if ([platform isEqualToString:@"x86_64"])       return @"Simulator";
    return platform;
}
-(BOOL)deviceCameraIsAvailable
{
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
}
-(BOOL)deviceFrontCameraIsAvailable
{
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
}
-(BOOL)deviceIsPad
{
    return [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad;
}
-(BOOL)deviceIsPhone
{
    return [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone;
}
-(BOOL)deviceIsJailbreak
{
    return
    [[NSFileManager defaultManager] fileExistsAtPath:kCydiaPath] ||
    [[NSFileManager defaultManager] fileExistsAtPath:kAptPath];
}


@end
