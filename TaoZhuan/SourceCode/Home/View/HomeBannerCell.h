//
//  HomeBannerCell.h
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/9/30.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TZHomeBannerModel.h"

@interface HomeBannerCell : UITableViewCell<SDCycleScrollViewDelegate>

@property (nonatomic,strong) SDCycleScrollView *cycleScrollView;
@property (nonatomic,strong) UIImageView *arcImageView;
@property (nonatomic,copy) void (^bannerTapBlcok)(NSInteger index);
@property (nonatomic,copy) void (^itemTapBlcok)(NSInteger index);

- (void)setBannerInfoWithArray:(NSArray *)array;

@end
