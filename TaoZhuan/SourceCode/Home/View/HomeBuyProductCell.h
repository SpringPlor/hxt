//
//  HomeBuyProductCell.h
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/9/30.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeTodayProductView.h"
#import "HomeTodayProductCell.h"
#import "TZHomeBannerDetailModel.h"

@interface HomeBuyProductCell : UITableViewCell

@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) UICollectionViewFlowLayout *flowLayout;

@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,copy) void (^tapBlock)(NSInteger index);

- (void)setCellInfoWithArray:(NSArray *)dataArray;

@end
