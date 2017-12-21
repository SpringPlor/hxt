//
//  TZReturnJfOrderModel.h
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/10/18.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "MYBaseModel.h"

@interface TZReturnJfOrderModel : MYBaseModel

@property (nonatomic,copy) NSString *tbOrderId;//淘宝订单号
@property (nonatomic,copy) NSString *creationTime;//时间
@property (nonatomic,copy) NSString *status;//订单状态.1:审核中;2:即将到账;3:已到账;4:无效订单 (必填)
@property (nonatomic,copy) NSString *commodityInfo;//商品名字
@property (nonatomic,copy) NSString *commodityImgUrl;
@property (nonatomic,assign) CGFloat checkAmount;//结算金额
@property (nonatomic,copy) NSString  *checkDate;//结算时间
@property (nonatomic,assign) NSInteger returnIntegral;//返积分


@end
