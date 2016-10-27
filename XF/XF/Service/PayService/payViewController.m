//
//  payViewController.m
//  XF
//
//  Created by zyb-frank  on 16/10/13.
//  Copyright © 2016年 free. All rights reserved.
//

#import "payViewController.h"
#import "IAPPayManager.h"

@interface payViewController ()<IAPPayManagerDelegate>
- (IBAction)onClick:(id)sender;
@end

@implementation payViewController{
    IAPPayManager * _pay;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _pay = [[IAPPayManager alloc] init];
    _pay.delegate = self;
}

- (IBAction)onClick:(id)sender {
    
    if ([sender tag]==100) {
        [_pay payProductInfoWithIds:@[@"com.zyb.productNo1", @"com.zyb.productNo2", @"com.zyb.productNo3", @"com.zyb.productNo4"]];
        return;
    }
    
    NSString *productIdentify = [NSString stringWithFormat:@"com.zyb.productNo%d",(int)[sender tag]];
    [_pay payProductInfoWithIds:@[productIdentify]];
}

#pragma mark - payManagerDelegate
- (void)payProductWithTranscationStatus:(ZDTranscationStatus)Status {
    switch (Status) {
        case ZDTranscationSuccess:
        {
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:nil message:@"支付成功！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
            break;
        }
        case ZDDenyIap:
        {
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:nil message:@"您的App未开启App内支付权限，请到系统设置中开启" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles: nil];
            [alert show];
            break;
        }
        case ZDGetProductInfoFail:
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"获取商品信息失败，请重试"delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"重试", nil];
            [alertView show];
            break;
        }
        case ZDTransactionFail:
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"购买商品失败，请在系统设置中检查您的AppStore帐号是否正确，然后再重试"delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"重试", nil];
            [alertView show];
            break;
        }
        case ZDCheckReceiptFail:
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"验证购买凭证失败，请确认您的当前网络是否正常，然后再重试"delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"重试", nil];
            [alertView show];
            break;
        }
            
        default:
            break;
    }
}

@end
