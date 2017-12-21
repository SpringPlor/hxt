//
//  TZReturnJFExchangeViewController.m
//  ZhaoQuanWang
//
//  Created by 彭佳伟 on 2017/11/21.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "TZReturnJFExchangeViewController.h"
#import "TZReturnJFExchangeHeadView.h"
#import "TZReturnJFExchangeCell.h"
#import "TZJFViewModel.h"
#import "TZJFProductModel.h"
#import "TZJFSuccessViewController.h"

@interface TZReturnJFExchangeViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic,assign) NSInteger pageNo;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) TZJFViewModel *viewModel;

@end

@implementation TZReturnJFExchangeViewController

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
        [_collectionView registerClass:[TZReturnJFExchangeCell class] forCellWithReuseIdentifier:NSStringFromClass([TZReturnJFExchangeCell class])];
        [_collectionView registerClass:[TZReturnJFExchangeHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([TZReturnJFExchangeHeadView class])];
        _collectionView.backgroundColor = [UIColor colorWithHexString:TZ_TableView_Color alpha:1.0];
        _collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            _pageNo = 1;
            [self.viewModel.jfProductCommand execute:@{@"from":@"0",@"to":@"",@"pageNum":[NSString stringWithFormat:@"%ld",_pageNo],@"pageSize":@"20"}];
        }];
        _collectionView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
            _pageNo ++;
            [self.viewModel.jfProductCommand execute:@{@"from":@"0",@"to":@"",@"pageNum":[NSString stringWithFormat:@"%ld",_pageNo],@"pageSize":@"20"}];
        }];
    }
    return _collectionView;
}


- (NSString *)title{
    return @"积分兑换";
}

-(void)viewWillAppear:(BOOL)animated{
    [TZStatusBarStyle setStatusBarColor:[UIColor whiteColor]];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:TZ_TableView_Color alpha:1.0];
    [self collectionView];
    [self bindingCommand];
    // Do any additional setup after loading the view.
}

- (void)bindingCommand{
    self.pageNo = 1;
    self.dataArray = [NSMutableArray array];
    self.viewModel = [TZJFViewModel new];
    @weakify(self);
    [[self.viewModel.jfProductCommand.executionSignals switchToLatest] subscribeNext:^(NSArray *dataArray) {
        @strongify(self);
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshing];
        if (dataArray) {
            [self.dataArray addObjectsFromArray:[TZJFProductModel mj_objectArrayWithKeyValuesArray:dataArray]];
        }
        [self.collectionView reloadData];
    }];
    
    [[self.viewModel.jfExchangeCommand.executionSignals switchToLatest] subscribeNext:^(MYBaseModel *model) {
        if (model) {
            @strongify(self);
            TZJFSuccessViewController *successVC = [[TZJFSuccessViewController alloc] init];
            [self.navigationController pushViewController:successVC animated:YES];
        }
    }];
    [self.viewModel.jfProductCommand execute:@{@"from":@"0",@"to":@"",@"pageNum":[NSString stringWithFormat:@"%ld",_pageNo],@"pageSize":@"20"}];
}

#pragma mark - collectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(SCREEN_WIDTH, 160*kScale+60);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((SCREEN_WIDTH-5)/2, (SCREEN_WIDTH-5)/2+60);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if (kind == UICollectionElementKindSectionHeader){
        TZReturnJFExchangeHeadView *headerView = (TZReturnJFExchangeHeadView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([TZReturnJFExchangeHeadView class]) forIndexPath:indexPath];
        return headerView;
    }
    return nil;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    TZReturnJFExchangeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([TZReturnJFExchangeCell class]) forIndexPath:indexPath];
    if (indexPath.row < self.dataArray.count) {
        [cell setCellInfoWithModel:self.dataArray[indexPath.row]];
    }
    return cell;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsZero;
}

#pragma mark - collectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    [MobClick event:jifenduihuan];
    if ([UserDefaultsOFK(Login_Status) intValue] == 1) {
        TZJFProductModel *model = self.dataArray[indexPath.row];
        if ([MYSingleton shareInstonce].userInfoModel.integral < model.integral) {
            [SVProgressHUD showInfoWithStatus:@"您的积分不够兑换此商品~"];
            return ;
        }
        [UIAlertController showAlertInViewController:self withTitle:nil message:@"领确定要兑换吗" cancelButtonTitle:@"点错了" destructiveButtonTitle:@"确定" otherButtonTitles:nil tapBlock:^(UIAlertController * _Nonnull controller, UIAlertAction * _Nonnull action, NSInteger buttonIndex) {
            if (buttonIndex == 0) {
                
            }else{
                [self.viewModel.jfExchangeCommand execute:@{@"u":[MYSingleton shareInstonce].loginModel.id,@"t":[MYSingleton shareInstonce].loginModel.accessToken,@"integralCommodityId":model.id}];
            }
        }];
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
