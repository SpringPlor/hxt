//
//  TZSearchProductModel.h
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/10/9.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TZSearchProductModel : NSObject

#pragma mark - 大玩家搜索结果
//@property (nonatomic,copy) NSString *cpnstartfee;//原价
@property (nonatomic,copy) NSString *cpnaddr;//券地址
@property (nonatomic,copy) NSString *pdtpic;
@property (nonatomic,copy) NSString *pdttitle;
@property (nonatomic,copy) NSString *pdttitletb;
@property (nonatomic,assign) int cpnprice;//券价
@property (nonatomic,copy) NSString *pdtbuy;//券后价
@property (nonatomic,copy) NSString *pdtprice;//原价
@property (nonatomic,copy) NSString *pdtid;
@property (nonatomic,copy) NSString *xorid;
@property (nonatomic,copy) NSString *pdtsell;//销量
@property (nonatomic,copy) NSString *pdtdesc;//描述
@property (nonatomic,copy) NSString *cpnstart;//起始时间
@property (nonatomic,copy) NSString *cpnend;//结束时间
@property (nonatomic,copy) NSString *pdtaddr;//商品地址
@property (nonatomic,assign) CGFloat cmsrate;//佣金比率
@property (nonatomic,copy) NSString *shoptmall;//1、天猫，0、淘宝

@end
