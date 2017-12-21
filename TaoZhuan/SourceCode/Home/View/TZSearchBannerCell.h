//
//  TZSearchBannerCell.h
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/10/11.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TZHomeBannerModel.h"

@interface TZSearchBannerCell : UICollectionViewCell<SDCycleScrollViewDelegate>

@property (nonatomic,strong) SDCycleScrollView *cycleScrollView;

@property (nonatomic,copy) void (^tapBlcok)(NSInteger index);

- (void)setBannerInfoWithArray:(NSArray *)array;

@end
