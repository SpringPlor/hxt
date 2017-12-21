//
//  TZBalanceOrderModel.h
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/10/23.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "MYBaseModel.h"

@interface TZBalanceOrderModel : MYBaseModel

@property (nonatomic,copy) NSString *checkAmount;
@property (nonatomic,copy) NSString *creationTime;
@property (nonatomic,copy) NSString *commodityCount;
@property (nonatomic,copy) NSString *commodityImgUrl;
@property (nonatomic,copy) NSString *commodityInfo;
@property (nonatomic,copy) NSString *dealPlatform;
@property (nonatomic,copy) NSString *id;
@property (nonatomic,copy) NSString *orderCreateDate;
@property (nonatomic,copy) NSString *orderType;
@property (nonatomic,copy) NSString *payAmount;
@property (nonatomic,copy) NSString *phoneNumber;
@property (nonatomic,copy) NSString *price;
@property (nonatomic,copy) NSString *returnIntegral;
@property (nonatomic,copy) NSString *returnMoney;
@property (nonatomic,copy) NSString *shopName;
@property (nonatomic,copy) NSString *status;
@property (nonatomic,copy) NSString *tbOrderId;

@end
