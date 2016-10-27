//
//  LoginViewController.m
//  XF
//
//  Created by zyb-frank  on 16/10/26.
//  Copyright © 2016年 free. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *txtMobile;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    RACSignal * signal = [self.txtMobile.rac_textSignal map:^id(NSString* value) {
        return @(value.length>3);
    }];
    
    RAC(self.txtMobile, backgroundColor) = [signal map:^(NSNumber* x) {
        return [x boolValue] ? [UIColor clearColor] : [UIColor redColor];
    }];
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

@end
