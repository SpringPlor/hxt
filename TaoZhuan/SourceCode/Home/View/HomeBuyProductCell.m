//
//  HomeBuyProductCell.m
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/9/30.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "HomeBuyProductCell.h"

@interface HomeBuyProductCell ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) NSArray *dataArray;

@end

@implementation HomeBuyProductCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _flowLayout.minimumLineSpacing = 5;
        _flowLayout.minimumInteritemSpacing = 5;
        _flowLayout.sectionHeadersPinToVisibleBounds = YES;
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(15, 0, SCREEN_WIDTH-15, 200) collectionViewLayout:_flowLayout];
        [self.contentView addSubview:_collectionView];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[HomeTodayProductCell class] forCellWithReuseIdentifier:NSStringFromClass([HomeTodayProductCell class])];
    }
    return self;
}

#pragma mark - collectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(115, 200);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HomeTodayProductCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([HomeTodayProductCell class]) forIndexPath:indexPath];
    [cell setCellInfoWithModel:self.dataArray[indexPath.row]];
    return cell;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsZero;
}

#pragma mark - collectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    if (self.tapBlock) {
        self.tapBlock(indexPath.row);
    }
}

- (void)setCellInfoWithArray:(NSArray *)dataArray{
    if (dataArray.count != 0) {
        self.dataArray = dataArray;
        [self.collectionView reloadData];
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
