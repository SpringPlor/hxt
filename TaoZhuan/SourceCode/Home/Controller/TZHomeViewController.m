//
//  TZHomeViewController.m
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/9/28.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import <AlibcTradeBiz/AlibcTradeBiz.h>
#import <AlibcTradeSDK/AlibcTradeSDK.h>
#import <AlibabaAuthSDK/albbsdk.h>

#import "TZHomeViewController.h"
#import "TZSearchProductViewModel.h"
#import "TZSearchModel.h"
#import "MYTitleView.h"
#import "HomeBannerCell.h"
#import "HomeBuyTodayCell.h"
#import "HomeBuyProductCell.h"
#import "TZHomeSearchView.h"
#import "TZSearchProductViewController.h"
#import "TZQianDaoViewController.h"
#import "TZYaoQingViewController.h"
#import "TZJiFenExchangeViewController.h"
#import "TZProductDetailViewController.h"
#import "TZJHSViewController.h"
#import "TZKefuViewController.h"
#import "TZHomeViewModel.h"
#import "TZLoginViewController.h"
#import "TZHomeBannerModel.h"
#import "TZBannerDetailsViewController.h"
#import "TZBannerViewModel.h"
#import "TZTodayBuyViewController.h"
#import "TZBuyGuideViewController.h"
#import "HomeProductCell.h"
#import "HomeCategoryCell.h"
#import "TZNewVersionView.h"
#import "TZHomeRecommandView.h"
#import "TZServiceGoodsModel.h"
#import "TZShopCategoryModel.h"
#import "TZReturnJFExchangeViewController.h"

@interface TZHomeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *jxTableView;
@property (nonatomic,strong) TZSearchProductViewModel *searchViewModel;
@property (nonatomic,strong) TZHomeSearchView *searchView;
@property (nonatomic,strong) NSMutableArray *modelArray;
@property (nonatomic,assign) NSInteger pageNo;
@property (nonatomic,copy) NSString *order;//排序方式
@property (nonatomic,assign) BOOL resetHeader;//是否需要重置header
@property (nonatomic,strong) TZHomeViewModel *homeViewModel;
@property (nonatomic,strong) TZBannerViewModel *bannerViewModel;
@property (nonatomic,strong) NSMutableArray *bannerArray;
@property (nonatomic,strong) NSMutableArray *jrbqArray;//今日必抢
@property (nonatomic,copy) NSArray *popArray;//弹窗商品
@property (nonatomic,strong) UIImageView *guideImageView;
@property (nonatomic,strong) UIView *topBgView;
@property (nonatomic,assign) BOOL showSearch;//是否点击了搜索
@property (nonatomic,assign) CGFloat currentAlpha;//记录当前搜索框的颜色
@property (nonatomic,strong) TZHomeRecommandView *recommandView;

@end

@implementation TZHomeViewController

- (TZHomeSearchView *)searchView{
    if (_searchView == nil) {
        _searchView = [[TZHomeSearchView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        [kWindow addSubview:_searchView];
        _searchView.alpha = 0;
        _searchView.hidden = YES;
        WeakSelf(self);
        [_searchView setCancelBlock:^{
            weakSelf.showSearch = NO;
            [UIView animateWithDuration:0.3 animations:^{
                weakSelf.searchView.alpha = 0;
                [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
                [TZStatusBarStyle setStatusBarColor:[UIColor colorWithHexString:TZ_Main_Color alpha:weakSelf.currentAlpha]];
            } completion:^(BOOL finished) {
                weakSelf.searchView.hidden = YES;
            }];
        }];
        [_searchView setSearchBlock:^(NSString *keyWord){
            weakSelf.searchView.alpha = 0;
            weakSelf.searchView.hidden = YES;
            TZSearchProductViewController *searchVC = [[TZSearchProductViewController alloc] init];
            searchVC.searchKeyword = keyWord;
            searchVC.autSearchTB = YES;
            [weakSelf.navigationController pushViewController:searchVC animated:YES];
        }];
    }
    return _searchView;
}

- (UITableView *)jxTableView{
    if (_jxTableView == nil) {
        _jxTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-49) style:UITableViewStylePlain];
        [self.view addSubview:_jxTableView];
        _jxTableView.delegate = self;
        _jxTableView.dataSource = self;
        _jxTableView.tableFooterView = [[UIView alloc] init];
        _jxTableView.backgroundColor = rGB_Color(240, 240, 240);
        [_jxTableView setSeparatorColor:rGB_Color(240, 240, 240)];
        _jxTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            _pageNo = 0;
            [self.modelArray removeAllObjects];
            [self loadDawanjiaData];
        }];
        _jxTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            _pageNo ++;
            [self loadDawanjiaData];
        }];
    }
    return _jxTableView;
}

//设置状态栏颜色
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.showSearch = NO;
    CGPoint point = self.jxTableView.contentOffset;
    if (point.y >= 0) {
        self.topBgView.alpha = point.y/64;
        [TZStatusBarStyle setStatusBarColor:[UIColor colorWithHexString:TZ_Main_Color alpha:point.y/64]];
        self.currentAlpha = point.y/64;
    }else{
        self.topBgView.alpha = 1.0;
        [TZStatusBarStyle setStatusBarColor:[UIColor colorWithHexString:TZ_Main_Color alpha:1]];
        self.currentAlpha = 1.0;
    }
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    self.navigationController.navigationBarHidden = YES;
    [MYSingleton shareInstonce].tabBarView.hidden = NO;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
    [MYSingleton shareInstonce].tabBarView.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self searchView];
    [self jxTableView];
    [self initTopSearchView];
    [self homeCommand];
    [self dawanjiaCommand];
    // Do any additional setup after loading the view.
}

- (void)guideView{//版本引导
    NSString *guide = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeGuide"];
    if (guide == nil) {
        self.guideImageView = [MYBaseView imageViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) andImage:[UIImage imageNamed:@"homeGuide"]];
        [kWindow addSubview:self.guideImageView];
        self.guideImageView.userInteractionEnabled = YES;
        WeakSelf(self);
        [self.guideImageView addGestureRecognizer:[UITapGestureRecognizer nvm_gestureRecognizerWithActionBlock:^(UITapGestureRecognizer *sender) {
            [weakSelf.guideImageView removeFromSuperview];
            [[NSUserDefaults standardUserDefaults] setObject:@"HomeGuide" forKey:@"HomeGuide"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [self.homeViewModel.popCommand execute:nil];
        }]];
    }else{
        [self.homeViewModel.popCommand execute:nil];
    }
}

//爆款推荐
- (void)initRecommandView{
    self.recommandView = [[TZHomeRecommandView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) dataArray:self.popArray];
    [kWindow addSubview:self.recommandView];
    WeakSelf(self);
    [self.recommandView setTapBlock:^{
        [weakSelf.recommandView removeFromSuperview];
    }];
    [self.recommandView setPdtBlock:^(TZServiceGoodsModel *model){
        [weakSelf.recommandView removeFromSuperview];
        TZProductDetailViewController *pdtVC = [[TZProductDetailViewController alloc] init];
        pdtVC.detailModel = model;
        [weakSelf.navigationController pushViewController:pdtVC animated:YES];
    }];
}

- (void)initTopSearchView{
    self.topBgView = [MYBaseView viewWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, 44) backgroundColor:[UIColor colorWithHexString:TZ_LIGHT_RED alpha:1.0]];
    [self.view addSubview:self.topBgView];
    self.topBgView.alpha = 0;
    
    UIView *bgView = [MYBaseView viewWithFrame:CGRectZero backgroundColor:[UIColor whiteColor]];
    [self.view addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(27);
        make.left.equalTo(self.view).offset(15);
        make.height.mas_equalTo(30);
        make.right.equalTo(self.view.mas_right).offset(-50);
    }];
    bgView.layer.cornerRadius = 29/2;
    
    UILabel *searchLabel = [MYBaseView labelWithFrame:CGRectZero text:@"大家都在搜" textColor:[UIColor colorWithHexString:TZ_GRAY alpha:1.0] textAlignment:NSTextAlignmentLeft andFont:kFont(14)];
    [bgView addSubview:searchLabel];
    [searchLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bgView);
        make.centerX.equalTo(bgView.mas_centerX).offset(5);
    }];
    
    UIImageView *searchImageView = [MYBaseView imageViewWithFrame:CGRectZero andImage:[UIImage imageNamed:@"searchicon"]];
    [bgView addSubview:searchImageView];
    [searchImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(15);
        make.right.equalTo(searchLabel.mas_left).offset(-5);
        make.centerY.equalTo(bgView);
    }];
    [bgView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(searchProduct)]];
    searchImageView.userInteractionEnabled = YES;
    
    UIButton *cartButton = [MYBaseView buttonWithFrame:CGRectZero buttonType:UIButtonTypeCustom image:[UIImage imageNamed:@"homegouwuc"] selectImage:nil];
    [self.view addSubview:cartButton];
    [cartButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bgView);
        make.right.equalTo(self.view).offset(-15);
        make.width.height.mas_offset(20);
    }];
    cartButton.hitTestEdgeInsets = UIEdgeInsetsMake(0, 0, -20, -20);
    [cartButton addTarget:self action:@selector(cart:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)cart:(UIButton *)sender{
    id<AlibcTradePage> page = [AlibcTradePageFactory myCartsPage];
    AlibcTradeTaokeParams *taoKeParams = [[AlibcTradeTaokeParams alloc] init];
    taoKeParams.adzoneId = @"138744610"; //your adzoneId
    taoKeParams.extParams = @{@"taokeAppkey":AliTradeSDK_Key};//your taokeAppkey
    //打开方式
    AlibcTradeShowParams* showParam = [[AlibcTradeShowParams alloc] init];
    showParam.openType = AlibcOpenTypeH5;
    //打开方式
    [[AlibcTradeSDK sharedInstance].tradeService show:self.navigationController  page:page showParams:showParam taoKeParams:nil trackParam:nil tradeProcessSuccessCallback:^(AlibcTradeResult * _Nullable result) {
    } tradeProcessFailedCallback:^(NSError * _Nullable error) {
    }];
}

- (void)searchProduct{
    [MobClick event:sousuokuang];
    [self.searchView loadSearchRecord];
    self.searchView.hidden = NO;
    self.showSearch = YES;
    [UIView animateWithDuration:0.3 animations:^{
        self.searchView.alpha = 1;
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
        [TZStatusBarStyle setStatusBarColor:[UIColor whiteColor]];
    }];
}

- (void)dawanjiaCommand{
    //大玩家搜索command
    //q，sort，order，start，limit，keywords
    _pageNo = 0;
    self.modelArray = [NSMutableArray array];
    self.searchViewModel = [TZSearchProductViewModel new];
    @weakify(self)
    [[self.searchViewModel.searchCommand.executionSignals switchToLatest] subscribeNext:^(NSArray *products) {
        @strongify(self)
        [self.jxTableView.mj_header endRefreshing];
        [self.jxTableView.mj_footer endRefreshing];
        if (products) {
            if (_pageNo == 0) {
                [self.modelArray removeAllObjects];
            }
            [self.modelArray addObjectsFromArray:[TZSearchProductModel mj_objectArrayWithKeyValuesArray:products]];
        }
        [self.jxTableView reloadData];
    }];
    [self loadDawanjiaData];
}

- (void)loadDawanjiaData{
    [self.searchViewModel.searchCommand execute:@{@"q":@"7",@"sort":@"all",@"order":@"default",@"start":[NSString stringWithFormat:@"%ld",(long)_pageNo*20],@"limit":@"20"}];
}

- (void)homeCommand{
    self.bannerArray = [NSMutableArray array];
    self.jrbqArray = [NSMutableArray array];
    self.homeViewModel = [TZHomeViewModel new];
    self.bannerViewModel = [TZBannerViewModel new];
    @weakify(self);
    [[self.homeViewModel.bannerCommand.executionSignals switchToLatest] subscribeNext:^(NSArray *dataArray) {
        @strongify(self);
        if (dataArray) {
            [self.bannerArray addObjectsFromArray:[TZHomeBannerModel mj_objectArrayWithKeyValuesArray:dataArray]];
        }
        [self.jxTableView reloadData];
    }];
    [self.homeViewModel.bannerCommand execute:nil];
    
    [[self.homeViewModel.snapUpCommand.executionSignals switchToLatest] subscribeNext:^(NSArray *dataArray) {
        @strongify(self);
        if (dataArray.count != 0) {
            TZShopCategoryModel *model = [TZShopCategoryModel mj_objectWithKeyValues:dataArray[0]];
            [self.homeViewModel.snapGoodsCommand execute:@{@"goodIds":model.goodsId,@"pageNum":@"1",@"pageSize":@"20"}];
        }
    }];
    [self.homeViewModel.snapUpCommand execute:nil];
    
    [[self.homeViewModel.snapGoodsCommand.executionSignals switchToLatest] subscribeNext:^(NSArray *dataArray) {
        @strongify(self);
        if (dataArray.count != 0) {
            [self.jrbqArray addObjectsFromArray:[TZServiceGoodsModel mj_objectArrayWithKeyValuesArray:dataArray]];
            [self.jxTableView reloadData];
        }
    }];
    
    [[self.homeViewModel.popCommand.executionSignals switchToLatest] subscribeNext:^(NSArray *dataArray) {
        @strongify(self);
        if (dataArray.count != 0) {
            TZShopCategoryModel *model = [TZShopCategoryModel mj_objectWithKeyValues:dataArray[0]];
            //[self.homeViewModel.popGoodsCommand execute:@{@"goodIds":model.goodsId,@"pageNum":@"1",@"pageSize":@"20"}];
            //return ;
            NSString *popId = UserDefaultsOFK(@"popId");
            if (popId) {
                if (![popId isEqualToString:model.id]) {
                    [self.homeViewModel.popGoodsCommand execute:@{@"goodIds":model.goodsId,@"pageNum":@"1",@"pageSize":@"20"}];
                    UserDefaultsSFK(model.id, @"popId");
                }else{
                    UserDefaultsSFK(model.id, @"popId");
                }
            }else{
                [self.homeViewModel.popGoodsCommand execute:@{@"goodIds":model.goodsId,@"pageNum":@"1",@"pageSize":@"20"}];
                UserDefaultsSFK(model.id, @"popId");
            }
        }
    }];
    
    [[self.homeViewModel.popGoodsCommand.executionSignals switchToLatest] subscribeNext:^(NSArray *dataArray) {
        if (dataArray.count != 0) {
            self.popArray = [[TZServiceGoodsModel mj_objectArrayWithKeyValuesArray:dataArray] copy];
            [self initRecommandView];
        }
    }];
    
//    [[self.bannerViewModel.bannerCommand.executionSignals switchToLatest] subscribeNext:^(NSArray *dataArray) {
//        @strongify(self);
//        if (dataArray) {
//            [self.jrbqArray addObjectsFromArray:[TZHomeBannerDetailModel mj_objectArrayWithKeyValuesArray:dataArray]];
//            [self.jxTableView reloadData];
//        }
//        [self.homeViewModel.snapUpCommand execute:nil];
//    }];
//    [self.bannerViewModel.bannerCommand execute:@{@"categoryId":@"5",@"pageNum":@"0",@"pageSize":@"20"}];
    
    //版本更新
    [self shareAppVersionAlert];
}

#pragma mark - Action
- (BOOL)judgeLogin{
    if ([UserDefaultsOFK(Login_Status) intValue] == 1) {
        return YES;
    }else{
        return NO;
    }
}

#pragma mark - tableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return 2;
    }else if (section == 2){
        return 1;
    }
    return self.modelArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 2) {
        return 10;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return kScale*209+100;
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            return 55;
        }
        return 200;
    }else if (indexPath.section == 2){
        return 50;
    }else{
        return 140;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *bgView = [MYBaseView viewWithFrame:CGRectZero backgroundColor:[UIColor colorWithHexString:TZ_TableView_Color alpha:1.0]];
    return bgView;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        HomeBannerCell *cell = [[HomeBannerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([HomeBannerCell class])];
        //[cell setBannerInfoWithArray:self.bannerArray];
        [cell setBannerTapBlcok:^(NSInteger index){
            TZJHSViewController *jhsVC = [[TZJHSViewController alloc] init];
            if (index == 0) {
                jhsVC.q = @"8";//9.9包邮
                jhsVC.title = @"9.9包邮";
                [MobClick event:jiukuaijiu];
            }
            if (index == 1) {
                jhsVC.q = @"11";//
                jhsVC.title = @"极有家";
                //[MobClick event:juhuasuan];
            }
            if (index == 2) {
                jhsVC.q = @"6";//
                jhsVC.title = @"品牌馆";
                [MobClick event:pinpaiguan];
            }
            if (index == 3) {
                jhsVC.q = @"12";//
                jhsVC.title = @"全球购";
                [MobClick event:quanqiugou];
            }
            [self.navigationController pushViewController:jhsVC animated:YES];

            /*
            if (self.bannerArray.count != 0) {
                [MobClick event:banner];
                TZHomeBannerModel *bannerModel = self.bannerArray[index];
                TZBannerDetailsViewController *bannerDetailsVC = [[TZBannerDetailsViewController alloc] init];
                bannerDetailsVC.bannerModel = bannerModel;
                [self.navigationController pushViewController:bannerDetailsVC animated:YES];
            }*/
        }];
        [cell setItemTapBlcok:^(NSInteger index){
            if (index == 0) {
                /*TZKefuViewController *kefuVC = [[TZKefuViewController alloc] init];
                [self.navigationController pushViewController:kefuVC animated:YES];*/
                TZBuyGuideViewController *buyGuideVC = [[TZBuyGuideViewController alloc] init];
                [self.navigationController pushViewController:buyGuideVC animated:YES];
                return ;
            }else if (index == 3){
                TZReturnJFExchangeViewController *jfShopVC = [[TZReturnJFExchangeViewController alloc] init];
                [self.navigationController pushViewController:jfShopVC animated:YES];
                return;
//                TZJiFenExchangeViewController *jifenVC = [[TZJiFenExchangeViewController alloc] init];
//                [self.navigationController pushViewController:jifenVC animated:YES];
                return;
            }else {
                if (![self judgeLogin]) {
                    TZLoginViewController *loginVC = [[TZLoginViewController alloc] init];
                    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginVC];
                    [self presentViewController:nav animated:YES completion:nil];
                    return ;
                }
                if (index == 1) {
                    TZQianDaoViewController *qiandaoVC = [[TZQianDaoViewController alloc] init];
                    [self.navigationController pushViewController:qiandaoVC animated:YES];
                }else if (index == 2){
                    TZYaoQingViewController *yaoqingVC = [[TZYaoQingViewController alloc] init];
                    [self.navigationController pushViewController:yaoqingVC animated:YES];
                }
            }
        }];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.section == 1){
        if (indexPath.row == 0){
            HomeBuyTodayCell *cell = [[HomeBuyTodayCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([HomeBuyTodayCell class])];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell setTapBlock:^{
                [MobClick event:baokuanhaohuottq];
                TZTodayBuyViewController *buyVC = [[TZTodayBuyViewController alloc] init];
                [self.navigationController pushViewController:buyVC animated:YES];
            }];
            return cell;
        }else{
            HomeBuyProductCell *cell = [[HomeBuyProductCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([HomeBuyProductCell class])];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell setCellInfoWithArray:self.jrbqArray];
            [cell setTapBlock:^(NSInteger index){
                [MobClick event:jinribiqiangshouye];
                TZProductDetailViewController *detailVC = [[TZProductDetailViewController alloc] init];
                detailVC.detailModel = self.jrbqArray[index];
                [self.navigationController pushViewController:detailVC animated:YES];
            }];
            return cell;
        }
    }else if (indexPath.section == 2){
        HomeCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HomeCategoryCell class])];
        if (cell == nil){
            cell = [[HomeCategoryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([HomeCategoryCell class])];
        }
        [cell setSeperatorInsetToZero:0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        HomeProductCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HomeProductCell class])];
        if (cell == nil) {
            cell = [[HomeProductCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([HomeProductCell class])];
        }
        [cell setSeperatorInsetToZero:0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setSeperatorInsetToZero:0];
        if (indexPath.row < self.modelArray.count) {
            [cell setCellInfoWith:self.modelArray[indexPath.row]];
        }
        return cell;
    }
}

#pragma mark - tableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 3) {
        if (indexPath.row < self.modelArray.count) {
            TZProductDetailViewController *detailVC = [[TZProductDetailViewController alloc] init];
            detailVC.productModel = self.modelArray[indexPath.row];
            [self.navigationController pushViewController:detailVC animated:YES];
        }
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGPoint point = scrollView.contentOffset;
    if (!self.showSearch) {
        if (point.y >= 0) {
            self.topBgView.alpha = point.y/64;
            [TZStatusBarStyle setStatusBarColor:[UIColor colorWithHexString:TZ_Main_Color alpha:point.y/64]];
            self.currentAlpha = point.y/64;
        }else{
            self.topBgView.alpha = 1.0;
            [TZStatusBarStyle setStatusBarColor:[UIColor colorWithHexString:TZ_Main_Color alpha:1]];
            self.currentAlpha = 1.0;
        }
    }else{
        [TZStatusBarStyle setStatusBarColor:[UIColor clearColor]];
    }
}



//判断是否需要提示更新App
- (void)shareAppVersionAlert {
    //App内info.plist文件里面版本号
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    NSString *appVersion = infoDict[@"CFBundleShortVersionString"];//代码版本
    NSString *urlString = [NSString stringWithFormat:@"http://118.31.45.203:9000/api/versionlog/getAppleLookup"];
    [[self.homeViewModel.versionCommand.executionSignals switchToLatest] subscribeNext:^(NSDictionary *dic) {
        if (dic) {
            NSArray *sourceArray = dic[@"results"];
            if (sourceArray.count >= 1) {
                //AppStore内最新App的版本号
                NSDictionary *sourceDict = sourceArray[0];
                NSString *newVersion = sourceDict[@"version"];
                if ([self judgeNewVersion:newVersion withOldVersion:appVersion]){
                    NSString *latestTime = UserDefaultsOFK(@"noticeVersionTime");
                    if (latestTime) {
                        if ([latestTime isEqualToString:[[ZMUtils currentDateStr] substringWithRange:NSMakeRange(0, 10)]]) {
                            [self showVersionUpGradeWithNewVersion:newVersion];
                        }else{
                            [self guideView];
                        }
                    }else{
                        [self showVersionUpGradeWithNewVersion:newVersion];
                    }
                }else{
                    [self guideView];
                }
            }
        }else{
            [self guideView];
        }
    }];
    [self.homeViewModel.versionCommand execute:urlString];
}
//每天进行一次版本判断
- (BOOL)judgeNeedVersionUpdate {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    //获取年-月-日
    NSString *dateString = [formatter stringFromDate:[NSDate date]];
    NSString *currentDate = [[NSUserDefaults standardUserDefaults] objectForKey:@"currentDate"];
    if ([currentDate isEqualToString:dateString]) {
        return NO;
    }
    [[NSUserDefaults standardUserDefaults] setObject:dateString forKey:@"currentDate"];
    return YES;
}
//判断当前app版本和AppStore最新app版本大小
- (BOOL)judgeNewVersion:(NSString *)newVersion withOldVersion:(NSString *)oldVersion {
    NSArray *newArray = [newVersion componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"."]];
    NSArray *oldArray = [oldVersion componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"."]];
    for (NSInteger i = 0; i < newArray.count; i ++) {
        if ([newArray[i] integerValue] > [oldArray[i] integerValue]) {
            return YES;
        } else if ([newArray[i] integerValue] < [oldArray[i] integerValue]) {
            return NO;
        } else {
        }
    }
    return NO;
}

- (void)showVersionUpGradeWithNewVersion:(NSString *)newVersion{
    TZNewVersionView *versionView = [[TZNewVersionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [kWindow addSubview:versionView];
    versionView.versionLabel.text = [NSString stringWithFormat:@"V %@",newVersion];
    WeakSelf(versionView);
    [versionView setTapBlock:^(BOOL upgrade){
        [weakSelf.bgView removeFromSuperview];
        [weakSelf removeFromSuperview];
        if (upgrade) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps://itunes.apple.com/us/app/%E6%83%A0%E4%BA%AB%E6%B7%98/id1301828476?l=zh&ls=1&mt=8"]];
            NSLog(@"更新");
        }else{
            [self guideView];
        }
        NSDateComponents * components2 = [[NSDateComponents alloc] init];
        components2.year = 0;
        components2.day = 3;
        components2.hour = 0;
        NSCalendar *calendar3 = [NSCalendar currentCalendar];
        NSDate *currentDate = [NSDate date];
        NSDate *nextData = [calendar3 dateByAddingComponents:components2 toDate:currentDate options:NSCalendarMatchStrictly];
        NSDateFormatter * formatter1 = [[NSDateFormatter alloc] init];
        formatter1.dateFormat = @"yyyy-MM-dd";
        NSString * nextTime = [formatter1 stringFromDate:nextData];
        UserDefaultsSFK(nextTime, @"noticeVersionTime");
        NSLog(@"%@",nextTime);
    }];
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
