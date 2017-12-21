//
//  TZSearchSortView.h
//  ZhaoQuanWang
//
//  Created by 彭佳伟 on 2017/11/2.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TZSearchSortView : UIView

@property (nonatomic,strong) UIButton *zhButton;//综合
@property (nonatomic,strong) UIButton *yhlButton;//优惠券
@property (nonatomic,strong) UIButton *xlButton;//销量
@property (nonatomic,strong) UIButton *qhjButton;//券后价
@property (nonatomic,strong) UIView *redView;
@property (nonatomic,copy) void (^tapBlcok)(NSInteger index,NSString *order);

- (instancetype)initWithFrame:(CGRect)frame;

- (void)resetHeader;

- (void)BannedClick:(BOOL)click;//搜索结果为淘宝数据时，禁止分类点击

@end
