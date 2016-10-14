//
//  payViewController.m
//  XF
//
//  Created by zyb-frank  on 16/10/13.
//  Copyright © 2016年 free. All rights reserved.
//

#import "payViewController.h"

@interface payViewController ()

@end

@implementation payViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    [self buyWithProductId:@"com.f4.benbendou"];
}
-(void)buyWithProductId:(NSString*)pId
{
    if ([SKPaymentQueue canMakePayments]) {
        
        NSLog(@"允许程序内付费购买, 则向appleStore请求商品信息");
        NSArray *product = [[NSArray alloc] initWithObjects:pId,nil];
        NSSet *nsset = [NSSet setWithArray:product];
        SKProductsRequest *request=[[SKProductsRequest alloc] initWithProductIdentifiers: nsset];
        request.delegate=self;
        [request start];
    }
    else
    {
        NSLog(@"不允许程序内付费购买");
    }
}

//AppleStore返回的产品信息
- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response{
    NSArray *myProduct = response.products;
    NSLog(@"产品Product ID:%@",response.invalidProductIdentifiers);
    NSLog(@"产品付费数量: %d", (int)[myProduct count]);
    
    for(SKProduct *product in myProduct){
        
        NSLog(@"SKProduct描述信息%@", [product description]);
        NSLog(@"产品标题：%@" , product.localizedTitle);
        NSLog(@"产品描述信息：%@" , product.localizedDescription);
        NSLog(@"价格：%@" , product.price);
        NSLog(@"ProductId：%@" , product.productIdentifier);
        
        //发起购买请求
        SKPayment *payment = [SKPayment paymentWithProduct:product];
        [[SKPaymentQueue defaultQueue] addPayment:payment];
    }
}

- (void)requestProUpgradeProductData
{
    NSLog(@"请求升级数据");
    NSSet *productIdentifiers = [NSSet setWithObject:@"com.productid"];
    SKProductsRequest* productsRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:productIdentifiers];
    productsRequest.delegate = self;
    [productsRequest start];
    
}

- (void)request:(SKRequest *)request didFailWithError:(NSError *)error{
    NSLog(@"获取商品信息失败......%@",error.localizedDescription);
}

-(void) requestDidFinish:(SKRequest *)request
{
    NSLog(@"请求结束");
}

-(void) PurchasedTransaction: (SKPaymentTransaction *)transaction{
    NSArray *transactions =[[NSArray alloc] initWithObjects:transaction, nil];
    [self paymentQueue:[SKPaymentQueue defaultQueue] updatedTransactions:transactions];
}


#pragma mark - SKPaymentTransactionObserver Protocol
- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions
{
    for (SKPaymentTransaction *transaction in transactions) {
        switch (transaction.transactionState) {
            case SKPaymentTransactionStatePurchased:
            {
                [self completeTransaction:transaction];
                NSLog(@"交易成功");
            }
                break;
            case SKPaymentTransactionStateFailed:
            {
                NSLog(@"交易失败");
                if (transaction.error.code != SKErrorPaymentCancelled)
                {
                    
                }
                [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
            }
                break;
            case SKPaymentTransactionStateRestored:
                NSLog(@"已经购买过该商品");
                //恢复交易处理
                break;
            case SKPaymentTransactionStatePurchasing:
                NSLog(@"商品添加进列表");
                break;
            default:
                break;
        }
    }
}
- (void) completeTransaction: (SKPaymentTransaction *)transaction

{
    NSLog(@"-----completeTransaction--------");
    // Your application should implement these two methods.
    NSString *product = transaction.payment.productIdentifier;
    if ([product length] > 0) {
        
        NSArray *tt = [product componentsSeparatedByString:@"."];
        NSString *bookid = [tt lastObject];
        if ([bookid length] > 0) {
            [self recordTransaction:bookid];
            [self provideContent:bookid];
        }
    }
    
    // Remove the transaction from the payment queue.
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
}

//记录交易
-(void)recordTransaction:(NSString *)product{
    NSLog(@"-----记录交易--------");
}

//处理下载内容
-(void)provideContent:(NSString *)product{
    NSLog(@"-----下载--------");
}

-(void) paymentQueueRestoreCompletedTransactionsFinished: (SKPaymentTransaction *)transaction{
    
}

- (void) restoreTransaction: (SKPaymentTransaction *)transaction
{
    NSLog(@" 交易恢复处理");
    
}

-(void) paymentQueue:(SKPaymentQueue *) paymentQueue restoreCompletedTransactionsFailedWithError:(NSError *)error{
    NSLog(@"-------paymentQueue----");
}

#pragma mark connection delegate
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    NSLog(@"%@",  [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    switch([(NSHTTPURLResponse *)response statusCode]) {
        case 200:
        case 206:
            break;
        case 304:
            break;
        case 400:
            break;
        case 404:
            break;
        case 416:
            break;
        case 403:
            break;
        case 401:
        case 500:
            break;
        default:
            break;
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"test");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [[SKPaymentQueue defaultQueue] removeTransactionObserver:self];
}

@end
