//
//  TZTodayBuyViewController.m
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/10/23.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "TZTodayBuyViewController.h"
#import "TZSearchProductCell.h"
#import "TZHomeViewModel.h"
#import "TZProductDetailViewController.h"
#import "TZServiceGoodsModel.h"

@interface TZTodayBuyViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITextFieldDelegate>

@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic,assign) NSInteger pageNo;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) TZHomeViewModel *homeViewModel;
@property (nonatomic,strong) NSString *goods;//商品ids

@end

@implementation TZTodayBuyViewController

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
        [_collectionView registerClass:[TZSearchProductCell class] forCellWithReuseIdentifier:NSStringFromClass([TZSearchProductCell class])];
        _collectionView.backgroundColor = rGB_Color(240, 240, 240);
        _collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            _pageNo = 1;
            [self.dataArray removeAllObjects];
            [self.homeViewModel.snapGoodsCommand execute:@{@"goodIds":self.goods,@"pageNum":@(self.pageNo),@"pageSize":@"20"}];
        }];
        _collectionView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
            _pageNo ++;
            [self.homeViewModel.snapGoodsCommand execute:@{@"goodIds":self.goods,@"pageNum":@(self.pageNo),@"pageSize":@"20"}];
        }];
    }
    return _collectionView;
}

-(void)viewWillAppear:(BOOL)animated{
    [TZStatusBarStyle setStatusBarColor:[UIColor whiteColor]];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    self.navigationController.navigationBarHidden = NO;
}

- (NSString *)title{
    return @"今日必抢";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self collectionView];
    [self bindingCommand];
    // Do any additional setup after loading the view.
}

- (void)bindingCommand{
    self.pageNo = 1;
    self.goods = @"";
    self.dataArray = [NSMutableArray array];
    self.homeViewModel = [TZHomeViewModel new];
    @weakify(self);
    [[self.homeViewModel.snapUpCommand.executionSignals switchToLatest] subscribeNext:^(NSArray *dataArray) {
        @strongify(self);
        if (dataArray.count != 0) {
            self.goods = dataArray[0][@"goodsId"];
            [self.homeViewModel.snapGoodsCommand execute:@{@"goodIds":self.goods,@"pageNum":@"1",@"pageSize":@"20"}];
        }
    }];
    [self.homeViewModel.snapUpCommand execute:nil];
    
    [[self.homeViewModel.snapGoodsCommand.executionSignals switchToLatest] subscribeNext:^(NSArray *dataArray) {
        @strongify(self);
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshing];
        if (dataArray) {
            [self.dataArray addObjectsFromArray:[TZServiceGoodsModel mj_objectArrayWithKeyValuesArray:dataArray]];
            [self.collectionView reloadData];
        }
    }];
}

#pragma mark - collectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((SCREEN_WIDTH-5)/2, (SCREEN_WIDTH-5)/2+96);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    TZSearchProductCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([TZSearchProductCell class])forIndexPath:indexPath];
    if (indexPath.row < self.dataArray.count) {
        [cell setCellInfoWithServiceModel:self.dataArray[indexPath.row]];
    }
    return cell;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsZero;
}

#pragma mark - collectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    TZProductDetailViewController *detailVC = [[TZProductDetailViewController alloc] init];
    if (indexPath.row < self.dataArray.count) {
        detailVC.detailModel = self.dataArray[indexPath.row];
    }
    [self.navigationController pushViewController:detailVC animated:YES];
}


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
