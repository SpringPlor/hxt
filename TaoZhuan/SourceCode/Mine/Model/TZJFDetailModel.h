//
//  TZJFDetailModel.h
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/10/17.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "MYBaseModel.h"

@interface TZJFDetailModel : MYBaseModel

@property (nonatomic,assign) CGFloat amount;//积分变化值
@property (nonatomic,assign) NSString *integralType;//变化类型,1：兑换零钱；2：兑换优惠券；3:兑换积分商品;   11：订单录入；12：签到
@property (nonatomic,copy) NSString *remainAmount;
@property (nonatomic,copy) NSString *creationTime;

@end
