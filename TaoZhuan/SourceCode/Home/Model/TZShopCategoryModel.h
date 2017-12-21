//
//  TZShopCategoryModel.h
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/12/12.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "MYBaseModel.h"

@interface TZShopCategoryModel : MYBaseModel
/*
id - Long : id
title - String : 标题
type - Integer : 类型。 1:Banner 2:限时抢购 3:推荐商品 4:热搜 5:弹窗
imgUrl - String : 图片
groupNumber - Long : 商品组编号
startTime - Long : 开始时间
endTime - Long : 结束时间
orderId - Integer : 排序
goodsId - String : 商品id，多个用逗号分隔
*/
@property (nonatomic,copy) NSString *id;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *type;
@property (nonatomic,copy) NSString *imgUrl;
@property (nonatomic,assign) NSInteger groupNumber;
@property (nonatomic,assign) NSInteger startTime;
@property (nonatomic,assign) NSInteger endTime;
@property (nonatomic,assign) NSInteger orderId;
@property (nonatomic,copy) NSString *goodsId;

@end
