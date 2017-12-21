//
//  HomeBuyTodayCell.h
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/9/30.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TZHomeBannerModel.h"

@interface HomeBuyTodayCell : UITableViewCell

@property (nonatomic,strong) UIImageView *packageImageView;
@property (nonatomic,strong) UILabel *todayBuyLabel;
@property (nonatomic,strong) UILabel *timeLabel;
@property (nonatomic,strong) UIImageView *todayImageView;
@property (nonatomic,strong) UILabel *hLabel;//时
@property (nonatomic,strong) UILabel *mLabel;//分
@property (nonatomic,strong) UILabel *sLabel;//秒

@property (nonatomic,copy) void (^tapBlock)();

@end
