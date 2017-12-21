//
//  TZJFViewModel.m
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/10/17.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "TZJFViewModel.h"

@implementation TZJFViewModel

- (instancetype)init{
    self = [super init];
    if (self) {
        [self setUp];
    }
    return self;
}

- (void)setUp{
    self.jfProductCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSDictionary *params) {
        return [[[MYHTTPSessionManager racPostWithURL:[NSString stringWithFormat:@"%@%@",kServerPath,Integral_Commodity] params:params class:nil] map:^id(id value) {
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
    
    self.jfExchangeCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSDictionary *params) {
        return [[[MYHTTPSessionManager racPostWithURL:[NSString stringWithFormat:@"%@%@",kServerPath,Integral_Exchange] params:params class:nil] map:^id(id value) {
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
    
//    self.jfExchangeOrderCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSDictionary *params) {
//        return [[[MYHTTPSessionManager racPostWithURL:[NSString stringWithFormat:@"%@%@",kServerPath,Integral_Exchange_Order] params:params class:[MYBaseModel class]] map:^id(MYBaseModel *model) {
//            if ([model.success intValue] == 1) {
//                return model;
//            }else{
//                [SVProgressHUD showErrorWithStatus:model.msg];
//                return nil;
//            }
//        }] doError:^(NSError *error) {
//            [MYNetError ShowRequestErrorMessage:error];
//        }];
//    }];
}

@end
