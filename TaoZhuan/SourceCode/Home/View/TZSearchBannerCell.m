//
//  TZSearchBannerCell.m
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/10/11.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "TZSearchBannerCell.h"

@implementation TZSearchBannerCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero imageURLStringsGroup:nil];
        [self.contentView addSubview:self.cycleScrollView];
        [self.cycleScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(self.contentView);
            make.centerX.equalTo(self.contentView);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
        }];
        self.cycleScrollView.delegate = self;
    }
    return self;
}

- (void)setBannerInfoWithArray:(NSArray *)array{
    NSMutableArray *urlArray = [NSMutableArray array];
    for (int i = 0; i < array.count ; i++){
        TZHomeBannerModel *model = array[i];
        if (model.imgUrl) {
            [urlArray addObject:model.imgUrl];
        }
    }
    self.cycleScrollView.imageURLStringsGroup = urlArray;
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    if (self.tapBlcok) {
        self.tapBlcok(index);
    }
}

@end
