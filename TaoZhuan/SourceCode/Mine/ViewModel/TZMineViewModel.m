//
//  TZMineViewModel.m
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/10/17.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "TZMineViewModel.h"

@implementation TZMineViewModel

- (instancetype)init{
    self = [super init];
    if (self) {
        [self setUp];
    }
    return self;
}

- (void)setUp{
    self.userInfoCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSDictionary *params) {
        return [[[MYHTTPSessionManager racPostWithURL:[NSString stringWithFormat:@"%@%@",kServerPath,Fetch_UserInfo] params:params class:[MYBaseModel class]] map:^id(MYBaseModel *model) {
            if ([model.success intValue] == 1) {
                return model;
            }else{
                return nil;
            }
        }] doError:^(NSError *error) {
            [MYNetError ShowRequestErrorMessage:error];
        }];
    }];
    
    self.signinCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSDictionary *params) {
       return [[[MYHTTPSessionManager racPostWithURL:[NSString stringWithFormat:@"%@%@",kServerPath,Sing_In] params:params class:nil] map:^id(id value) {
           if ([value[@"success"] intValue] == 1) {
               return value;
           }else{
               [SVProgressHUD showErrorWithStatus:value[@"message"]];
               return nil;
           }
       }] doError:^(NSError *error) {
           [MYNetError ShowRequestErrorMessage:error];
       }];
    }];
    
    self.integralDetailCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSDictionary *params) {
        return [[[MYHTTPSessionManager racGetWithURL:[NSString stringWithFormat:@"%@%@",kServerPath,Integral_Details] params:params class:nil] map:^id(id value) {
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
    
    self.intergralOrder = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSDictionary *params) {
        return [[[MYHTTPSessionManager racGetWithURL:[NSString stringWithFormat:@"%@%@",kServerPath,Integral_Order] params:params class:nil] map:^id(id value) {
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
    
    self.loginOutCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSDictionary *params) {
        return [[[MYHTTPSessionManager racPostWithURL:[NSString stringWithFormat:@"%@%@",kServerPath,Login_Out] params:params class:[MYBaseModel class]] map:^id(MYBaseModel *model) {
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
    
    self.inviteVodeCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSDictionary *params) {
        return [[[MYHTTPSessionManager racPostWithURL:[NSString stringWithFormat:@"%@%@",kServerPath,User_Invite_Code] params:params class:[MYBaseModel class]] map:^id(MYBaseModel *model) {
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
    
    self.tyCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSDictionary *params) {
        return [[[MYHTTPSessionManager racPostWithURL:[NSString stringWithFormat:@"%@%@",kServerPath,TaoBao_Friends] params:params class:nil] map:^id(id value) {
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
    
    self.supplementCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSDictionary *params) {
        return [[[MYHTTPSessionManager racPostWithURL:[NSString stringWithFormat:@"%@%@",kServerPath,Supplement_Order] params:params class:[MYBaseModel class]] map:^id(MYBaseModel *model) {
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
    
    self.zfbCashCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSDictionary *params) {
        return [[[MYHTTPSessionManager racPostWithURL:[NSString stringWithFormat:@"%@%@",kServerPath,Cash_Withdrawal] params:params class:[MYBaseModel class]] map:^id(MYBaseModel *model) {
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
    
    self.balanceCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSDictionary *params) {
        return [[[MYHTTPSessionManager racGetWithURL:[NSString stringWithFormat:@"%@%@",kServerPath,Fetch_Balance] params:params class:nil] map:^id(id value) {
            if ([value[@"success"] intValue] == 1) {
                return value[@"data"];
            }else{
                return nil;
            }
        }] doError:^(NSError *error) {
            [MYNetError ShowRequestErrorMessage:error];
        }];
    }];
    
    self.balanceOrderCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSDictionary *params) {
        return [[[MYHTTPSessionManager racGetWithURL:[NSString stringWithFormat:@"%@%@",kServerPath,Fetch_Balance_Orders] params:params class:nil] map:^id(id value) {
            if ([value[@"success"] intValue] == 1) {
                return value[@"data"];
            }else{
                return nil;
            }
        }] doError:^(NSError *error) {
            [MYNetError ShowRequestErrorMessage:error];
        }];
    }];
    
    self.messageReturnCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSDictionary *params) {
//        return [[[MYHTTPSessionManager racPostWithURL:[NSString stringWithFormat:@"%@%@",@"http://192.168.10.189:9000/",Message_Return] params:@{@"content":@"1111"} class:nil] map:^id(id value) {
//            if ([value[@"success"] intValue] == 1) {
//                return value[@"data"];
//            }else{
//                return nil;
//            }
//        }] doError:^(NSError *error) {
//            [MYNetError ShowRequestErrorMessage:error];
//        }];
        return [[[MYHTTPSessionManager racUploadWithURL:[NSString stringWithFormat:@"%@%@",kServerPath,Message_Return] params:params fileData:nil fileName:nil class:[MYBaseModel class]] map:^id(MYBaseModel *model) {
            if ([model.success intValue] == 1) {
                    return model.data;
            }else{
                [SVProgressHUD showErrorWithStatus:model.message];
                return nil;
            }
        }] doError:^(NSError *error) {
            [MYNetError ShowRequestErrorMessage:error];
        }];
    }];
    
    self.agentApplyCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSDictionary *params) {
        return [[[MYHTTPSessionManager racPostWithURL:[NSString stringWithFormat:@"%@%@",kServerPath,Agent_Apply] params:params class:[MYBaseModel class]] map:^id(MYBaseModel *model) {
            if ([model.success intValue] == 1) {
                return model.data;
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
