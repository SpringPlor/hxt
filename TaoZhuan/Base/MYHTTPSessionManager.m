//
//  MYHTTPSessionManager.m
//  MaiYou
//
//  Created by PengJiawei on 2017/1/11.
//  Copyright © 2017年 PengJiawei. All rights reserved.
//

#import "MYHTTPSessionManager.h"

@implementation MYHTTPSessionManager

+ (MYHTTPSessionManager *)shareInstance{
    static MYHTTPSessionManager *sessionManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        //设置配置文件
        //设置缓存策略
        //config.requestCachePolicy = NSURLRequestUseProtocolCachePolicy;
        //设置网络服务类型 决定了网络请求的形式
        config.networkServiceType = NSURLNetworkServiceTypeDefault;
        //设置请求超时时间
        config.timeoutIntervalForRequest = 10.0f;
        //设置请求头
        //config.HTTPAdditionalHeaders
        //网络属性  是否使用移动流量
        config.allowsCellularAccess = YES;
        NSURL *baseUrl = [NSURL URLWithString:@""];
        sessionManager = [[MYHTTPSessionManager alloc] initWithBaseURL:baseUrl sessionConfiguration:config];
        sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html",nil];
        AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
        securityPolicy.validatesDomainName = NO;
        [securityPolicy setAllowInvalidCertificates:YES];
        [sessionManager setSecurityPolicy:securityPolicy];
    });
    return sessionManager;
}

- (void)requestWithRequestType:(RequestType)requestType url:(NSString *)url params:(NSDictionary *)params fileData:(NSData *)fileData fileName:(NSString *)fileName successBlock:(void (^)(id))successBlock errorBlock:(void (^)(NSError *))errorBlock{
    switch (requestType) {
        case RequestTypeGet:{
            [self GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (successBlock) {
                    successBlock(responseObject);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (errorBlock) {
                    errorBlock(error);
                }
            }];
            break;
        }
        case RequestTypePost:{
            [self POST:[NSString stringWithFormat:@"%@%@",kInterfacePath,url] parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                [formData appendPartWithFileData:fileData name:fileName fileName:@"file.png" mimeType:@"image/png"];
            } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (successBlock) {
                    successBlock(responseObject);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (errorBlock) {
                    errorBlock(error);
                }
            }];
            /*[self POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (successBlock) {
                    successBlock(responseObject);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (errorBlock) {
                    errorBlock(error);
                }
            }];*/
            break;
        }
        default:
            break;
    }

}

- (void)requestWithRequestType:(RequestType)requestType url:(NSString *)url params:(NSDictionary *)params successBlock:(void (^)(id))successBlock errorBlock:(void (^)(NSError *))errorBlock{
    switch (requestType) {
        case RequestTypeGet:{
            [self GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (successBlock) {
                    successBlock(responseObject);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (errorBlock) {
                    errorBlock(error);
                }
            }];
            break;
        }
        case RequestTypePost:{
            [self POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (successBlock) {
                    successBlock(responseObject);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (errorBlock) {
                    errorBlock(error);
                }
            }];
            break;
        }
        default:
            break;
    }
    
}

//- (void)loginWithParams:(NSDictionary *)params successBlock:(void (^)(id))successBlock errorBlock:(void (^)(NSError *))errorBlock{
//    [self requestWithRequestType:RequestTypePost url:Merchant_Login params:params successBlock:successBlock errorBlock:errorBlock];
//}

+ (RACSignal *)racPostWithURL:(NSString *)url params:(id)params class:(__unsafe_unretained Class)objClass{
    [MYHTTPSessionManager shareInstance].responseSerializer = [AFJSONResponseSerializer serializer];
    [MYHTTPSessionManager shareInstance].responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html",nil];
    return [[[[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSURLSessionDataTask *task = [[self shareInstance] POST:[NSString stringWithFormat:@"%@",url] parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
           [self handleResultWithSubscriber:subscriber responseObject:responseObject];
       } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
           [self handleErrorResultWithSubscriber:subscriber error:error];
       }];
        return [RACDisposable disposableWithBlock:^{
            [task cancel];
        }];
    }]  map:^id(id responseObject) {
        if (objClass == nil) {
            return responseObject;
        }
        return [objClass mj_objectWithKeyValues:responseObject];
        /*if ([responseObject isKindOfClass:[NSArray class]]) {
            return [objClass mj_objectArrayWithKeyValuesArray:responseObject];
        }else{
            return [objClass mj_objectWithKeyValues:responseObject];
        }*/
    }] replayLazily] setNameWithFormat:@"<%@: %p> -racNetWithURL: %@, params: %@ class: %@",[self class],self,url,params,NSStringFromClass([objClass class])];
}

+ (RACSignal *)racGetWithURL:(NSString *)url params:(id)params class:(Class)objClass{
    [MYHTTPSessionManager shareInstance].responseSerializer = [AFJSONResponseSerializer serializer];
    [MYHTTPSessionManager shareInstance].responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html",nil];
    return [[[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSURLSessionDataTask *task = [[self shareInstance] GET:[NSString stringWithFormat:@"%@",url] parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [self handleResultWithSubscriber:subscriber responseObject:responseObject];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [self handleErrorResultWithSubscriber:subscriber error:error];
        }];
        return [RACDisposable disposableWithBlock:^{
            [task cancel];
        }];
    }]  map:^id(id responseObject) {
        if (objClass == nil) {
            return responseObject;
        }
        return [objClass mj_objectWithKeyValues:responseObject];
        /*if ([responseObject isKindOfClass:[NSArray class]]) {
         return [objClass mj_objectArrayWithKeyValuesArray:responseObject];
         }else{
         return [objClass mj_objectWithKeyValues:responseObject];
         }*/
    }] setNameWithFormat:@"<%@: %p> -racNetWithURL: %@, params: %@ class: %@",[self class],self,url,params,NSStringFromClass([objClass class])];
}

+ (RACSignal *)racPostJsonWithURL:(NSString *)url params:(id)params class:(__unsafe_unretained Class)objClass{
    [MYHTTPSessionManager shareInstance].responseSerializer = [AFHTTPResponseSerializer serializer];
    return [[[[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSURLSessionDataTask *task = [[self shareInstance] POST:[NSString stringWithFormat:@"%@%@",kInterfacePath,url] parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [self handleResultWithSubscriber:subscriber responseObject:responseObject];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [self handleErrorResultWithSubscriber:subscriber error:error];
        }];
        return [RACDisposable disposableWithBlock:^{
            [task cancel];
        }];
    }]  map:^id(id responseObject) {
        if (objClass == nil) {
            return responseObject;
        }
        return [objClass mj_objectWithKeyValues:responseObject];
        /*if ([responseObject isKindOfClass:[NSArray class]]) {
         return [objClass mj_objectArrayWithKeyValuesArray:responseObject];
         }else{
         return [objClass mj_objectWithKeyValues:responseObject];
         }*/
    }] replayLazily] setNameWithFormat:@"<%@: %p> -racNetWithURL: %@, params: %@ class: %@",[self class],self,url,params,NSStringFromClass([objClass class])];
    
}

+ (RACSignal *)racUploadWithURL:(NSString *)url params:(NSDictionary *)params fileData:(NSData *)fileData fileName:(NSString *)fileName class:(Class)objClass{
    //[MYHTTPSessionManager shareInstance].requestSerializer = [AFJSONRequestSerializer serializer];
    //[[MYHTTPSessionManager shareInstance].requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    return [[[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSURLSessionDataTask *task = [[self shareInstance] POST:[NSString stringWithFormat:@"%@%@",kInterfacePath,url] parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            if (fileData) {
                [formData appendPartWithFileData:fileData name:fileName fileName:@"file.png" mimeType:@"image/png"];
            }
        } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [self handleResultWithSubscriber:subscriber responseObject:responseObject];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [self handleErrorResultWithSubscriber:subscriber error:error];
        }];
        return  [RACDisposable disposableWithBlock:^{
            [task cancel];
        }];
    }] map:^id(id responseObject) {
        if (objClass == nil) {
            return responseObject;
        }
        return [objClass mj_objectWithKeyValues:responseObject];
    }] setNameWithFormat:@"<%@: %p> -racNetWithURL: %@, params: %@ fileName: %@ class: %@",[self class],self,url,params,fileName,NSStringFromClass([objClass class])];
}


+ (RACSignal *)racAliDataPostWithURL:(NSString *)url params:(id)params class:(__unsafe_unretained Class)objClass{
    [MYHTTPSessionManager shareInstance].responseSerializer = [AFHTTPResponseSerializer serializer];
    return [[[[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSURLSessionDataTask *task = [[self shareInstance] POST:[NSString stringWithFormat:@"%@",url] parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            NSError *error = nil;
            NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
            NSString *dataString = [[NSString alloc] initWithData:responseObject encoding:enc];
            //json数据当中没有 \n \r \t 等制表符，当后台给出有问题时，我们需要对json数据过滤
            dataString = [dataString stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
            dataString = [dataString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
            dataString = [dataString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
            
            NSData *utf8Data = [dataString dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:utf8Data options:NSJSONReadingMutableContainers error:&error];

            [self handleResultWithSubscriber:subscriber responseObject:responseObject];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [self handleErrorResultWithSubscriber:subscriber error:error];
        }];
        return [RACDisposable disposableWithBlock:^{
            [task cancel];
        }];
    }]  map:^id(id responseObject) {
        if (objClass == nil) {
            return responseObject;
        }
        return [objClass mj_objectWithKeyValues:responseObject];
        /*if ([responseObject isKindOfClass:[NSArray class]]) {
         return [objClass mj_objectArrayWithKeyValuesArray:responseObject];
         }else{
         return [objClass mj_objectWithKeyValues:responseObject];
         }*/
    }] replayLazily] setNameWithFormat:@"<%@: %p> -racNetWithURL: %@, params: %@ class: %@",[self class],self,url,params,NSStringFromClass([objClass class])];
}

+ (void)handleResultWithSubscriber:(id <RACSubscriber>)subscriber responseObject:(id)responseObject{
    //处理数据
    [subscriber sendNext:responseObject];
    [subscriber sendCompleted];
}

+ (void)handleErrorResultWithSubscriber:(id <RACSubscriber>)subscriber error:(NSError *)error{
    [subscriber sendError:error];
}

@end
