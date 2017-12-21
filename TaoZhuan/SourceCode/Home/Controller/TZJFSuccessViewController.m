//
//  TZJFSuccessViewController.m
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/10/16.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "TZJFSuccessViewController.h"
#import "TZSearchProductCell.h"
#import "TZJFSuccessCell.h"
#import "TZJFSuccessHeaderView.h"
#import "TZHomeViewModel.h"
#import "TZBannerViewModel.h"
#import "TZHomeBannerDetailModel.h"
#import "TZProductDetailViewController.h"
#import "TZShopCategoryModel.h"

@interface TZJFSuccessViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic,strong) TZHomeViewModel *viewModel;
@property (nonatomic,strong) TZBannerViewModel *bannerViewModel;
@property (nonatomic,assign) NSInteger pageNo;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,copy) NSString *categoryId;

@end

@implementation TZJFSuccessViewController

- (UICollectionView *)collectionView{
    if (_collectionView == nil) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _flowLayout.minimumLineSpacing = 5;
        _flowLayout.minimumInteritemSpacing = 5;
        _flowLayout.sectionHeadersPinToVisibleBounds = YES;
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) collectionViewLayout:_flowLayout];
        [self.view addSubview:_collectionView];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[TZJFSuccessCell class] forCellWithReuseIdentifier:NSStringFromClass([TZJFSuccessCell class])];
        [_collectionView registerClass:[TZSearchProductCell class] forCellWithReuseIdentifier:NSStringFromClass([TZSearchProductCell class])];
        [_collectionView registerClass:[TZJFSuccessHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([TZJFSuccessHeaderView class])];
        _collectionView.backgroundColor = rGB_Color(240, 240, 240);
        _collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            _pageNo = 1;
            [self.dataArray removeAllObjects];
            [self.viewModel.snapGoodsCommand execute:@{@"goodIds":self.categoryId,@"pageNum":@(self.pageNo),@"pageSize":@"20"}];        }];
        _collectionView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
            _pageNo ++;
            [self.viewModel.snapGoodsCommand execute:@{@"goodIds":self.categoryId,@"pageNum":@(self.pageNo),@"pageSize":@"20"}];
        }];
    }
    return _collectionView;
}

- (NSString *)title{
    return @"兑换成功";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self collectionView];
    [self bindingCommand];
    // Do any additional setup after loading the view.
}

- (void)bindingCommand{
    self.pageNo = 1;
    self.viewModel = [TZHomeViewModel new];
    self.dataArray = [NSMutableArray array];
    @weakify(self);
    [[self.viewModel.snapUpCommand.executionSignals switchToLatest] subscribeNext:^(NSArray *dataArray) {
        @strongify(self);
        if (dataArray.count != 0) {
            TZShopCategoryModel *model = [TZShopCategoryModel mj_objectWithKeyValues:dataArray[0]];
            self.categoryId = model.goodsId;
            [self.viewModel.snapGoodsCommand execute:@{@"goodIds":self.categoryId,@"pageNum":@"1",@"pageSize":@"20"}];
        }
    }];
    [self.viewModel.snapUpCommand execute:nil];
    
    [[self.viewModel.snapGoodsCommand.executionSignals switchToLatest] subscribeNext:^(NSArray *dataArray) {
        @strongify(self);
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshing];
        if (dataArray.count != 0) {
            [self.dataArray addObjectsFromArray:[TZServiceGoodsModel mj_objectArrayWithKeyValuesArray:dataArray]];
        }
        [self.collectionView reloadData];
    }];
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
        return CGSizeMake(SCREEN_WIDTH, 160);
    }
    return CGSizeMake((SCREEN_WIDTH-5)/2, (SCREEN_WIDTH-5)/2+96);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if (kind == UICollectionElementKindSectionHeader){
        TZJFSuccessHeaderView *headerView = (TZJFSuccessHeaderView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([TZJFSuccessHeaderView class]) forIndexPath:indexPath];
        return headerView;
    }
    return nil;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        TZJFSuccessCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([TZJFSuccessCell class]) forIndexPath:indexPath];
        return cell;
    }else{
        TZSearchProductCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([TZSearchProductCell class]) forIndexPath:indexPath];
        if (indexPath.row < self.dataArray.count) {
            [cell setCellInfoWithServiceModel:self.dataArray[indexPath.row]];
        }
        return cell;
    }
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsZero;
}

#pragma mark - collectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    TZProductDetailViewController *detailVC = [[TZProductDetailViewController alloc] init];
    detailVC.detailModel = self.dataArray[indexPath.row];
    [self.navigationController pushViewController:detailVC animated:YES];}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
