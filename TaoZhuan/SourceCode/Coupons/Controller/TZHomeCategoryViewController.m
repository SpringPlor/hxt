//
//  TZHomeCategoryViewController.m
//  ZhaoQuanWang
//
//  Created by 彭佳伟 on 2017/11/8.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "TZHomeCategoryViewController.h"
#import "TZSearchProductCell.h"
#import "TZSearchHeaderView.h"
#import "TZSearchProductViewModel.h"
#import "TZProductDetailViewController.h"
#import "UIBarButtonItem+MYExtension.h"

@interface TZHomeCategoryViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic,assign) NSInteger pageNo;
@property (nonatomic,strong) TZSearchProductViewModel *searchViewModel;
@property (nonatomic,strong) NSMutableArray *modelArray;
@property (nonatomic,copy) NSString *order;//排序方式

@end

@implementation TZHomeCategoryViewController

- (UICollectionView *)collectionView{
    if (_collectionView == nil) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _flowLayout.minimumLineSpacing = 5;
        _flowLayout.minimumInteritemSpacing = 5;
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _flowLayout.sectionHeadersPinToVisibleBounds = YES;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT-40) collectionViewLayout:_flowLayout];
        [self.view addSubview:_collectionView];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[TZSearchProductCell class] forCellWithReuseIdentifier:NSStringFromClass([TZSearchProductCell class])];
        [_collectionView registerClass:[TZSearchHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([TZSearchHeaderView class])];
        _collectionView.backgroundColor = rGB_Color(240, 240, 240);
        _collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            _pageNo = 0;
            [self loadDawanjiaData];
        }];
        _collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            _pageNo ++;
            [self loadDawanjiaData];
        }];
    }
    return _collectionView;
}

//设置状态栏颜色
-(void)viewWillAppear:(BOOL)animated{
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self collectionView];
    [self dawanjiaCommand];
    // Do any additional setup after loading the view.
}

- (void)dawanjiaCommand{
    //大玩家搜索command
    //q，sort，order，start，limit，keywords
    self.pageNo = 0;
    self.order = @"default";
    self.modelArray = [NSMutableArray array];
    self.searchViewModel = [TZSearchProductViewModel new];
    @weakify(self)
    [[self.searchViewModel.searchCommand.executionSignals switchToLatest] subscribeNext:^(NSArray *products) {
        @strongify(self)
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshing];
        if (products) {
            if (_pageNo == 0) {
                [self.modelArray removeAllObjects];
            }
            [self.modelArray addObjectsFromArray:[TZSearchProductModel mj_objectArrayWithKeyValuesArray:products]];
            [self.collectionView reloadData];
        }
    }];
    [self loadDawanjiaData];
}

- (void)loadDawanjiaData{
    if (self.order == nil) {
        self.order = @"default";
    }
    [self.searchViewModel.searchCommand execute:@{@"q":@"1",@"sort":self.sort,@"order":self.order,@"start":[NSString stringWithFormat:@"%ld",(long)self.pageNo*20],@"limit":@"20"}];
}

#pragma mark - collectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.modelArray.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(SCREEN_WIDTH, 40);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((SCREEN_WIDTH-5)/2, (SCREEN_WIDTH-5)/2+96);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if (kind == UICollectionElementKindSectionHeader){
        TZSearchHeaderView *headerView = (TZSearchHeaderView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([TZSearchHeaderView class]) forIndexPath:indexPath];
        [headerView setTapBlcok:^(NSString *order){
            _pageNo = 0;
            _order = order;
            [_collectionView.mj_header beginRefreshing];
        }];
        return headerView;
    }
    return nil;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    TZSearchProductCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([TZSearchProductCell class]) forIndexPath:indexPath];
    if (indexPath.row < self.modelArray.count) {
        [cell setCellInfoWithDWJModel:self.modelArray[indexPath.row]];
    }
    return cell;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsZero;
}

#pragma mark - collectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.modelArray.count != 0) {
        TZProductDetailViewController *detailVC = [[TZProductDetailViewController alloc] init];
        detailVC.productModel = self.modelArray[indexPath.row];
        //detailVC.codeType = CodeType_Default;
        [self.navigationController pushViewController:detailVC animated:YES];
    }
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
