//
//  TZSearchResultModel.h
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/9/29.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TZTaoBaoProductModel;

@interface TZSearchResultModel : NSObject

#pragma mark - 淘宝搜索结果

@property (nonatomic,copy) NSString *item_url;
@property (nonatomic,copy) NSString *nick;
@property (nonatomic,copy) NSString *num_iid;
@property (nonatomic,copy) NSString *pict_url;
@property (nonatomic,copy) NSString *provcity;
@property (nonatomic,copy) NSString *reserve_price;
@property (nonatomic,copy) NSString *seller_id;
@property (nonatomic,copy) NSDictionary *small_images;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *user_type;
@property (nonatomic,copy) NSString *volume;
@property (nonatomic,copy) NSString *zk_final_price;

@end

#pragma marlk - 抓包搜索结果
@interface TZTaoBaoProductModel : MYBaseModel

@property (nonatomic,copy) NSString *pictUrl;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *shopTitle;
@property (nonatomic,copy) NSString *auctionId;
@property (nonatomic,copy) NSString *auctionUrl;
@property (nonatomic,assign) CGFloat zkPrice;
@property (nonatomic,assign) CGFloat reservePrice;
@property (nonatomic,copy) NSString *totalNum;
@property (nonatomic,assign) NSInteger couponAmount;
@property (nonatomic,copy) NSString * couponLink;//券链接
@property (nonatomic,assign) CGFloat tkRate;//淘宝佣金比率
@property (nonatomic,copy) NSString *userType;//1天猫，0淘宝

/*
@property (nonatomic,copy) NSString *pictUrl;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *shopTitle;
@property (nonatomic,copy) NSString *auctionId;
@property (nonatomic,copy) NSString *auctionUrl;
@property (nonatomic,assign) CGFloat zkPrice;
@property (nonatomic,copy) NSString *tkRate;
@property (nonatomic,assign) CGFloat reservePrice;
@property (nonatomic,copy) NSString *totalNum;
@property (nonatomic,copy) NSString *couponAmount;
@property (nonatomic,copy) NSString *couponEffectiveEndTime;
@property (nonatomic,copy) NSString *couponEffectiveStartTime;//券有效开始时间
*/

@end
