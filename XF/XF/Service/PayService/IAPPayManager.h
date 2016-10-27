//
//  payManager.h
//  XF
//
//  Created by zyb-frank  on 16/10/20.
//  Copyright © 2016年 free. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>

typedef NS_ENUM(NSInteger, ZDTranscationStatus) {
    ZDTranscationSuccess = 0,           //交易成功
    ZDDenyIap,                          //禁止App内购买
    ZDGetProductInfoFail,               //获取商品信息失败
    ZDTransactionFail,                  //商品交易失败
    ZDCheckReceiptFail                  //验证购买凭证失败
};

@protocol IAPPayManagerDelegate <NSObject>
@required
- (void)payProductWithTranscationStatus:(ZDTranscationStatus)Status;
@end

@interface IAPPayManager : NSObject<SKPaymentTransactionObserver,SKProductsRequestDelegate>

@property (nonatomic, assign) id<IAPPayManagerDelegate> delegate;

/**
 购买商品

 @param pIds 数组中每个元素都必须是AppStore上注册的商品唯一标识
 */
- (void)payProductInfoWithIds:(NSArray*)pIds;
/**
 验证购买凭证失败,当APP再次启动后或网络OK后再次验证
 */
- (void)sendFailedTransactionReceipts;
@end
