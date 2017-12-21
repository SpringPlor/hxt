//
//  TZBannerDetailsViewController.m
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/10/18.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "TZBannerDetailsViewController.h"
#import "TZSearchProductCell.h"
#import "TZBannerViewModel.h"
#import "TZHomeBannerDetailModel.h"
#import "TZProductDetailViewController.h"

@interface TZBannerDetailsViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic,assign) NSInteger pageNo;
@property (nonatomic,strong) NSMutableArray *modelArray;
@property (nonatomic,strong) TZBannerViewModel *viewModel;
@property (nonatomic,assign) NSInteger latestNum;

@end

@implementation TZBannerDetailsViewController

- (UICollectionView *)collectionView{
    if (_collectionView == nil) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _flowLayout.minimumLineSpacing = 5;
        _flowLayout.minimumInteritemSpacing = 5;
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _flowLayout.sectionHeadersPinToVisibleBounds = YES;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT-64) collectionViewLayout:_flowLayout];
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
            [self.modelArray removeAllObjects];
            [self.viewModel.bannerCommand execute:@{@"u":[MYSingleton shareInstonce].loginModel.id,@"t":[MYSingleton shareInstonce].loginModel.accessToken,@"categoryId":self.bannerModel.id,@"pageNum":[NSString stringWithFormat:@"%ld",_pageNo],@"pageSize":@"20"}];
        }];
        _collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            _pageNo ++;
            [self.viewModel.bannerCommand execute:@{@"u":[MYSingleton shareInstonce].loginModel.id,@"t":[MYSingleton shareInstonce].loginModel.accessToken,@"categoryId":self.bannerModel.id,@"pageNum":[NSString stringWithFormat:@"%ld",_pageNo],@"pageSize":@"20"}];
        }];
    }
    return _collectionView;
}

//设置状态栏颜色
- (void)setStatusBarBackgroundColor:(UIColor *)color {
    
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = color;
    }
}
-(void)viewWillAppear:(BOOL)animated{
    [self setStatusBarBackgroundColor:[UIColor whiteColor]];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

- (NSString *)title{
    return self.bannerModel.title;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self collectionView];
    [self bindingCommand];
    // Do any additional setup after loading the view.
}

- (void)bindingCommand{
    self.pageNo = 1;
    self.modelArray = [NSMutableArray array];
    self.viewModel = [TZBannerViewModel new];
    @weakify(self);
    [[self.viewModel.bannerCommand.executionSignals switchToLatest] subscribeNext:^(NSArray *dataArray) {
        @strongify(self);
        if (dataArray.count != 0) {
            [self.modelArray addObjectsFromArray:[TZHomeBannerDetailModel mj_objectArrayWithKeyValuesArray:dataArray]];
        }
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshing];
        [self.collectionView reloadData];
    }];
    [self.viewModel.bannerCommand execute:@{@"categoryId":self.bannerModel.id,@"pageNum":[NSString stringWithFormat:@"%ld",_pageNo],@"pageSize":@"20"}];
}

#pragma mark - collectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.modelArray.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((SCREEN_WIDTH-5)/2, (SCREEN_WIDTH-5)/2+96);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    TZSearchProductCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([TZSearchProductCell class]) forIndexPath:indexPath];
    [cell setCellInfoWithServiceModel:self.modelArray[indexPath.row]];
    return cell;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsZero;
}

#pragma mark - CollcetionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    TZProductDetailViewController *detailVC = [[TZProductDetailViewController alloc] init];
    detailVC.detailModel = self.modelArray[indexPath.row];
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
