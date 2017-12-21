//
//  TZSearchRecommandCell.h
//  ZhaoQuanWang
//
//  Created by 彭佳伟 on 2017/11/29.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TZSearchProductCell.h"
#import "TZNOSearchHeaderView.h"
#import "TZHomeBannerDetailModel.h"

@interface TZSearchRecommandCell : UITableViewCell<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,copy) void (^tapBlock)(TZHomeBannerDetailModel *model);

- (void)setCellInfoWithArray:(NSArray *)dataArray;

@end
