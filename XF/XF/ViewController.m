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

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

-(NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    return nil;
}

-(void)forwardInvocation:(NSInvocation *)anInvocation {
//    objc_class;
//    objc_object;
}

- (IBAction)onButtonClick:(id)sender {
    switch ([sender tag]) {
        case 1:
        {
            payViewController * payVC = [[payViewController alloc]init];
            [self.navigationController pushViewController:payVC animated:YES];
        }
        break;
            
        default:
            break;
    }
}
@end
