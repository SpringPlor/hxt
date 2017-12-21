//
//  TZSearchHeaderView.h
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/10/11.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TZSearchHeaderView : UICollectionReusableView

@property (nonatomic,strong) UIButton *zhButton;//综合
@property (nonatomic,strong) UIImageView *zhArrowImageView;
@property (nonatomic,strong) UIButton *yhlButton;//优惠券
@property (nonatomic,strong) UIImageView *yhlArrowImageView;
@property (nonatomic,strong) UIButton *xlButton;//销量
@property (nonatomic,strong) UIImageView *xlArrowImageView;
@property (nonatomic,strong) UIButton *qhjButton;//券后价
@property (nonatomic,strong) UIImageView *qhjArrowImageView;
@property (nonatomic,copy) void (^tapBlcok)(NSString *order);

- (void)resetHeader;

- (void)BannedClick:(BOOL)click;//搜索结果为淘宝数据时，禁止分类点击

@end
