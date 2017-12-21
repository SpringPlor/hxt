//
//  TZHomeBannerDetailModel.h
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/10/16.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "MYBaseModel.h"

@interface TZHomeBannerDetailModel : MYBaseModel

@property (nonatomic,copy) NSString *commodityUrl;
@property (nonatomic,copy) NSString *couponPrice;
@property (nonatomic,copy) NSString *creationTime;
@property (nonatomic,copy) NSString *describe;
@property (nonatomic,copy) NSString *disPrice;
@property (nonatomic,copy) NSString *id;
@property (nonatomic,copy) NSString *imgUrl;
@property (nonatomic,copy) NSString *oriPrice;
@property (nonatomic,copy) NSString *origionUrl;
@property (nonatomic,copy) NSString *remainCount;
@property (nonatomic,copy) NSString *shop;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *totalCount;
@property (nonatomic,copy) NSString *startDate;
@property (nonatomic,copy) NSString *endDate;
@property (nonatomic,copy) NSString *buyerCount;//销量

@end
