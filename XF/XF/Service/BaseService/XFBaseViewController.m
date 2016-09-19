//
//  XFBaseViewController.m
//  XFMainApp
//
//  Created by Frank on 15/5/18.
//  Copyright (c) 2015年 iFengWang. All rights reserved.
//

#import "XFBaseViewController.h"

@interface XFBaseViewController ()

@end

@implementation XFBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    kNotifyAddObserver(kNotifyNetStatusChange, @selector(onReciveNotify:));
    kNotifyAddObserver(kNotifyAppUpdate, @selector(onReciveNotify:));
    kNotifyAddObserver(kNotifyUserRegistered, @selector(onReciveNotify:));
    kNotifyAddObserver(kNotifyUserLogined, @selector(onReciveNotify:));
    kNotifyAddObserver(kNotifyUserLogouted, @selector(onReciveNotify:));
//    kNotifyAddObserver(UIApplicationDidEnterBackgroundNotification, @selector(onReciveNotify:));
//    kNotifyAddObserver(UIApplicationWillEnterForegroundNotification, @selector(onReciveNotify:));
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */


#pragma mark - Notification
- (void)onReciveNotify:(NSNotification*)info
{
//    if ([info.name isEqual:kNotifyNetStatusChange])                                    //网络变化通知
//    {
//        //子类开现
//    }
//    else if([info.name isEqual:kNotifyAppUpdate])                                       //App更新
//    {
//        //子类开现
//    }
//    else if([info.name isEqual:kNotifyUserRegistered])                                  //用户注册
//    {
//        //子类开现
//    }
//    else if([info.name isEqual:kNotifyUserLogined])                                     //用户登录
//    {
//        //子类开现
//    }
//    else if([info.name isEqual:kNotifyUserLogouted])                                    //用户退出
//    {
//        //子类开现
//    }
//    else if([info.name isEqual:UIApplicationDidEnterBackgroundNotification])            //退到后台
//    {
//        //子类开现
//    }
//    else if([info.name isEqual:UIApplicationWillEnterForegroundNotification])          //返回前台
//    {
//        //子类开现
//    }
}

- (void)removeNotify
{
    kNotifyRemoveObserver(kNotifyNetStatusChange);
    kNotifyRemoveObserver(kNotifyAppUpdate);
    kNotifyRemoveObserver(kNotifyUserRegistered);
    kNotifyRemoveObserver(kNotifyUserLogined);
    kNotifyRemoveObserver(kNotifyUserLogouted);
    kNotifyRemoveObserver(UIApplicationDidEnterBackgroundNotification);
    kNotifyRemoveObserver(UIApplicationWillEnterForegroundNotification);
}




@end
