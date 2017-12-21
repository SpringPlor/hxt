//
//  TZSearchRecommandCell.m
//  ZhaoQuanWang
//
//  Created by 彭佳伟 on 2017/11/29.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "TZSearchRecommandCell.h"

@implementation TZSearchRecommandCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.dataArray = [NSMutableArray array];
        [self initView];
    }
    return self;
}

- (void)initView{
    _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _flowLayout.minimumLineSpacing = 5;
    _flowLayout.minimumInteritemSpacing = 5;
    _flowLayout.sectionHeadersPinToVisibleBounds = YES;
    _flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64-40) collectionViewLayout:_flowLayout];
    [self addSubview:_collectionView];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [_collectionView registerClass:[TZSearchProductCell class] forCellWithReuseIdentifier:NSStringFromClass([TZSearchProductCell class])];
    [_collectionView registerClass:[TZNOSearchHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([TZNOSearchHeaderView class])];
    _collectionView.backgroundColor = rGB_Color(240, 240, 240);
    /*_collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
     }];
     _collectionView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
     }];*/
}

- (void)setCellInfoWithArray:(NSArray *)dataArray{
    [self.dataArray removeAllObjects];
    [self.dataArray addObjectsFromArray:dataArray];
    [self.collectionView reloadData];
}

#pragma mark - collectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(SCREEN_WIDTH, 47);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((SCREEN_WIDTH-5)/2, (SCREEN_WIDTH-5)/2+96);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if (kind == UICollectionElementKindSectionHeader){
        TZNOSearchHeaderView *headerView = (TZNOSearchHeaderView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([TZNOSearchHeaderView class]) forIndexPath:indexPath];
        return headerView;
    }
    return nil;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    TZSearchProductCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([TZSearchProductCell class]) forIndexPath:indexPath];
    [cell setCellInfoWithServiceModel:self.dataArray[indexPath.row]];
    return cell;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsZero;
}

#pragma mark - collectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.dataArray.count != 0) {
        TZHomeBannerDetailModel *model = self.dataArray[indexPath.row];
        if (self.tapBlock) {
            self.tapBlock(model);
        }
    }
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
