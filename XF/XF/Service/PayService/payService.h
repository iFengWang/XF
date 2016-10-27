//
//  payService.h
//  XF
//
//  Created by zyb-frank  on 16/10/20.
//  Copyright © 2016年 free. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>

typedef NS_ENUM(int64_t, ZDPayState){
    ZDPayOk = 0,           //正常
    ZDPayForbidden         //禁止APP内支付
};

typedef void (^successBlock)(id result);
typedef void (^failBlock)(ZDPayState);

@interface payService : NSObject<SKPaymentTransactionObserver,SKProductsRequestDelegate>

/**
 获取商品信息

 @param pId     商品ID
 @param success 成功block
 @param fail    失败block
 */
- (void)fetchProductWithProductId:(NSString*)pId successBlock:(successBlock)success failBlock:(failBlock)fail;

//- (void)fetchProductWithProductIds:(NSArray*)pIds successBlock:(successBlock)success failBlock:(failBlock)fail;

/**
 购买商品

 @param pId 商品ID,商品在AppStore上的唯一标识
 */
//- (void)buyProductWithProductId:(NSString*)pId successBlock:(successBlock)success failBlock:(failBlock)fail;

//- (void)buyProductWithProductIds:(NSArray*)pIds successBlock:(successBlock)success failBlock:(failBlock)fail;


/**
 发送之前失败的购买凭证进行验证，验证成功则会移除本地存储的凭证
 */
- (void)sendFailedTransactionReceipts;
@end
