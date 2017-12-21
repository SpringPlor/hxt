//
//  TZPartnerLoginViewModel.m
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/12/7.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "TZPartnerLoginViewModel.h"

@implementation TZPartnerLoginViewModel

- (instancetype)init{
    self = [super init];
    if (self) {
        [self setUp];
    }
    return self;
}

- (void)setUp{
    self.partnerTypeCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSDictionary *params) {
        return [[[MYHTTPSessionManager racPostWithURL:[NSString stringWithFormat:@"%@%@",kServerPath,Fetch_Agent_Type] params:params class:[TZBaseModel class]] map:^id(TZBaseModel *model) {
            [SVProgressHUD dismiss];
            if ([model.success intValue] == 1) {
                return model;
            }else{
                [SVProgressHUD showErrorWithStatus:model.message];
                return nil;
            }
        }] doError:^(NSError *error) {
            [MYNetError ShowRequestErrorMessage:error];
        }];
    }];
    
    self.agentLoginCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSDictionary *params) {
        return [[[MYHTTPSessionManager racPostWithURL:[NSString stringWithFormat:@"%@%@",kServerPath,Agent_Login] params:params class:[MYBaseModel class]] map:^id(MYBaseModel *model) {
            [SVProgressHUD dismiss];
            if ([model.success intValue] == 1) {
                return model;
            }else{
                [SVProgressHUD showErrorWithStatus:model.message];
                return nil;
            }
        }] doError:^(NSError *error) {
            [MYNetError ShowRequestErrorMessage:error];
        }];
    }];
}

@end
