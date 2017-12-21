//
//  TZJFOrderModel.h
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/10/21.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "MYBaseModel.h"

@interface TZJFOrderModel : MYBaseModel

@property (nonatomic,copy) NSString *orderId;
@property (nonatomic,copy) NSString *commodityCount;
@property (nonatomic,copy) NSString *commodityId;
@property (nonatomic,copy) NSString *orderCreateDate;
@property (nonatomic,copy) NSString *payAmount;
@property (nonatomic,copy) NSString *imgUrl;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *marketPrice;
@property (nonatomic,copy) NSString *integral;

@end
