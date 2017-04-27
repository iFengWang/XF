//
//  ViewController.m
//  XF
//
//  Created by Frank on 16/9/13.
//  Copyright © 2016年 free. All rights reserved.
//

#import "ViewController.h"
#import "payViewController.h"

@interface ViewController ()
- (IBAction)onButtonClick:(id)sender;

@property (nonatomic, strong) NSString *str;
@property (nonatomic, strong) NSString *height;
@end

@implementation ViewController

- (NSString *)str {
    
    __block NSString * vvv;
    NSString* (^haha)() = ^{
        vvv = @"abcdefg";
        return vvv;
    };
    
    return haha();
    
//    return _str;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:[self buildView]];
    
//    NSLog(@"str......%@",self.str);
    
//    NSArray * ary = @[@"111",@"222",@"333"];
//    [ary enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        //
//    }];
    
//    [self setValue:@"xiaofeng" forKey:@"name"];
//    NSLog(@"name....%@", [self valueForKey:@"name"]);
    
//    NSMethodSignature *signature = [ViewController instanceMethodSignatureForSelector:@selector(run:)];
//    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
//    invocation.target = self;
//    invocation.selector = @selector(run:);
//    NSString *param = @"haha";
//    [invocation setArgument:&param atIndex:2];
//    [invocation invoke];
}

- (void)run:(id)p {
    NSLog(@"..............%@",p);
}

- (UIView*)buildView {
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(10, 70, 50, 50)];
    v.backgroundColor = [UIColor redColor];
    return v;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)onButtonClick:(id)sender {
    switch ([sender tag]) {
        case 1:
        {
            payViewController * payVC = [[payViewController alloc]init];
            [self.navigationController pushViewController:payVC animated:YES];
            break;
        }
        case 2:
        {
            NSDictionary *dict = @{@"name":@"xiaofeng"};
            NSString *sex = [dict valueForKey:@"sex"];
            NSLog(@"sex.....%@", sex);
            break;
        }
        case 3:
        {
            payViewController * payVC = [[payViewController alloc]init];
            [self.navigationController pushViewController:payVC animated:YES];
            break;
        }
        case 4:
        {
            break;
        }
        case 5:
        {
            break;
        }
        default:
            break;
    }
}
@end
