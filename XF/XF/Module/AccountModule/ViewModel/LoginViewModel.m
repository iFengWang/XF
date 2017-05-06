//
//  LoginViewModel.m
//  XF
//
//  Created by zyb-frank  on 17/5/5.
//  Copyright © 2017年 free. All rights reserved.
//

#import "LoginViewModel.h"

@interface LoginViewModel ()<XFApiManagerDelegate>

@end

@implementation LoginViewModel

- (void)loginWithUserName:(NSString*)userName password:(NSString*)password {
    [[XFApiManager sharedInstance] loginWithUserName:userName password:password];
}

- (void)successWithResponse:(id)response {
    
}

- (void)failWithResponse:(id)response {
    
}
@end
