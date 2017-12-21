//
//  TZNOSearchProductView.m
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/10/12.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "TZNOSearchProductView.h"
#import "TZNOSearchCell.h"

@implementation TZNOSearchProductView

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
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) collectionViewLayout:_flowLayout];
        [self addSubview:_collectionView];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[TZNOSearchCell class] forCellWithReuseIdentifier:NSStringFromClass([TZNOSearchCell class])];
        [_collectionView registerClass:[TZSearchProductCell class] forCellWithReuseIdentifier:NSStringFromClass([TZSearchProductCell class])];
        [_collectionView registerClass:[TZNOSearchHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([TZNOSearchHeaderView class])];
        _collectionView.backgroundColor = rGB_Color(240, 240, 240);
        /*_collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        }];
        _collectionView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        }];*/
}

#pragma mark - collectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    return self.dataArray.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return CGSizeZero;
    }
    return CGSizeMake(SCREEN_WIDTH, 47);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return CGSizeMake(SCREEN_WIDTH, 525/2*kScale);
    }
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
    if (indexPath.section == 0) {
        TZNOSearchCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([TZNOSearchCell class]) forIndexPath:indexPath];
        return cell;
    }else{
        TZSearchProductCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([TZSearchProductCell class]) forIndexPath:indexPath];
        [cell setCellInfoWithServiceModel:self.dataArray[indexPath.row]];
        return cell;
    }
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsZero;
}

#pragma mark - collectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.dataArray.count != 0) {
        TZServiceGoodsModel *model = self.dataArray[indexPath.row];
        if (self.tapBlock) {
            self.tapBlock(model);
        }
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
