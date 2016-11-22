//
//  LoginViewController.m
//  XF
//
//  Created by zyb-frank  on 16/10/26.
//  Copyright © 2016年 free. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *txtMobile;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;
@property (weak, nonatomic) IBOutlet UIButton *butLogin;
@property (weak, nonatomic) UITextField * txtTest;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self.view addSubview:self.txtTest];
    [self setupSignal];
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

#pragma mark - signal manage
- (void)setupSignal {
    
    //手机输入框信号
    RACSignal * mobileSignal = [self.txtMobile.rac_textSignal map:^id(NSString* value) {
        return @(value.length>3);
    }];
    RAC(self.txtMobile, backgroundColor) = [mobileSignal map:^(NSNumber* x) {
        return [x boolValue] ? [UIColor clearColor] : [UIColor redColor];
    }];
    
    //密码输入框信号
    RACSignal * passwordSignal = [self.txtPassword.rac_textSignal map:^id(NSString* value) {
        return @(value.length>3);
    }];
    RAC(self.txtPassword, backgroundColor) = [passwordSignal map:^(NSNumber* x) {
        return [x boolValue] ? [UIColor clearColor] : [UIColor redColor];
    }];
    
    //聚合信号
    RACSignal * buttonSignal = [RACSignal combineLatest:@[mobileSignal, passwordSignal] reduce:^id(NSNumber* a, NSNumber* b) {
        return @([a boolValue] && [b boolValue]) ;
    }];
    [buttonSignal subscribeNext:^(NSNumber* x) {
        self.butLogin.enabled = [x boolValue];
        self.butLogin.backgroundColor = [x boolValue] ? [UIColor greenColor] : [UIColor redColor] ;
    }];
    
    //按钮信号
    [[self.butLogin rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(id x) {
         NSLog(@"button clicked");
     }];
    
    //创建信号 - 每次对 s 信号的调用都会导致内部的block执行一次
    RACSignal* s = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        //网络请求返回block
        NSLog(@"RACSignal......",nil);
        [subscriber sendNext:@(100)];
        [subscriber sendCompleted];
        
        return nil;
    }];
    
    [s subscribeNext:^(id x) {
        //
    }];
}

#pragma mark - UITextField Delegate
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSLog(@"str.......%@",string);
    return YES;
}

#pragma mark - getter & setter
-(UITextField *)txtTest {
    UITextField * t = [[UITextField alloc] initWithFrame:CGRectMake(20, 20, [UIScreen mainScreen].bounds.size.width-20*2, 30)];
    t.delegate = self;
    t.keyboardType = UIKeyboardTypeNumberPad;
    [t setBorderStyle:UITextBorderStyleLine];
    [t setBackgroundColor:[UIColor yellowColor]];
    return  t;
}

@end
