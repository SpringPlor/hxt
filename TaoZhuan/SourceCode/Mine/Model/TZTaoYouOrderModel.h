//
//  TZTaoYouOrderModel.h
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/12/12.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "MYBaseModel.h"

@interface TZTaoYouOrderModel : MYBaseModel

/*
id - Long : 订单id
category - String : 类目名称
checkAmount - Double : 结算金额
checkDate - Long : 结算时间
commodityCount - Integer : 商品购买数量
commodityInfo - String : 商品信息
commodityImgUrl - String : 商品图片
dealPlatform - String : 成交平台
orderCreateDate - Long : 订单创建时间
orderInputDate - Long : 订单认领日期
orderType - String : 订单类型
payAmount - Double : 付款金额
bonus - Double : 佣金
price - Double : 商品单价
shopName - String : 所属店铺
status - String : 订单状态
tbOrderId - String : 淘宝订单id
returnIntegral - Double : 返还积分
returnMoney - Double : 返利金额
phoneNumber - String : 手机号码
creationTime - Long : 记录创建时间
resultEvaluation - Double : 预估收入
*/

@property (nonatomic,copy) NSString *id;
@property (nonatomic,copy) NSString *category;
@property (nonatomic,assign) CGFloat checkAmount;
@property (nonatomic,copy) NSString *checkDate;
@property (nonatomic,assign) NSInteger commodityCount;
@property (nonatomic,copy) NSString *commodityInfo;
@property (nonatomic,copy) NSString *commodityImgUrl;
@property (nonatomic,copy) NSString *dealPlatform;
@property (nonatomic,copy) NSString *orderCreateDate;
@property (nonatomic,copy) NSString *orderInputDate;
@property (nonatomic,copy) NSString *orderType;
@property (nonatomic,assign) CGFloat payAmount;
@property (nonatomic,assign) CGFloat bonus;
@property (nonatomic,assign) CGFloat price;
@property (nonatomic,copy) NSString *shopName;
@property (nonatomic,copy) NSString *status;
@property (nonatomic,copy) NSString *tbOrderId;
@property (nonatomic,assign) CGFloat returnIntegral;
@property (nonatomic,assign) CGFloat returnMoney;
@property (nonatomic,copy) NSString *phoneNumber;
@property (nonatomic,copy) NSString *creationTime;
@property (nonatomic,assign) CGFloat resultEvaluation;
@property (nonatomic,assign) CGFloat rowHeight;

@end

@interface TZOrderImageModel : MYBaseModel

@property (nonatomic,copy) NSString *haveImage;
@property (nonatomic,copy) NSString *id;
@property (nonatomic,copy) NSString *mainImageUrl;

@end
