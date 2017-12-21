//
//  TZLoginViewModel.m
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/10/16.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "TZLoginViewModel.h"

@implementation TZLoginViewModel

- (instancetype)init{
    self = [super init];
    if (self) {
        [self setUp];
    }
    return self;
}

- (void)setUp{
    
    self.verCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSDictionary *params) {
        return [[[MYHTTPSessionManager racPostWithURL:[NSString stringWithFormat:@"%@%@",kServerPath,Verify_Code] params:params class:nil] map:^id(id value) {
            return [MYBaseModel mj_objectWithKeyValues:value];
        }] doError:^(NSError *error) {
            [MYNetError ShowRequestErrorMessage:error];
        }];
    }];
    
    self.loginCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSDictionary *params) {
       return [[[MYHTTPSessionManager racPostWithURL:[NSString stringWithFormat:@"%@%@",kServerPath,Login_Phone] params:params class:[MYBaseModel class]] map:^id(MYBaseModel *model) {
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
    
    self.deviceIdCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSDictionary *params) {
        return [[[MYHTTPSessionManager racPostWithURL:[NSString stringWithFormat:@"%@%@",kServerPath,Login_Device_ID] params:params class:[MYBaseModel class]] map:^id(MYBaseModel *model) {
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

    
    self.inviteCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSDictionary *params) {
        return [[[MYHTTPSessionManager racPostWithURL:[NSString stringWithFormat:@"%@%@",kServerPath,Set_Invite_Code] params:params class:[MYBaseModel class]] map:^id(MYBaseModel *model) {
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
