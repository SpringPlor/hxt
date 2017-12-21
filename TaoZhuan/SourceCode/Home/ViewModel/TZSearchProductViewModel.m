//
//  TZSearchProductViewModel.m
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/9/28.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "TZSearchProductViewModel.h"

@implementation TZSearchProductViewModel

- (instancetype)init{
    self = [super init];
    if (self) {
        [self setUp];
    }
    return self;
}

- (void)setUp{
    self.searchCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSDictionary *params) {
        return [[[MYHTTPSessionManager racGetWithURL:Dawanjia_Api params:params class:nil] map:^id(id value) {
            return value;
        }] doError:^(NSError *error) {
            [MYNetError ShowRequestErrorMessage:error];
        }];
    }];
    self.searchCommand.allowsConcurrentExecution = YES;
    
    self.applyUrlCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSDictionary *params) {
       return [[[MYHTTPSessionManager racPostWithURL:ApplyUrl_Api params:params class:nil] map:^id(id value) {
           return value;
       }] doError:^(NSError *error) {
           [MYNetError ShowRequestErrorMessage:error];
       }];
    }];
    
    self.AliSearchCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSDictionary *params) {
       return [[[MYHTTPSessionManager racGetWithURL:AliTrade_Search_Api params:params class:nil] map:^id(id value) {
           return value;
       }] doError:^(NSError *error) {
           [MYNetError ShowRequestErrorMessage:error];
       }];
    }];
    
    self.AliDetailCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSDictionary *params) {
        return [[[MYHTTPSessionManager racGetWithURL:AliTrade_Search_Api params:params class:nil] map:^id(id value) {
            return value;
        }] doError:^(NSError *error) {
            [MYNetError ShowRequestErrorMessage:error];
            
        }];
    }];
    
    self.AliUrlTransformCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSDictionary *params) {
        return [[[MYHTTPSessionManager racGetWithURL:AliTrade_Transform_Api params:params class:nil] map:^id(id value) {
            return value;
        }] doError:^(NSError *error) {
            [MYNetError ShowRequestErrorMessage:error];
            
        }];
    }];
    
    self.bingOrderCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSDictionary *params) {
        return [[[MYHTTPSessionManager racGetWithURL:[NSString stringWithFormat:@"%@%@",kServerPath,Bind_Order] params:params class:[MYBaseModel class]] map:^id(MYBaseModel *model) {
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

    self.applyXoridCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSDictionary *params) {
        return [[[MYHTTPSessionManager racPostWithURL:Apply_Xor_id params:params class:nil] map:^id(id value) {
            return value;
        }] doError:^(NSError *error) {
            [MYNetError ShowRequestErrorMessage:error];
        }];
    }];
    
    
    self.pdtPicCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSDictionary *params) {
        return [[[MYHTTPSessionManager racPostWithURL:TaoBao_Pdt_Pic_URL params:params class:nil] map:^id(id value) {
            if (value[@"data"][@"images"]) {
                return value[@"data"][@"images"];
            }else{
                return nil;
            }
        }] doError:^(NSError *error) {
            [MYNetError ShowRequestErrorMessage:error];
        }];
    }];
    
    self.mergeUrlCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSDictionary *params) {
        return [[[MYHTTPSessionManager racGetWithURL:[NSString stringWithFormat:@"%@%@",kServerPath,Merge_Url] params:params class:[MYBaseModel class]] map:^id(MYBaseModel *model) {
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
    
    self.tklCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSDictionary *params) {
        return [[[MYHTTPSessionManager racGetWithURL:[NSString stringWithFormat:@"%@%@",kServerPath,Tao_Token_Url] params:params class:nil] map:^id(id value) {
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

    self.shortUrlCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSDictionary *params) {
        return [[[MYHTTPSessionManager racPostJsonWithURL:@"http://suo.im/api.php" params:params class:nil] map:^id(id value) {
            NSString *result = [[NSString alloc]initWithData:value encoding:NSUTF8StringEncoding];
            return result;
        }] doError:^(NSError *error) {
            [MYNetError ShowRequestErrorMessage:error];
        }];
    }];

}

- (void)searchProductWithParams:(NSDictionary *)params successBlock:(void (^)(id))successBlock errorBlock:(void (^)(NSError *))errorBlock{
    [[MYHTTPSessionManager shareInstance] requestWithRequestType:RequestTypeGet url:AliTrade_Search_Api params:params successBlock:^(id response) {
        successBlock(response);
    } errorBlock:^(NSError *error) {
        errorBlock(error);
    }];
}

@end
