//
//  payManager.m
//  XF
//
//  Created by zyb-frank  on 16/10/20.
//  Copyright © 2016年 free. All rights reserved.
//

#import "IAPPayManager.h"
#import <AFNetworking.h>

#define AppStoreInfoLocalFilePath [NSString stringWithFormat:@"%@/Caches/%@", [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject],@".IAP_Pay"]

#define     kTranscationOrder       @"transaction_order"             //交易订单号
#define     kProductIdentifier      @"product_identifier"            //产品编号
#define     kReceipt                @"receipt"                       //购买凭证
#define     kUserId                 @"user_id"                       //用户ID
#define     kTimeStamp              @"time_stamp"                    //时间戳


@interface IAPPayManager()
//@property (nonatomic, strong) NSMutableArray * products;
@end

@implementation IAPPayManager

- (instancetype)init {
    
    self = [super init];
    if (self) {
        [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    }
    return self;
}

- (void)payProductInfoWithIds:(NSArray*)pIds {
    if ([SKPaymentQueue canMakePayments]) {
        [self fetchProductInfoWithIds:pIds];
        return;
    }
    [self notifyDelegateWithTranscationState:ZDDenyIap];
}

- (void)fetchProductInfoWithIds:(NSArray*)pIds {
    NSSet *nsset = [NSSet setWithArray:pIds];
    SKProductsRequest *request=[[SKProductsRequest alloc] initWithProductIdentifiers: nsset];
    request.delegate=self;
    [request start];
}


- (void)payProductWithProductId:(SKProduct*)product {
    SKPayment *payment = [SKPayment paymentWithProduct:product];
    [[SKPaymentQueue defaultQueue] addPayment:payment];
}

#pragma mark - SKProductsRequestDelegate
- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response {
    for(SKProduct *product in response.products) {
        NSLog(@"-----------------------------------------------", nil);
        NSLog(@"商品ID：%@", product.productIdentifier);
        NSLog(@"产品标题：%@", product.localizedTitle);
        NSLog(@"产品描述：%@", product.localizedDescription);
        NSLog(@"商品价格：%@", product.price);
        [self payProductWithProductId:product];
    }
}

- (void)request:(SKRequest *)request didFailWithError:(NSError *)error {
    NSLog(@"error......%@",error.localizedDescription);
}

- (void)requestDidFinish:(SKRequest *)request {
    NSLog(@"end.....",nil);
}

#pragma mark - SKPaymentTransactionObserver
- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions
{
    for (SKPaymentTransaction *transaction in transactions) {
        switch (transaction.transactionState) {
            case SKPaymentTransactionStatePurchased:
            {
                NSLog(@"交易成功");
                NSDictionary * param = [self createParamWithTransaction:transaction];
                [self saveTransactionReceiptWithParam:param];
                [self checkReceiptIsValidWithParam:param];
                
                [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
                break;
            }
            case SKPaymentTransactionStateFailed:
            {
                NSLog(@"交易失败");
                [self failedTransaction:transaction];
                [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
                break;
            }
            case SKPaymentTransactionStateRestored:
            {
                NSLog(@"已经购买过该商品");
                
//                [[SKPaymentQueue defaultQueue] restoreCompletedTransactions];     //只能恢复非消耗类商品
                
                NSDictionary * param = [self createParamWithTransaction:transaction];
                [self saveTransactionReceiptWithParam:param];
                [self checkReceiptIsValidWithParam:param];
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                break;
            }
//            case SKPaymentTransactionStatePurchasing:
//            {
//                NSLog(@"商品添加进列表");
//                break;
//            }
            default:
                break;
        }
    }
}

- (void)paymentQueue:(SKPaymentQueue *)queue removedTransactions:(NSArray<SKPaymentTransaction *> *)transactions {}

- (void)paymentQueue:(SKPaymentQueue *) paymentQueue restoreCompletedTransactionsFailedWithError:(NSError *)error {}

- (void)paymentQueueRestoreCompletedTransactionsFinished: (SKPaymentTransaction *)transaction {}

- (void)paymentQueue:(SKPaymentQueue *)queue updatedDownloads:(NSArray<SKDownload *> *)downloads {}

//通知代理对象失败的原因
- (void)notifyDelegateWithTranscationState:(ZDTranscationStatus)Status {
    if (_delegate && [_delegate respondsToSelector:@selector(payProductWithTranscationStatus:)]) {
        [_delegate payProductWithTranscationStatus:Status];
    }
}

//创建购买凭证相关数据
- (NSDictionary*)createParamWithTransaction:(SKPaymentTransaction*)transaction {
    
    NSURL *receiptUrl=[[NSBundle mainBundle] appStoreReceiptURL];
    NSData *receiptData=[NSData dataWithContentsOfURL:receiptUrl];
    NSString *receipt=[receiptData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    NSTimeInterval timeStamp = [[NSDate dateWithTimeIntervalSinceNow:0] timeIntervalSinceNow];
    
    NSDictionary * dict = @{
                        kTranscationOrder:        transaction.transactionIdentifier,
                        kProductIdentifier:       transaction.payment.productIdentifier,
                        kReceipt:                receipt,
                        kUserId:                 @"1001",
                        kTimeStamp:              @(timeStamp)
                        };
    return dict;
}

//交易失败
- (void)failedTransaction:(SKPaymentTransaction*)transaction {
    if(transaction.error.code != SKErrorPaymentCancelled) {
        [self notifyDelegateWithTranscationState:ZDTransactionFail];
    } else {
        NSLog(@"用户取消交易");
    }
}

- (void)checkReceiptIsValidWithParam:(NSDictionary*)param {
    
    //apple sandbox
        NSString* uStr = @"https://sandbox.itunes.apple.com/verifyReceipt";
        NSDictionary * dict = @{
                                @"receipt-data":[param valueForKey:kReceipt],
                                @"password":@"55e6044ad7414a9babe04ef52a225c4c"
                                };
    
    //test14
//    NSString* uStr = @"http://test14.afpai.com/pay/api/applepay";
//    NSDictionary * dict = @{
//                            @"receipt":[param valueForKey:kReceipt],
//                            @"transId":[param valueForKey:kTranscationOrder]
//                        };

    AFHTTPSessionManager * m = [AFHTTPSessionManager manager];
//    m.requestSerializer.timeoutInterval = 30.f;
    m.requestSerializer = [AFJSONRequestSerializer serializer];
//    m.responseSerializer = [AFJSONResponseSerializer serializer];
//    m.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    [m POST:uStr parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//                [self removeTransactionReceiptWithParam:[param valueForKey:kTranscationOrder]];
//                [self notifyDelegateWithTranscationState:ZDTranscationSuccess];
        NSDictionary *resultDict = (NSDictionary *)responseObject;
        NSLog(@"success.....%@",resultDict);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//                [self notifyDelegateWithTranscationState:ZDCheckReceiptFail];
        NSLog(@"error.....%@",error.localizedDescription);
    }];
}

//本地存储购买凭证
- (void)saveTransactionReceiptWithParam:(NSDictionary*)param {
    BOOL isDir = FALSE;
    if (![[NSFileManager defaultManager] fileExistsAtPath:AppStoreInfoLocalFilePath isDirectory:&isDir]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:AppStoreInfoLocalFilePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    NSString *savedPath = [NSString stringWithFormat:@"%@/%@.plist", AppStoreInfoLocalFilePath, [param valueForKey:kTranscationOrder]];
    [param writeToFile:savedPath atomically:YES];
}

//移除本地存储的购买凭证
- (void)removeTransactionReceiptWithParam:(NSDictionary*)param {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *savedPath = [NSString stringWithFormat:@"%@/%@.plist", AppStoreInfoLocalFilePath, [param valueForKey:kTranscationOrder]];
    if ([fileManager fileExistsAtPath:savedPath])
    {
        [fileManager removeItemAtPath:savedPath error:nil];
    }
}

//当APP再次启动后对之前验证未完成的购买凭证再次验证
- (void)sendFailedTransactionReceipts {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error = nil;
    NSArray *cacheFileNameArray = [fileManager contentsOfDirectoryAtPath:AppStoreInfoLocalFilePath error:&error];
    
    if (!error)
    {
        for (NSString *name in cacheFileNameArray)
        {
            if ([name hasSuffix:@".plist"])
            {
                NSString *filePath = [NSString stringWithFormat:@"%@/%@", AppStoreInfoLocalFilePath, name];
                NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:filePath];
                [self checkReceiptIsValidWithParam:dict];
            }
        }
    }
    else
    {
        NSLog(@"error:..............%@", error.localizedDescription);
    }
}

- (void)dealloc {
    [[SKPaymentQueue defaultQueue] removeTransactionObserver:self];
}

@end
