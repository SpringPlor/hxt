//
//  MYHomeSearchViewController.m
//  MaiYou
//
//  Created by bm on 2017/3/17.
//  Copyright © 2017年 PengJiawei. All rights reserved.
//

typedef enum : NSUInteger {
    DWJDataType,//大玩家数据
    TBDataType,//淘宝数据
} DataType;

#import <AlibcTradeBiz/AlibcTradeBiz.h>
#import <AlibcTradeSDK/AlibcTradeSDK.h>
#import <AlibabaAuthSDK/albbsdk.h>
#import "TZSearchViewController.h"
#import "MYTitleView.h"
#import "TZSearchProductCell.h"
#import "TZSearchProductViewModel.h"
#import "TZSearchProductModel.h"
#import "TZHomeSearchView.h"
#import "TZSearchHeaderView.h"
#import "TZProductDetailViewController.h"
#import "TZNOSearchProductView.h"
#import "TZSearchModel.h"
#import "TZALiTradeAPITools.h"
#import "TZSearchResultModel.h"
#import "TZDeviceModel.h"
#import "TZBannerViewModel.h"
#import "TZProductWebViewController.h"

@interface TZSearchViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITextFieldDelegate>

@property (nonatomic,strong) TZSearchProductViewModel *searchViewModel;
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic,strong) UILabel *keywordLabel;
@property (nonatomic,strong) UITextField *textfield;
@property (nonatomic,strong) NSMutableArray *modelArray;//储存大玩家搜索数据
@property (nonatomic,strong) NSMutableArray *tbDataArray;//储存淘宝搜索数据
@property (nonatomic,strong) NSMutableArray *searchResultArray;
@property (nonatomic,assign) NSInteger pageSize;
@property (nonatomic,assign) NSInteger pageNo;
@property (nonatomic,copy)   NSString *order;
@property (nonatomic,strong) TZHomeSearchView *searchView;
@property (nonatomic,strong) TZNOSearchProductView *noSearchView;
@property (nonatomic,strong) TZSearchModel *searchModel;//保存淘宝搜索字段信息
@property (nonatomic,assign) DataType dataType;
@property (nonatomic,assign) BOOL resetHeader;//是否需要重置header
@property (nonatomic,strong) UIView *titleView;
@property (nonatomic,strong) TZTaoBaoProductModel *tbModel;//保存点击的model
@property (nonatomic,strong) TZBannerViewModel *bannerViewModel;
@property (nonatomic,copy) NSArray *latestArray;//保存上次获取数据

@end

@implementation TZSearchViewController

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
    self.navigationController.navigationBarHidden = YES;
    //[self initSearchView];
}

- (void)viewWillDisappear:(BOOL)animated{
    //[self.titleView removeFromSuperview];
    self.navigationController.navigationBarHidden = NO;
}

- (TZHomeSearchView *)searchView{
    if (_searchView == nil) {
        _searchView = [[TZHomeSearchView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        [kWindow addSubview:_searchView];
        _searchView.alpha = 0;
        _searchView.hidden = YES;
        WeakSelf(self);
        [_searchView setCancelBlock:^{
            [UIView animateWithDuration:0.3 animations:^{
                weakSelf.searchView.alpha = 0;
            } completion:^(BOOL finished) {
                weakSelf.searchView.hidden = YES;
            }];
            
        }];
        [_searchView setSearchBlock:^(NSString *keyWord){
            weakSelf.searchView.alpha = 0;
            weakSelf.searchView.hidden = YES;
            weakSelf.pageNo = 0;
            weakSelf.searchKeyword = keyWord;
            weakSelf.order = nil;
            weakSelf.keywordLabel.text = keyWord;
            weakSelf.resetHeader = YES;
            [weakSelf loadDataWithStart:weakSelf.pageNo order:nil];
        }];
    }
    return _searchView;
}

- (UICollectionView *)collectionView{
    if (_collectionView == nil) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _flowLayout.minimumLineSpacing = 5;
        _flowLayout.minimumInteritemSpacing = 5;
        _flowLayout.sectionHeadersPinToVisibleBounds = YES;
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64) collectionViewLayout:_flowLayout];
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
            self.latestArray = @[];
            [self loadDataWithStart:_pageNo order:_order];
        }];
        _collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            _pageNo ++;
            [self loadMoreDataWithStart:_pageNo order:_order];
        }];
    }
    return _collectionView;
}

- (void)initSearchView{
    self.titleView = [MYBaseView viewWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, 44) backgroundColor:[UIColor whiteColor]];//[[MYTitleView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    //self.navigationItem.titleView = self.titleView;
    [self.view addSubview:self.titleView];
    
    UIView *searchView =  [[MYTitleView alloc] initWithFrame:CGRectZero];
    searchView.backgroundColor = [UIColor colorWithHexString:@"#eeeeee" alpha:1.0];
    [self.titleView addSubview:searchView];
    [searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleView).offset(15);
        make.width.mas_equalTo(SCREEN_WIDTH-75);
        make.top.equalTo(self.titleView).offset(7);
        make.height.mas_equalTo(30);
    }];
    searchView.layer.cornerRadius = 15;
    [searchView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(searchAction)]];
    searchView.userInteractionEnabled = YES;
    
    UIImageView *searchImageView = [MYBaseView imageViewWithFrame:CGRectZero andImage:[UIImage imageNamed:@"组1"]];
    [searchView addSubview:searchImageView];
    [searchImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(searchView).offset(15);
        make.centerY.equalTo(searchView);
        make.width.height.mas_equalTo(15);
    }];
    
    self.keywordLabel = [MYBaseView labelWithFrame:CGRectZero text:@"搜索商品" textColor:[UIColor colorWithHexString:TZ_BLACK alpha:1.0] textAlignment:NSTextAlignmentLeft andFont:kFont(13)];
    [searchView addSubview:self.keywordLabel];
    [self.keywordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(searchImageView.mas_right).offset(10);
        make.centerY.equalTo(searchView);
        make.right.equalTo(searchView.mas_right);
    }];
    self.keywordLabel.text = self.searchKeyword;
    
    UIButton *cancelBtn = [MYBaseView buttonWithFrame:CGRectZero buttonType:UIButtonTypeCustom title:@"取消" titleColor:[UIColor colorWithHexString:TZ_BLACK alpha:1.0] font:kFont(15)];
    [self.titleView addSubview:cancelBtn];
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(searchView.mas_right);
        make.centerY.equalTo(searchView);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(30);
    }];
    [cancelBtn addTarget:self action:@selector(cancelSearch) forControlEvents:UIControlEventTouchUpInside];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    [self initSearchView];
    [self collectionView];
    [self dawanjiaCommand];//大玩家搜索
    [self bindingTBCommand];//淘宝搜索
    [self bindingBannerCommand];
    [self loadDataWithStart:_pageNo order:nil];
}

- (void)initNoSearchView{
    self.noSearchView = [[TZNOSearchProductView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    [self.view addSubview:self.noSearchView];
    WeakSelf(self);
    [self.noSearchView setTapBlock:^(TZServiceGoodsModel *model){
        TZProductDetailViewController *detailVC = [[TZProductDetailViewController alloc] init];
        detailVC.detailModel = model;
        [weakSelf.navigationController pushViewController:detailVC animated:YES];
        
    }];
}

//根据输入的搜索关键字搜索
- (void)loadDataWithStart:(NSInteger)start order:(NSString *)order{
    self.latestArray = @[];
    [self.modelArray removeAllObjects];
    [self.tbDataArray removeAllObjects];
    if (order == nil) {
        order = @"default";
    }
    self.dataType = DWJDataType;
    [self.searchViewModel.searchCommand execute:@{@"q":@"2",@"sort":@"all",@"order":order,@"start":[NSString stringWithFormat:@"%ld",start*20],@"limit":@"20",@"keywords":self.searchKeyword}];
    /*if (self.searchKeyword.length > 10) {
     self.dataType = TBDataType;
     NSDictionary *dic = @{@"method":ALiTradeSearchMethod,@"app_key":AliTradeSDK_Key,@"sign_method":@"md5",@"timestamp":[ZMUtils currentDateStr],@"format":@"json",@"v":@"2.0",@"fields":@"num_iid,title,pict_url,small_images,reserve_price,zk_final_price,user_type,provcity,item_url,seller_id,volume,nick",@"q":self.searchKeyword,@"page_no":@(_pageNo),@"page_size":@"20"};
     self.searchModel = [TZSearchModel mj_objectWithKeyValues:dic];
     NSString *string = [TZALiTradeAPITools fetchApiSin:self.searchModel];
     [self.searchViewModel.AliSearchCommand execute:@{@"method":ALiTradeSearchMethod,@"app_key":AliTradeSDK_Key,@"sign_method":@"md5",@"sign":string,@"timestamp":[ZMUtils currentDateStr],@"format":@"json",@"v":@"2.0",@"fields":@"num_iid,title,pict_url,small_images,reserve_price,zk_final_price,user_type,provcity,item_url,seller_id,volume,nick",@"q":self.searchKeyword,@"page_no":@(_pageNo),@"page_size":@"20"}];
     }else{
     if (order == nil) {
     order = @"default";
     }
     self.dataType = DWJDataType;
     [self.searchViewModel.searchCommand execute:@{@"q":@"2",@"sort":@"all",@"order":order,@"start":[NSString stringWithFormat:@"%ld",(long)start],@"limit":@"20",@"keywords":self.searchKeyword}];
     }*/
}

- (void)loadMoreDataWithStart:(NSInteger)start order:(NSString *)order{
    if (self.dataType == TBDataType) {
        NSDictionary *params = @{@"q":self.searchKeyword,@"_t":[ZMUtils getCurrentTimestamp],@"yxjh":@"-1",@"perPageSize":@"20",@"toPage":[NSString stringWithFormat:@"%ld",_pageNo]};
        [self.searchViewModel.AliSearchCommand execute:params];
        /*NSDictionary *dic = @{@"method":ALiTradeSearchMethod,@"app_key":AliTradeSDK_Key,@"sign_method":@"md5",@"timestamp":[ZMUtils currentDateStr],@"format":@"json",@"v":@"2.0",@"fields":@"num_iid,title,pict_url,small_images,reserve_price,zk_final_price,user_type,provcity,item_url,seller_id,volume,nick",@"q":self.searchKeyword,@"page_no":@(_pageNo),@"page_size":@"20"};
         self.searchModel = [TZSearchModel mj_objectWithKeyValues:dic];
         NSString *string = [TZALiTradeAPITools fetchApiSin:self.searchModel];
         [self.searchViewModel.AliSearchCommand execute:@{@"method":ALiTradeSearchMethod,@"app_key":AliTradeSDK_Key,@"sign_method":@"md5",@"sign":string,@"timestamp":[ZMUtils currentDateStr],@"format":@"json",@"v":@"2.0",@"fields":@"num_iid,title,pict_url,small_images,reserve_price,zk_final_price,user_type,provcity,item_url,seller_id,volume,nick",@"q":self.searchKeyword,@"page_no":@(_pageNo),@"page_size":@"20"}];*/
        
    }else{
        if (order == nil) {
            order = @"default";
        }
        [self.searchViewModel.searchCommand execute:@{@"q":@"2",@"sort":@"all",@"order":order,@"start":[NSString stringWithFormat:@"%ld",start*20],@"limit":@"10",@"keywords":self.searchKeyword}];
    }
}

#pragma mark  - Aciton
- (void)searchAction{
    [self.searchView loadSearchRecord];
    self.searchView.hidden = NO;
    self.searchView.textfield.text = self.searchKeyword;
    [UIView animateWithDuration:0.3 animations:^{
        self.searchView.alpha = 1;
    }];
}

- (void)cancelSearch{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)dawanjiaCommand{
    //大玩家搜索command
    //q，sort，order，start，limit，keywords
    _pageNo = 0;
    _modelArray = [NSMutableArray array];
    self.searchViewModel = [TZSearchProductViewModel new];
    @weakify(self)
    [[self.searchViewModel.searchCommand.executionSignals switchToLatest] subscribeNext:^(NSArray *products) {
        @strongify(self);
        [self.modelArray addObjectsFromArray:[TZSearchProductModel mj_objectArrayWithKeyValuesArray:products]];
        if (self.modelArray.count == 0) {
            //淘宝搜索
            self.dataType = TBDataType;
            /*NSDictionary *dic = @{@"method":ALiTradeSearchMethod,@"app_key":AliTradeSDK_Key,@"sign_method":@"md5",@"timestamp":[ZMUtils currentDateStr],@"format":@"json",@"v":@"2.0",@"fields":@"num_iid,title,pict_url,small_images,reserve_price,zk_final_price,user_type,provcity,item_url,seller_id,volume,nick",@"q":self.searchKeyword,@"page_no":@(_pageNo),@"page_size":@"20"};
             self.searchModel = [TZSearchModel mj_objectWithKeyValues:dic];
             NSString *string = [TZALiTradeAPITools fetchApiSin:self.searchModel];
             [self.searchViewModel.AliSearchCommand execute:@{@"method":ALiTradeSearchMethod,@"app_key":AliTradeSDK_Key,@"sign_method":@"md5",@"sign":string,@"timestamp":[ZMUtils currentDateStr],@"format":@"json",@"v":@"2.0",@"fields":@"num_iid,title,pict_url,small_images,reserve_price,zk_final_price,user_type,provcity,item_url,seller_id,volume,nick",@"q":self.searchKeyword,@"page_no":@(_pageNo),@"page_size":@"20"}];*/
            _pageNo = 1;
            NSDictionary *params = @{@"q":self.searchKeyword,@"_t":[ZMUtils getCurrentTimestamp],@"yxjh":@"-1",@"perPageSize":@"20",@"toPage":[NSString stringWithFormat:@"%ld",(long)_pageNo]};
            [self.searchViewModel.AliSearchCommand execute:params];
        }else{
            self.dataType = DWJDataType;
            [self.collectionView reloadData];
        }
        [_collectionView.mj_header endRefreshing];
        [_collectionView.mj_footer endRefreshing];
    }];
    
}

- (void)bindingTBCommand{//淘宝搜索
    /*method    : API接口名称。(淘宝客商品查询)
     app_key    : appkey
     sign_method: 签名的摘要算法，可选值为：hmac，md5。
     sign       : 签名
     timestamp  : 时间戳，格式为yyyy-MM-dd HH:mm:ss
     format     ：响应格式。默认为xml格式，可选值：xml，json
     v          : 2.0 版本号
     fields : 返回数据中需要返回字段
     page_no
     page_size
     */
    //淘宝搜索
    self.tbDataArray = [NSMutableArray array];
    @weakify(self)
    [[self.searchViewModel.AliSearchCommand.executionSignals switchToLatest] subscribeNext:^(id x) {
        @strongify(self)
        [self.tbDataArray addObjectsFromArray:[TZTaoBaoProductModel mj_objectArrayWithKeyValuesArray:x[@"data"][@"pageList"]]];
        if (self.tbDataArray.count == 0) {
            [self initNoSearchView];
            [self.bannerViewModel.bannerCommand execute:@{@"categoryId":@"5",@"pageNum":@"0",@"pageSize":@"50"}];
        }else{
            self.dataType = TBDataType;
            [self.noSearchView removeFromSuperview];
        }
        [self.collectionView reloadData];
        [_collectionView.mj_header endRefreshing];
        [_collectionView.mj_footer endRefreshing];
    }];
    
    [[self.searchViewModel.bingOrderCommand.executionSignals switchToLatest] subscribeNext:^(MYBaseModel *model) {
        if (model) {
            //[SVProgressHUD showSuccessWithStatus:@"回调成功"];
        }
    }];
}

- (void)bindingBannerCommand{
    self.bannerViewModel = [TZBannerViewModel new];
    @weakify(self);
    [[self.bannerViewModel.bannerCommand.executionSignals switchToLatest] subscribeNext:^(NSArray *dataArray) {
        @strongify(self);
        if (dataArray) {
            [self.noSearchView.dataArray addObjectsFromArray:[TZServiceGoodsModel mj_objectArrayWithKeyValuesArray:dataArray]];
            [self.noSearchView.collectionView reloadData];
        }
    }];
}


#pragma mark - collectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (self.dataType == TBDataType) {
        return self.tbDataArray.count;
    }
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
        if (self.resetHeader) {
            [headerView resetHeader];
            self.resetHeader = NO;
        }
        if (self.dataType == TBDataType) {
            [headerView BannedClick:YES];
        }else{
            [headerView BannedClick:NO];
        }
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
    if (self.dataType == TBDataType) {
        if (self.tbDataArray.count != 0) {
            [cell setCellInfoWithTBModel:self.tbDataArray[indexPath.row]];
        }
    }else{
        if (self.modelArray.count != 0) {
            [cell setCellInfoWithDWJModel:self.modelArray[indexPath.row]];
        }
    }
    return cell;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsZero;
}

#pragma mark - collectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.dataType == TBDataType) {
        TZProductDetailViewController *detailVC = [[TZProductDetailViewController alloc] init];
        detailVC.resultModel = self.tbDataArray[indexPath.row];
        [self.navigationController pushViewController:detailVC animated:YES];
        return;
    }else{
        TZProductDetailViewController *detailVC = [[TZProductDetailViewController alloc] init];
        detailVC.productModel = self.modelArray[indexPath.row];
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
