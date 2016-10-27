//
//  payService.m
//  XF
//
//  Created by zyb-frank  on 16/10/20.
//  Copyright © 2016年 free. All rights reserved.
//

#import "payService.h"
#import <AFNetworking.h>

#define AppStoreInfoLocalFilePath [NSString stringWithFormat:@"%@/Caches/%@/", [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject],@".IAP_Pay"]

@interface payService()
@property (nonatomic, strong) SKPaymentTransaction * transaction;       //购买凭证
@property (nonatomic, copy) successBlock success;
@property (nonatomic, copy) failBlock fail;
@end

@implementation payService

+ (NSString *)getUUIDString {
    CFUUIDRef uuidRef = CFUUIDCreate(kCFAllocatorDefault);
    CFStringRef strRef = CFUUIDCreateString(kCFAllocatorDefault , uuidRef);
    NSString *uuidString = [(__bridge NSString*)strRef stringByReplacingOccurrencesOfString:@"-" withString:@""];
    CFRelease(strRef);
    CFRelease(uuidRef);
    return uuidString;
}

- (void)fetchProductWithProductId:(NSString*)pId successBlock:(successBlock)success failBlock:(failBlock)fail {
    if ([SKPaymentQueue canMakePayments]) {
        NSArray *product = [[NSArray alloc] initWithObjects:pId,nil];
        NSSet *nsset = [NSSet setWithArray:product];
        SKProductsRequest *request=[[SKProductsRequest alloc] initWithProductIdentifiers: nsset];
        request.delegate=self;
        [request start];
        self.success = success;
    }
    else {
        self.fail = fail;
        if (self.fail) self.fail(ZDPayForbidden);
    }
}

#pragma mark - SKProductsRequestDelegate
- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response {
    if(self.success) self.success(response.products);
    
//    NSArray *myProduct = response.products;
//    NSLog(@"产品Product ID:%@",response.invalidProductIdentifiers);
//    NSLog(@"产品付费数量: %d", (int)[myProduct count]);
//    
//    for(SKProduct *product in myProduct){
//        
//        NSLog(@"SKProduct描述信息%@", [product description]);
//        NSLog(@"产品标题：%@" , product.localizedTitle);
//        NSLog(@"产品描述信息：%@" , product.localizedDescription);
//        NSLog(@"价格：%@" , product.price);
//        NSLog(@"ProductId：%@" , product.productIdentifier);
//        
//        //发起购买请求
//        SKPayment *payment = [SKPayment paymentWithProduct:product];
//        [[SKPaymentQueue defaultQueue] addPayment:payment];
//    }
}

//- (void)request:(SKRequest *)request didFailWithError:(NSError *)error{
//    NSLog(@"获取商品信息-失败......%@",error.localizedDescription);
//}
//
//- (void)requestDidFinish:(SKRequest *)request
//{
//    NSLog(@"获取商品信息-请求结束");
//}

#pragma mark - SKPaymentTransactionObserver
- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions
{
    for (SKPaymentTransaction *transaction in transactions) {
        switch (transaction.transactionState) {
            case SKPaymentTransactionStatePurchased:
            {
                NSLog(@"交易成功");
                self.transaction = transaction;
                [self checkReceiptIsValidWithParam:[self createParam]];
                break;
            }
            case SKPaymentTransactionStateFailed:
            {
                NSLog(@"交易失败");
                [self failedTransaction:transaction];
                break;
            }
            case SKPaymentTransactionStateRestored:
            {
                NSLog(@"已经购买过该商品");
                //恢复交易处理
                break;
            }
            case SKPaymentTransactionStatePurchasing:
            {
                NSLog(@"商品添加进列表");
                break;
            }
            default:
                break;
        }
    }
}

//- (void)paymentQueue:(SKPaymentQueue *)queue removedTransactions:(NSArray<SKPaymentTransaction *> *)transactions {}
//
//- (void)paymentQueue:(SKPaymentQueue *) paymentQueue restoreCompletedTransactionsFailedWithError:(NSError *)error {}
//
//- (void)paymentQueueRestoreCompletedTransactionsFinished: (SKPaymentTransaction *)transaction {}
//
//- (void)paymentQueue:(SKPaymentQueue *)queue updatedDownloads:(NSArray<SKDownload *> *)downloads {}

//交易成功后拿到购买凭证然后向SERVER端提交验证请求
- (void)checkReceiptIsValidWithParam:(NSDictionary*)param {
    
    [[AFHTTPSessionManager manager] POST:@"path" parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self removeTransactionReceipt];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"购买失败，请重试"delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"重试", nil];
        [alertView show];
    }];
    
    if(self.transaction) [[SKPaymentQueue defaultQueue] finishTransaction: self.transaction];
}

//交易失败
- (void)failedTransaction:(SKPaymentTransaction *)transaction {
    if(transaction.error.code != SKErrorPaymentCancelled) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"购买失败，请重试"delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"重试", nil];
        [alertView show];
    } else {
        NSLog(@"用户取消交易");
    }
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [self seveTransactionReceipt];
    }
    else {
        [self checkReceiptIsValidWithParam:[self createParam]];
    }
}

//创建购买凭证相关数据
- (NSDictionary*)createParam {
    
    NSURL *receiptUrl=[[NSBundle mainBundle] appStoreReceiptURL];
    NSData *receiptData=[NSData dataWithContentsOfURL:receiptUrl];
    NSString *receipt=[receiptData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    NSTimeInterval timeStamp = [[NSDate dateWithTimeIntervalSinceNow:0] timeIntervalSinceNow];
    
    NSDictionary * dict = @{
                            @"transaction_id":           self.transaction.transactionIdentifier,            //交易订单号
                            @"product_identifier":       self.transaction.payment.productIdentifier,         //产品编号
                            @"receipt":                 receipt,                                      //购买凭证
                            @"user_id":                 @"1001",                                       //用户ID
                            @"time_stamp":              @(timeStamp)                                   //时间戳
                            };
    return dict;
}

//本地存储购买凭证
- (void)seveTransactionReceipt {
    
    BOOL isDir = FALSE;
    if (![[NSFileManager defaultManager] fileExistsAtPath:AppStoreInfoLocalFilePath isDirectory:&isDir]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:AppStoreInfoLocalFilePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    NSString *savedPath = [NSString stringWithFormat:@"%@%@.plist", AppStoreInfoLocalFilePath, [payService getUUIDString]];
    [[self createParam] writeToFile:savedPath atomically:YES];
}

//移除本地存储的购买凭证
- (void)removeTransactionReceipt {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:AppStoreInfoLocalFilePath])
    {
        [fileManager removeItemAtPath:AppStoreInfoLocalFilePath error:nil];
    }
}

//验证购买凭证失败,当APP再次启动后或网络OK后再次验证
- (void)sendFailedTransactionReceipts {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error = nil;
    NSArray *cacheFileNameArray = [fileManager contentsOfDirectoryAtPath:AppStoreInfoLocalFilePath error:&error];
    
    if (error == nil)
    {
        for (NSString *name in cacheFileNameArray)
        {
            if ([name hasSuffix:@".plist"])//如果有plist后缀的文件，说明就是存储的购买凭证
            {
                NSString *filePath = [NSString stringWithFormat:@"%@/%@", AppStoreInfoLocalFilePath, name];
                NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:filePath];
                [self checkReceiptIsValidWithParam:dict];
            }
        }
    }
    else
    {
        NSLog(@"error:..............%@", [error domain]);
    }
}

- (void)dealloc {
    [[SKPaymentQueue defaultQueue] removeTransactionObserver:self];
}
@end
