//
//  TZHomeViewModel.m
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/9/28.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "TZHomeViewModel.h"

@implementation TZHomeViewModel

- (instancetype)init{
    self = [super init];
    if (self) {
        [self setUp];
    }
    return self;
}

- (void)setUp{
    self.bannerCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSDictionary *params) {
       return [[[MYHTTPSessionManager racPostWithURL:[NSString stringWithFormat:@"%@%@",kServerPath,Home_Banner] params:params class:nil] map:^id(id value) {
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
    
    self.bannerDetailCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSDictionary *params) {
        return [[[MYHTTPSessionManager racPostWithURL:[NSString stringWithFormat:@"%@%@",kServerPath,Banner_Detail] params:params class:nil] map:^id(id value) {
            return value;
        }] doError:^(NSError *error) {
            [MYNetError ShowRequestErrorMessage:error];
        }];
    }];
    
    self.hotCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSDictionary *params) {
        return [[[MYHTTPSessionManager racPostWithURL:[NSString stringWithFormat:@"%@%@",kServerPath,Home_Banner_Hot] params:params class:nil] map:^id(id value) {
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
    
    self.snapUpCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSDictionary *params) {
        return [[[MYHTTPSessionManager racPostWithURL:[NSString stringWithFormat:@"%@%@",kServerPath,Home_Snap_UP] params:params class:[TZBaseModel class]] map:^id(TZBaseModel *model) {
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
    
    self.categoryCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSDictionary *params) {
        return [[[MYHTTPSessionManager racPostWithURL:[NSString stringWithFormat:@"%@%@",kServerPath,Home_Category_Image] params:params class:nil] map:^id(id value) {
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
    
    self.versionCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSString *url) {
        return [[[MYHTTPSessionManager racGetWithURL:[NSString stringWithFormat:@"%@",url] params:nil class:nil] map:^id(id value) {
            if ([value[@"success"] intValue] == 1) {
                return value[@"data"];
            }else{
                //[SVProgressHUD showErrorWithStatus:value[@"message"]];
                return nil;
            }
        }] doError:^(NSError *error) {
            [MYNetError ShowRequestErrorMessage:error];
        }];
    }];
    
    self.snapGoodsCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSDictionary *params) {
        return [[[MYHTTPSessionManager racPostWithURL:[NSString stringWithFormat:@"%@%@",kServerPath,Goods_Category] params:params class:[TZBaseModel class]] map:^id(TZBaseModel *model) {
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
    
    self.popCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSDictionary *params) {
        return [[[MYHTTPSessionManager racPostWithURL:[NSString stringWithFormat:@"%@%@",kServerPath,Home_Popover] params:params class:[TZBaseModel class]] map:^id(TZBaseModel *model) {
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
    
    self.popGoodsCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSDictionary *params) {
        return [[[MYHTTPSessionManager racPostWithURL:[NSString stringWithFormat:@"%@%@",kServerPath,Goods_Category] params:params class:[TZBaseModel class]] map:^id(TZBaseModel *model) {
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
    
    self.recommendCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSDictionary *params) {
        return [[[MYHTTPSessionManager racPostWithURL:[NSString stringWithFormat:@"%@%@",kServerPath,Searc_Recommand] params:params class:[TZBaseModel class]] map:^id(TZBaseModel *model) {
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
    
    self.recommendShopsCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSDictionary *params) {
        return [[[MYHTTPSessionManager racPostWithURL:[NSString stringWithFormat:@"%@%@",kServerPath,Goods_Category] params:params class:[TZBaseModel class]] map:^id(TZBaseModel *model) {
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
