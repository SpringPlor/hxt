//
//  TZSearchFilterView.h
//  ZhaoQuanWang
//
//  Created by 彭佳伟 on 2017/11/30.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TZSearchFilterView : UIView

@property (nonatomic,strong) UIImageView *couponIcon;
@property (nonatomic,strong) UILabel *textLabel;
@property (nonatomic,strong) UIButton *filterButton;
@property (nonatomic,strong) UIImageView *filterIcon;
@property (nonatomic,assign) BOOL filterCoupon;
@property (nonatomic,copy) void (^filterStatus)(BOOL filter);

@end
