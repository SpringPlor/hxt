//
//  MYHTTPSessionManager.h
//  MaiYou
//
//  Created by PengJiawei on 2017/1/11.
//  Copyright © 2017年 PengJiawei. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

typedef enum {
    RequestTypePost = 1,
    RequestTypeGet
}RequestType;

@interface MYHTTPSessionManager : AFHTTPSessionManager

+ (MYHTTPSessionManager *)shareInstance;


/**
 网络请求的公共接口方法

 @param requestType 请求类型
 @param url         接口
 @param params      参数
 @param successBlock     成功回调
 @param errorBlock     失败回调
 */
- (void)requestWithRequestType:(RequestType)requestType url:(NSString *)url params:(NSDictionary *)params fileData:(NSData *)fileData fileName:(NSString *)fileName successBlock:(void (^)(id response)) successBlock errorBlock:(void (^)(NSError *error))errorBlock;

- (void)requestWithRequestType:(RequestType)requestType url:(NSString *)url params:(NSDictionary *)params successBlock:(void (^)(id response)) successBlock errorBlock:(void (^)(NSError *error))errorBlock;


//默认请求类型
//Post
+ (RACSignal *)racPostWithURL:(NSString *)url params:(id)params class:(Class)objClass;

//Get
+ (RACSignal *)racGetWithURL:(NSString *)url params:(id)params class:(Class)objClass;;

//json请求类型
+ (RACSignal *)racPostJsonWithURL:(NSString *)url params:(id)params class:(Class)objClass;

//上传文件
+ (RACSignal *)racUploadWithURL:(NSString *)url params:(NSDictionary *)params fileData:(NSData *)fileData fileName:(NSString *)fileName class:(Class)objClass;

//淘宝数据获取
//+ (RACSignal *)racAliDataPostWithURL:(NSString *)url params:(id)params class:(__unsafe_unretained Class)objClass;


@end
