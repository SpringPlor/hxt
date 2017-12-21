//
//  TZBannerViewModel.m
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/10/18.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "TZBannerViewModel.h"

@implementation TZBannerViewModel

- (instancetype)init{
    self = [super init];
    if (self) {
        [self setUp];
    }
    return self;
}

-(void)setUp{
    self.bannerCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSDictionary *params) {
        return [[[MYHTTPSessionManager racPostWithURL:[NSString stringWithFormat:@"%@%@",kServerPath,Banner_Detail] params:params class:nil] map:^id(id value) {
            if ([value[@"success"] intValue] == 1) {
                return value[@"data"];
            }else{
                [SVProgressHUD showErrorWithStatus:value[@"message"]];
                return nil;
            }
        }] doError:^(NSError *error) {
            [MYNetError ShowRequestErrorMessage:error];
        }];
    }];
}


@end
