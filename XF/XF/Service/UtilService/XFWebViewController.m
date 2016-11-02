//
//  XFWebViewController.m
//  XF
//
//  Created by zyb-frank  on 16/10/31.
//  Copyright © 2016年 free. All rights reserved.
//

#import "XFWebViewController.h"

@interface XFWebViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webview;

@end

@implementation XFWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:@""]];
//    [_webview loadRequest:request];
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"html"];
    NSString *htmlString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    [_webview loadHTMLString:htmlString baseURL:nil];
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

#pragma mark - UIWebViewDelegate
-(void)webViewDidFinishLoad:(UIWebView *)webView {
  NSLog(@"加载完毕");
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    NSLog(@"加载失败........%@",error.localizedDescription);
}

@end
