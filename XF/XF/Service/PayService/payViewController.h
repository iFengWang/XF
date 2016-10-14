//
//  payViewController.h
//  XF
//
//  Created by zyb-frank  on 16/10/13.
//  Copyright © 2016年 free. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <StoreKit/StoreKit.h>

@interface payViewController : UIViewController<SKPaymentTransactionObserver,SKProductsRequestDelegate>

@end
