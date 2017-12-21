//
//  TZProductWebViewController.m
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/11/6.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "TZProductWebViewController.h"

@interface TZProductWebViewController ()

@end

@implementation TZProductWebViewController

- (UIWebView *)webView{
    if (_webView == nil) {
        _webView = [MYBaseView webViewUseRequestWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) urlString:nil];
        [self.view addSubview:_webView];
        _webView.delegate = self;
    }
    return _webView;
}

- (NSString *)title{
    return @"粉丝福利购";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - webViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView{
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSLog(@"--------------%@",request.URL);
    if ([[request.URL absoluteString] hasPrefix:@"tbopen://"]) {
        return NO;
    }else{
        for (UIView *subview in kWindow.subviews.firstObject.subviews){
            if ([subview isKindOfClass:[UIImageView class]]) {
                NSLog(@"subview:%@",subview);
            }
        }
        return YES;
    }
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
