//
//  MYNetError.m
//  ZebraLife_Merchant
//
//  Created by 彭佳伟 on 2017/8/8.
//  Copyright © 2017年 bm. All rights reserved.
//

#import "MYNetError.h"

@implementation MYNetError

+ (void)ShowRequestErrorMessage:(NSError *)error{
    [SVProgressHUD dismiss];
    if (error.code == NSURLErrorCancelled) {
        return;
    } else if (error.code == NSURLErrorBadServerResponse) {
        [SVProgressHUD showInfoWithStatus:@"服务器繁忙，请稍后再试"];
    } else if (error.code == NSURLErrorTimedOut) {
        [SVProgressHUD showInfoWithStatus:@"请求超时"];
    } else if (error.code == NSURLErrorNotConnectedToInternet) {
        [SVProgressHUD showInfoWithStatus:@"网络错误"];
    } else {
        [SVProgressHUD showInfoWithStatus:@"服务器繁忙，请稍后再试"];
    }
}

@end
