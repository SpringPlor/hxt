//
//  TZServiceGoodsModel.h
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/12/12.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "MYBaseModel.h"

@interface TZServiceGoodsModel : MYBaseModel
/*
categoryId = 4;
commodityUrl = "https://uland.taobao.com/coupon/edetail?e=GN38oRr7cjAGQASttHIRqRDXlKTehvlZXFNvGt2iZJ9z8VXAFroNinpzC6zg0NTY2ZA9FvqSG67HYtb0iz9yAr9fwBwwUiql6DF%2F2MLpJMq9GaVAvC2u%2FW7PVn13QcLNgPRfTgnhrZM%3D&traceId=0bfa317a15100245095361848e&activityId=72ff6d5e61c24292981e47cb317ab3bb";
description = "\U63a8\U8350\U7406\U7531\Uff1a\U65f6\U5c1a\U6f6e\U6d41\U9614\U817f\U88e4~\U8212\U9002\U5f39\U529b\U6bdb\U5462\U9762\U6599~80-150\U65a4\U5747\U53ef\U7a7f\Uff0c\U52a0\U539a\U6bdb\U5462\U3001\U6297\U8d77\U7403\Uff0c\U7a7f\U7740\U8212\U9002~\U79cb\U51ac\U5fc5\U5907~";
discountPrice = 38;
id = 170;
imageUrl = "https://img.alicdn.com/imgextra/i1/792241300/TB24eQxbhTI8KJjSspiXXbM4FXa_!!792241300.jpg_400x400.jpg";
title = "\U3010\U5723\U591a\U540d\U59ae\U3011\U79cb\U51ac\U65b0\U6b3e\U6bdb\U5462\U9614\U817f\U88e4";
*/
 
@property (nonatomic,copy) NSString * id;
@property (nonatomic,copy) NSString * commodityId;//淘宝商品ID
@property (nonatomic,copy) NSString * title; //- String : 商品标题
@property (nonatomic,copy) NSString * shortTitle; // - String : 商品短标题
@property (nonatomic,copy) NSString * category; // - String : 淘宝商品大分类
@property (nonatomic,copy) NSString * leafCategory; // - String : 淘宝商品小分类
@property (nonatomic,assign) CGFloat price; // - Double : 商品售价
@property (nonatomic,assign) NSInteger sales; // - Integer : 商品销量
@property (nonatomic,copy) NSString *describe;//- String : 商品文案描述
@property (nonatomic,copy) NSString *imageUrl; // - String : 商品图片地址
@property (nonatomic,copy) NSString *commodityUrl; // - String : 商品链接地址
@property (nonatomic,assign) CGFloat commission; // - Double : 佣金
@property (nonatomic,assign) NSInteger commissionType; // - Integer : 佣金类型(1:定向计划 2:高拥 3:通用 4:营销计划)
@property (nonatomic,copy) NSString * commissionLink; // - String : 计划链接
@property (nonatomic,assign) BOOL couponIsCheck; // - Boolean : 是否校验后的券 (0 未验证 1 已验证有效性)
@property (nonatomic,copy) NSString *couponId; // - String : 券ID (阿里券的券id不可用)
@property (nonatomic,assign) NSInteger couponType; // - Integer : 券类型 (0:未知 1:商品单品 2:店铺)
@property (nonatomic,assign) CGFloat couponPrice; // - Double : 券价格
@property (nonatomic,assign) NSInteger couponNumber; // - Integer : 券剩余数
@property (nonatomic,assign) NSInteger couponLimit; // - Integer : 券限领数 (-1表示无限制)
@property (nonatomic,assign) NSInteger couponOver; // - Integer : 券已领数
@property (nonatomic,assign) CGFloat couponCondition; // - Float : 券使用条件
@property (nonatomic,copy) NSString *couponUrl; // - String : 优惠券地址
@property (nonatomic,copy) NSString *couponInfo; // - String : 优惠券信息
@property (nonatomic,copy) NSString *couponStartTime; // - Long : 券开始时间
@property (nonatomic,copy) NSString *couponEndTime; // - Long : 券结束时间
@property (nonatomic,assign) BOOL isTmall; // - Boolean : 是否是天猫
@property (nonatomic,assign) BOOL jhs; // - Boolean : 聚划算
@property (nonatomic,assign) BOOL guoye; // - Boolean : 过夜
@property (nonatomic,assign) BOOL yugao; // - Boolean : 预告
@property (nonatomic,assign) BOOL tqg; // - Boolean : 淘抢购
@property (nonatomic,assign) BOOL ali; // - Boolean : 阿里券 (阿里券的券id不可用)
@property (nonatomic,assign) CGFloat discountPrice;// - Double : 折后价
@property (nonatomic,copy) NSString *shop;// - String : 店名
@property (nonatomic,copy) NSString *shopInformation;// - String : 店铺信息
@property (nonatomic,copy) NSString *commOri;// - String : 商品源.淘宝或天猫
@property (nonatomic,copy) NSString *labels;// - String : 用户标签
@property (nonatomic,copy) NSString *categoryId;// - String : Category的主键id
@property (nonatomic,copy) NSString *recommendImageUrl;// - String : 推荐长图
@property (nonatomic,copy) NSString *videoUrl;// - String : 视频地址
@property (nonatomic,copy) NSString *recommendText;// - String : 推荐语
@property (nonatomic,copy) NSString *couponName;// - String : 优惠券名称
@property (nonatomic,assign) NSInteger couponTotal;// - Integer : 券总量
@property (nonatomic,assign) CGFloat serviceCharge;// - Double : 服务单价
@property (nonatomic,copy) NSString *remark;// - String : 备注


@end
