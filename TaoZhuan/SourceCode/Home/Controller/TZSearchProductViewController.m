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
#import "TZSearchProductViewController.h"
#import "MYTitleView.h"
#import "TZSearchProductCell.h"
#import "TZSearchProductViewModel.h"
#import "TZSearchProductModel.h"
#import "TZHomeSearchView.h"
#import "TZSearchSortView.h"
#import "TZProductDetailViewController.h"
#import "TZNOSearchProductView.h"
#import "TZSearchModel.h"
#import "TZALiTradeAPITools.h"
#import "TZSearchResultModel.h"
#import "TZDeviceModel.h"
#import "TZBannerViewModel.h"
#import "TZSearchCell.h"
#import "TZProductWebViewController.h"
#import "TZHomeViewModel.h"
#import "TZSearchRecommandCell.h"
#import "TZSearchFilterView.h"
#import "TZShopCategoryModel.h"

@interface TZSearchProductViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property (nonatomic,strong) TZSearchProductViewModel *searchViewModel;
@property (nonatomic,strong) UIButton *dwjButton;//搜索大玩家数据
@property (nonatomic,strong) UIButton *tbButton;//搜索淘宝数据
@property (nonatomic,strong) UILabel *keywordLabel;
@property (nonatomic,strong) UITextField *textfield;
@property (nonatomic,strong) NSMutableArray *modelArray;//储存大玩家搜索数据
@property (nonatomic,strong) NSMutableArray *tbDataArray;//储存淘宝搜索数据
@property (nonatomic,assign) NSInteger pageSize;
@property (nonatomic,assign) NSInteger pageNo;
@property (nonatomic,copy)   NSString *order;//排序方式，搜索淘宝商品时失效
@property (nonatomic,strong) TZHomeSearchView *searchView;
@property (nonatomic,strong) TZNOSearchProductView *noSearchView;//无数据时显示推荐
@property (nonatomic,strong) TZSearchModel *searchModel;//保存淘宝搜索字段信息
@property (nonatomic,assign) DataType dataType;
@property (nonatomic,strong) UIView *titleView;
@property (nonatomic,strong) TZTaoBaoProductModel *tbModel;//保存点击的model
@property (nonatomic,strong) TZHomeViewModel *homeViewModel;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) TZSearchSortView *sortView;//顶部排序方式
@property (nonatomic,assign) BOOL showNotice;//大玩家无更多数据时候显示
@property (nonatomic,strong) UIView *bottomView;
@property (nonatomic,strong) UIButton *rollbackButton;//回顶部按钮
@property (nonatomic,assign) BOOL showRecommandPdt;//是否显示推荐商品
@property (nonatomic,strong) NSMutableArray *recommandArray;//推荐商品
@property (nonatomic,strong) TZSearchFilterView *filterView;//淘宝商品筛选
@property (nonatomic,assign) BOOL filterCoupon;//记录筛选状态
@property (nonatomic,strong) UIView *shareShotView;//截取分享图片

@end

@implementation TZSearchProductViewController

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
            weakSelf.dwjButton.backgroundColor = [UIColor colorWithHexString:@"#e1483f" alpha:1.0];
            weakSelf.tbButton.backgroundColor = [UIColor colorWithHexString:TZ_TableView_Color alpha:1.0];
            [weakSelf.dwjButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [weakSelf.tbButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            weakSelf.dataType = DWJDataType;
            [weakSelf.sortView resetHeader];
            [weakSelf.tableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
            weakSelf.autSearchTB = YES;
            weakSelf.filterCoupon = NO;
            [weakSelf loadDataWithOrder:nil];
        }];
    }
    return _searchView;
}

- (TZSearchSortView *)sortView{
    if (_sortView == nil) {
        self.sortView = [[TZSearchSortView alloc] initWithFrame:CGRectMake(0, 64+40, SCREEN_WIDTH, 45)];
        [self.view addSubview:self.sortView];
        WeakSelf(self);
        [self.sortView setTapBlcok:^(NSInteger index, NSString *order){
            _pageNo = 0;
            _order = order;
            [weakSelf.tableView.mj_header beginRefreshing];
        }];
    }
    return _sortView;
}

- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64+40+45, SCREEN_WIDTH, SCREEN_HEIGHT-64-40-45) style:UITableViewStylePlain];
        [self.view addSubview:_tableView];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.backgroundColor = rGB_Color(240, 240, 240);
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            _pageNo = 0;
            [self loadDataWithOrder:_order];
        }];
        _tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
            _pageNo ++;
            [self loadMoreDataWithOrder:_order];
        }];
    }
    return _tableView;
}

- (void)initSearchView{
    self.titleView = [MYBaseView viewWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, 44) backgroundColor:[UIColor whiteColor]];
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

-(void)viewWillAppear:(BOOL)animated{
    [TZStatusBarStyle setStatusBarColor:[UIColor whiteColor]];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    //[self.titleView removeFromSuperview];
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    [self initSearchView];
    [self tableView];
    [self initTopView];
    [self sortView];
    [self dawanjiaCommand];//大玩家搜索
    [self bindingTBCommand];//淘宝搜索
    [self bindingRecommandCommand];
    [self loadDataWithOrder:nil];
}

- (void)initTopView{
    self.dwjButton = [MYBaseView buttonWithFrame:CGRectMake(0, 64, SCREEN_WIDTH/2-0.5, 40) buttonType:UIButtonTypeCustom title:@"搜券" titleColor:[UIColor whiteColor] font:kFont(15)];
    [self.view addSubview:self.dwjButton];
    self.dwjButton.backgroundColor = [UIColor colorWithHexString:@"#e1483f" alpha:1.0];
    [self.dwjButton addTarget:self action:@selector(searchProduct:) forControlEvents:UIControlEventTouchUpInside];
    
    self.tbButton = [MYBaseView buttonWithFrame:CGRectMake(SCREEN_WIDTH/2+0.5, 64, SCREEN_WIDTH/2-0.5, 40) buttonType:UIButtonTypeCustom title:@"搜全网" titleColor:[UIColor blackColor] font:kFont(15)];
    [self.view addSubview:self.tbButton];
    self.tbButton.backgroundColor = [UIColor colorWithHexString:TZ_TableView_Color alpha:1.0];
    [self.tbButton addTarget:self action:@selector(searchProduct:) forControlEvents:UIControlEventTouchUpInside];
    
    self.rollbackButton = [MYBaseView buttonWithFrame:CGRectZero buttonType:UIButtonTypeCustom image:[UIImage imageNamed:@"一键回顶"] selectImage:nil];
    [self.view addSubview:self.rollbackButton];
    if (@available(iOS 11.0, *)){
        [self.rollbackButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.view).offset(-15);
            make.bottom.equalTo(self.view.mas_bottom).offset(-50+38);
            make.width.height.mas_equalTo(38);
        }];
    }else{
        [self.rollbackButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.view).offset(-15);
            make.bottom.equalTo(self.view.mas_bottom).offset(-50);
            make.width.height.mas_equalTo(38);
        }];
    }
    self.rollbackButton.backgroundColor = [UIColor colorWithHexString:@"#e1483f" alpha:1.0];
    self.rollbackButton.layer.cornerRadius = 20;
    self.rollbackButton.hidden = YES;
    @weakify(self);
    [[self.rollbackButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        self.tableView.contentOffset = CGPointMake(0, 0);
    }];
}

- (void)initNoSearchView{
    self.noSearchView = [[TZNOSearchProductView alloc] initWithFrame:CGRectMake(0, 64+40, SCREEN_WIDTH, SCREEN_HEIGHT-64-40)];
    [self.view addSubview:self.noSearchView];
    WeakSelf(self);
    [self.noSearchView setTapBlock:^(TZServiceGoodsModel *model){
        TZProductDetailViewController *detailVC = [[TZProductDetailViewController alloc] init];
        detailVC.detailModel = model;
        [weakSelf.navigationController pushViewController:detailVC animated:YES];
    }];
}

- (void)initBottonView{
    self.bottomView = [MYBaseView viewWithFrame:CGRectZero backgroundColor:[UIColor colorWithHexString:TZ_TableView_Color alpha:1.0]];
    [self.view addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(90);
    }];
    UIButton *moreButton = [MYBaseView buttonWithFrame:CGRectZero buttonType:UIButtonTypeCustom image:[UIImage imageNamed:@"searchquanwang"] selectImage:nil];
    [self.bottomView addSubview:moreButton];
    [moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.bottomView);
        make.width.mas_equalTo(310);
        make.height.mas_equalTo(75);
    }];
    [moreButton addTarget:self action:@selector(searchTbData) forControlEvents:UIControlEventTouchUpInside];
}

- (void)initFilterView{
    self.filterView = [[TZSearchFilterView alloc] initWithFrame:CGRectMake(0, 64+40+45, SCREEN_WIDTH, 40)];
    [self.view addSubview:self.filterView];
    self.filterView.filterCoupon = NO;
    WeakSelf(self);
    [self.filterView setFilterStatus:^(BOOL filterCoupon){
        weakSelf.filterCoupon = filterCoupon;
        weakSelf.dataType = TBDataType;
        weakSelf.tableView.contentOffset = CGPointMake(0, 0);
        [weakSelf loadDataWithOrder:nil];
    }];
}

- (void)searchTbData{
    self.pageNo = 1;
    [self.sortView BannedClick:YES];
    self.tbButton.backgroundColor = [UIColor colorWithHexString:@"#e1483f" alpha:1.0];
    [self.tbButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.dwjButton.backgroundColor = [UIColor colorWithHexString:TZ_TableView_Color alpha:1.0];
    [self.dwjButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.dataType = TBDataType;
    [self.sortView resetHeader];
    self.tableView.contentOffset = CGPointMake(0, 0);
    [self.filterView removeFromSuperview];
    [self initFilterView];
    [self loadDataWithOrder:nil];
}

//根据输入的搜索关键字搜索
- (void)loadDataWithOrder:(NSString *)order{
    [self.modelArray removeAllObjects];
    [self.tbDataArray removeAllObjects];
    if (order == nil) {
        order = @"default";
    }
    if (self.dataType == DWJDataType) {
        self.pageNo = 0;
        [self.searchViewModel.searchCommand execute:@{@"q":@"2",@"sort":@"all",@"order":order,@"start":[NSString stringWithFormat:@"%ld",self.pageNo*20],@"limit":@"20",@"keywords":self.searchKeyword}];
    }else{
        self.pageNo = 1;
        NSDictionary *params = @{@"q":self.searchKeyword,@"_t":[ZMUtils getCurrentTimestamp],@"yxjh":@"-1",@"perPageSize":@"20",@"toPage":[NSString stringWithFormat:@"%ld",(long)self.pageNo]};
        [self.searchViewModel.AliSearchCommand execute:params];
    }
}

- (void)loadMoreDataWithOrder:(NSString *)order{
    if (order == nil) {
        order = @"default";
    }
    if (self.dataType == DWJDataType) {
        [self.searchViewModel.searchCommand execute:@{@"q":@"2",@"sort":@"all",@"order":order,@"start":[NSString stringWithFormat:@"%ld",self.pageNo*20],@"limit":@"20",@"keywords":self.searchKeyword}];
    }else{
        NSDictionary *params = @{@"q":self.searchKeyword,@"_t":[ZMUtils getCurrentTimestamp],@"yxjh":@"-1",@"perPageSize":@"20",@"toPage":[NSString stringWithFormat:@"%ld",self.pageNo]};
        [self.searchViewModel.AliSearchCommand execute:params];
    }
}

#pragma mark  - Aciton
- (void)searchProduct:(UIButton *)sender{
    if (sender == self.dwjButton) {
        [self.filterView removeFromSuperview];
        self.tableView.frame = CGRectMake(0, 64+40+45, SCREEN_WIDTH, SCREEN_HEIGHT-64-40-45);
        [self.sortView BannedClick:NO];
        self.dwjButton.backgroundColor = [UIColor colorWithHexString:@"#e1483f" alpha:1.0];
        [self.dwjButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.tbButton.backgroundColor = [UIColor colorWithHexString:TZ_TableView_Color alpha:1.0];
        [self.tbButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        if (self.dataType == TBDataType) {
            self.dataType = DWJDataType;
            [self.sortView resetHeader];
            self.rollbackButton.hidden = YES;
            [self.tableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
            [self loadDataWithOrder:nil];
        }
    }else{
        [self.filterView removeFromSuperview];
        [self initFilterView];
        self.filterView.hidden = YES;
        self.tableView.frame = CGRectMake(0, 64+40+45+40, SCREEN_WIDTH, SCREEN_HEIGHT-64-40-45-40);
        [self.sortView BannedClick:YES];
        self.tbButton.backgroundColor = [UIColor colorWithHexString:@"#e1483f" alpha:1.0];
        [self.tbButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.dwjButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.dwjButton.backgroundColor = [UIColor colorWithHexString:TZ_TableView_Color alpha:1.0];
        if (self.dataType == DWJDataType) {
            self.dataType = TBDataType;
            [self.sortView resetHeader];
            self.rollbackButton.hidden = YES;
            [self.tableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
            [self loadDataWithOrder:nil];
        }
    }
}

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
    self.modelArray = [NSMutableArray array];
    self.dataType = DWJDataType;
    self.searchViewModel = [TZSearchProductViewModel new];
    @weakify(self)
    [[self.searchViewModel.searchCommand.executionSignals switchToLatest] subscribeNext:^(NSArray *products) {
        @strongify(self);
        if (self.pageNo != 0) {
            if (products.count < 20) {
                [self.bottomView removeFromSuperview];
                self.tableView.frame = CGRectMake(0, 64+40+45, SCREEN_WIDTH, SCREEN_HEIGHT-64-40-45-90);
                [self initBottonView];
            }else{
                [self.bottomView removeFromSuperview];
                self.tableView.frame = CGRectMake(0, 64+40+45, SCREEN_WIDTH, SCREEN_HEIGHT-64-40-45);
            }
        }
        if (products.count < 20) {
            self.showRecommandPdt = YES;
        }else{
            self.showRecommandPdt = NO;
        }
        [self.modelArray addObjectsFromArray:[TZSearchProductModel mj_objectArrayWithKeyValuesArray:products]];
#warning 需求更改，大玩家搜索无数据时，直接搜索淘宝
        if (self.modelArray.count == 0) {
            if (self.autSearchTB) {
                [self.filterView removeFromSuperview];
                [self initFilterView];
                self.tbButton.backgroundColor = [UIColor colorWithHexString:@"#e1483f" alpha:1.0];
                self.dwjButton.backgroundColor = [UIColor colorWithHexString:TZ_TableView_Color alpha:1.0];
                [self.tbButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [self.dwjButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                [self.sortView BannedClick:YES];
                [self.sortView resetHeader];
                self.rollbackButton.hidden = YES;
                [self.tableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
                self.dataType = TBDataType;
                [self loadDataWithOrder:nil];
                self.autSearchTB = NO;
            }else{
                [self.noSearchView removeFromSuperview];
                [self initNoSearchView];
                [self.homeViewModel.recommendCommand execute:nil];
            }
        }else{
            [self.noSearchView removeFromSuperview];
            if (_pageNo > 0) {//控制回滚图标显示
                if (products.count > 0) {
                    self.rollbackButton.hidden = NO;
                }else{
                    self.rollbackButton.hidden = YES;
                }
            }else{
                self.rollbackButton.hidden = YES;
            }
        }
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
    
    //获取认证码
    [[self.searchViewModel.applyXoridCommand.executionSignals switchToLatest] subscribeNext:^(id x) {
        if (x) {
            NSArray *array = x;
            if (array.count != 0) {
                NSDictionary *dic = array[0];
                NSString *xorid = dic[@"xorid"];
                //转链接
                if (xorid) {
                    [self.searchViewModel.applyUrlCommand execute:@{@"item_id":self.tbModel.auctionId,@"code":@"KB6CSY",@"xor_id":xorid,@"text":self.tbModel.title,@"url":@""}];
                }
            }
        }
    }];
    
    [[self.searchViewModel.applyUrlCommand.executionSignals switchToLatest] subscribeNext:^(id x) {
        NSString *transformId = x[@"item_id"];
        NSString *transformUrl = x[@"coupon_click_url"];
        if (transformUrl) {
            //id<AlibcTradePage> page1 = [AlibcTradePageFactory itemDetailPage:transformId];//商品id
            id<AlibcTradePage> page3 = [AlibcTradePageFactory page:transformUrl];//坑，只用url跳转会打开手淘
            //淘客信息
            AlibcTradeTaokeParams *taoKeParams = [[AlibcTradeTaokeParams alloc] init];
            taoKeParams.adzoneId = @"138744610"; //your adzoneId
            taoKeParams.extParams = @{@"taokeAppkey":AliTradeSDK_Key};//your taokeAppkey
            //打开方式
            AlibcTradeShowParams* showParam = [[AlibcTradeShowParams alloc] init];
            showParam.openType = AlibcOpenTypeH5;
            //打开方式
            TZProductWebViewController *webVC = [[TZProductWebViewController alloc] init];
            NSInteger ret = [[AlibcTradeSDK sharedInstance].tradeService show:self.navigationController webView:webVC.webView page:page3 showParams:showParam taoKeParams:nil trackParam:nil tradeProcessSuccessCallback:^(AlibcTradeResult * _Nullable result) {
                NSArray *orders = result.payResult.paySuccessOrders;
                if (orders.count != 0) {
                    NSString *order = orders[0];
                    if (order) {
                        if ([UserDefaultsOFK(Login_Status) intValue] == 1) {
                            [self.searchViewModel.bingOrderCommand execute:@{@"u":[MYSingleton shareInstonce].loginModel.id,@"t":[MYSingleton shareInstonce].loginModel.accessToken,@"tbOrderId":order,@"imgUrl":[NSString stringWithFormat:@"http:%@",self.tbModel.pictUrl],@"couponAmount":self.tbModel.couponAmount == 0 ? @"" : @(self.tbModel.couponAmount),@"couponSource":@"tb"}];
                        }else{
                            if (UserDefaultsOFK(User_Device_Info)) {
                                TZDeviceModel *model = [TZDeviceModel mj_objectWithKeyValues:UserDefaultsOFK(User_Device_Info)];
                                [self.searchViewModel.bingOrderCommand execute:@{@"u":model.id,@"t":model.accessToken,@"tbOrderId":order,@"imgUrl":[NSString stringWithFormat:@"http:%@",self.tbModel.pictUrl],@"couponAmount":self.tbModel.couponAmount == 0 ? @"" : @(self.tbModel.couponAmount),@"couponSource":@"tb"}];
                            }
                        }
                    }
                }
            } tradeProcessFailedCallback:^(NSError * _Nullable error) {
                NSLog(@"%@",error);
            }];
            if (ret == 1) {
                [self.navigationController pushViewController:webVC animated:YES];
            }
        }
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
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [self.bottomView removeFromSuperview];
        self.tableView.frame = CGRectMake(0, 64+40+45+40, SCREEN_WIDTH, SCREEN_HEIGHT-64-40-45-40);
        NSArray *pdtArray = @[];
        if (x[@"data"][@"pageList"] != nil && ![x[@"data"][@"pageList"] isEqual:[NSNull null]]){
            pdtArray = x[@"data"][@"pageList"];
            if (pdtArray.count < 20) {
                self.showRecommandPdt = YES;
            }else{
                self.showRecommandPdt = NO;
            }
        }
        if (self.filterCoupon) {
            NSPredicate *prrdicate = [NSPredicate predicateWithFormat:@"SELF.couponAmount != 0"];
            [self.tbDataArray addObjectsFromArray:[[[TZTaoBaoProductModel mj_objectArrayWithKeyValuesArray:pdtArray] filteredArrayUsingPredicate:prrdicate] copy]];
        }else{
            [self.tbDataArray addObjectsFromArray:[TZTaoBaoProductModel mj_objectArrayWithKeyValuesArray:x[@"data"][@"pageList"]]];
        }
        if (self.tbDataArray.count == 0) {
            [self.noSearchView removeFromSuperview];
            [self initNoSearchView];
            if (self.recommandArray.count == 0) {
                [self.homeViewModel.recommendCommand execute:nil];
            }else{
                [self.noSearchView.dataArray addObjectsFromArray:[TZServiceGoodsModel mj_objectArrayWithKeyValuesArray:[self.recommandArray copy]]];
                [self.noSearchView.collectionView reloadData];
            }
        }else{
            [self.noSearchView removeFromSuperview];
            self.filterView.hidden = NO;
        }
        [self.tableView reloadData];
        if (_pageNo > 1) {//控制回滚图标显示
            if (x[@"data"][@"pageList"] == nil || [x[@"data"][@"pageList"] isEqual:[NSNull null]]) {
                self.rollbackButton.hidden = YES;
            }else{
                self.rollbackButton.hidden = NO;
            }
        }else{
            self.rollbackButton.hidden = YES;
        }
    }];
    
    [[self.searchViewModel.bingOrderCommand.executionSignals switchToLatest] subscribeNext:^(MYBaseModel *model) {
        if (model) {
            //[SVProgressHUD showSuccessWithStatus:@"回调成功"];
        }
    }];
}

- (void)bindingRecommandCommand{
    @weakify(self);
    self.recommandArray = [NSMutableArray array];
    self.homeViewModel = [TZHomeViewModel new];
    [[self.homeViewModel.recommendCommand.executionSignals switchToLatest] subscribeNext:^(NSArray *array) {
        @strongify(self);
        if (array.count != 0) {
            TZShopCategoryModel *model = [TZShopCategoryModel mj_objectWithKeyValues:array[0]];
            [self.homeViewModel.recommendShopsCommand execute:@{@"goodIds":model.goodsId,@"pageNum":@"1",@"pageSize":@"50"}];
        }
    }];
    [self.homeViewModel.recommendCommand execute:nil];
    
    [[self.homeViewModel.recommendShopsCommand.executionSignals switchToLatest] subscribeNext:^(NSArray *dataArray) {
        @strongify(self);
        if (dataArray) {
            [self.noSearchView.dataArray addObjectsFromArray:[TZServiceGoodsModel mj_objectArrayWithKeyValuesArray:dataArray]];
            [self.noSearchView.collectionView reloadData];
            [self.recommandArray addObjectsFromArray:[TZServiceGoodsModel mj_objectArrayWithKeyValuesArray:dataArray]];
            [self.tableView reloadData];
        }
    }];
}

#pragma mark - tableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.showRecommandPdt) {
        return 2;
    }else{
        return 1;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        if (self.dataType == TBDataType) {
            return self.tbDataArray.count;
        }else{
            return self.modelArray.count;
        }
    }else{
        return self.recommandArray.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 140;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }else{
        return 47;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    TZNOSearchHeaderView *view = [[TZNOSearchHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 47)];
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TZSearchCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TZSearchCell class])];
    if (cell == nil) {
        cell = [[TZSearchCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([TZSearchCell class])];
    }
    if (indexPath.section == 0) {
        if (self.dataType == TBDataType) {
            if (self.tbDataArray.count != 0) {
                if (indexPath.row < self.tbDataArray.count) {
                    [cell setCellInfoWithTBModel:self.tbDataArray[indexPath.row]];
                }
            }
        }else{
            if (self.modelArray.count != 0) {
                if (indexPath.row < self.modelArray.count) {
                    [cell setCellInfoWithDWJModel:self.modelArray[indexPath.row]];
                }
            }
        }
    }else{
        if (indexPath.row < self.recommandArray.count) {
            [cell setCellInfoWithServiceModel:self.recommandArray[indexPath.row]];
        }
    }
    [cell setSeperatorInsetToZero:0];
    return cell;
}

#pragma mark - tableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        if (self.dataType == TBDataType) {
            if (indexPath.row < self.tbDataArray.count){
                TZProductDetailViewController *detailVC = [[TZProductDetailViewController alloc] init];
                detailVC.resultModel = self.tbDataArray[indexPath.row];
                [self.navigationController pushViewController:detailVC animated:YES];
            }
        }else{
            if (indexPath.row < self.modelArray.count) {
                TZProductDetailViewController *detailVC = [[TZProductDetailViewController alloc] init];
                detailVC.productModel = self.modelArray[indexPath.row];
                [self.navigationController pushViewController:detailVC animated:YES];
            }
        }
    }else{
        if (indexPath.row < self.recommandArray.count) {
            TZProductDetailViewController *detailVC = [[TZProductDetailViewController alloc] init];
            detailVC.detailModel = self.recommandArray[indexPath.row];
            [self.navigationController pushViewController:detailVC animated:YES];
        }
    }
}


//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    CGFloat sectionHeaderHeight = 47;
//    if (scrollView.contentOffset.y <= sectionHeaderHeight && scrollView.contentOffset.y >=0) {
//        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
//    } else if (scrollView.contentOffset.y >= sectionHeaderHeight) {
//        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
//    }
//}


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
