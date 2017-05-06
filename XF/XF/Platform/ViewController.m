//
//  ViewController.m
//  XF
//
//  Created by Frank on 16/9/13.
//  Copyright © 2016年 free. All rights reserved.
//

#import "ViewController.h"
#import "payViewController.h"
#import "Masonry.h"

@interface ViewController ()
- (IBAction)onButtonClick:(id)sender;

@property (nonatomic, strong) NSString *str;
@property (nonatomic, strong) NSString *height;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
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
