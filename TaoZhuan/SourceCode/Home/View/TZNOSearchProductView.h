//
//  TZNOSearchProductView.h
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/10/12.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TZSearchProductCell.h"
#import "TZNOSearchHeaderView.h"
#import "TZServiceGoodsModel.h"

@interface TZNOSearchProductView : UIView<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>


@property (nonatomic,strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,copy) void (^tapBlock)(TZServiceGoodsModel *model);

@end
