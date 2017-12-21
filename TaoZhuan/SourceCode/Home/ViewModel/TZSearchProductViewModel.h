//
//  TZSearchProductViewModel.h
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/9/28.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "MYBaseViewModel.h"

@interface TZSearchProductViewModel : MYBaseViewModel

@property (nonatomic,strong) RACCommand *searchCommand;//大玩家搜索

@property (nonatomic,strong) RACCommand *applyUrlCommand;//大玩家转链接

@property (nonatomic,strong) RACCommand *AliSearchCommand;//淘宝搜索

@property (nonatomic,strong) RACCommand *AliDetailCommand;//api无权访问，弃用

@property (nonatomic,strong) RACCommand *AliUrlTransformCommand;//转换淘宝商品链接

@property (nonatomic,strong) RACCommand *bingOrderCommand;//绑定订单号

@property (nonatomic,strong) RACCommand *applyXoridCommand;//获取转链接时的认证码

@property (nonatomic,strong) RACCommand *pdtPicCommand;//商品图片

@property (nonatomic,strong) RACCommand *mergeUrlCommand;//高佣链接

@property (nonatomic,strong) RACCommand *tklCommand;//淘口令链接

@property (nonatomic,strong) RACCommand *shortUrlCommand;//转短连接


- (void)searchProductWithParams:(NSDictionary *)params successBlock:(void (^)(id response))successBlock errorBlock:(void (^)(NSError *error))errorBlock;

@end
