//
//  MYPartnerViewController.m
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/12/4.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "TZPartnerViewController.h"
#import "MYTitleView.h"
#import "TZPartnerCell.h"
#import "TZAgentViewModel.h"
#import "TZPartnerModel.h"

@interface TZPartnerViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UIButton *levelOneButton;
@property (nonatomic,strong) UIButton *levelSecButton;
@property (nonatomic,strong) UIView *bgView;
@property (nonatomic,strong) UIImageView *sortBgView;
@property (nonatomic,strong) UIButton *timeSortButton;
@property (nonatomic,strong) UIButton *contributionSortButton;
@property (nonatomic,strong) UIImageView *selectedImageView;
@property (nonatomic,strong) TZAgentViewModel *viewModel;
@property (nonatomic,copy) NSString *agentLevel;
@property (nonatomic,strong) NSMutableArray *dataArray;

@end

@implementation TZPartnerViewController

- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 50, SCREEN_WIDTH, SCREEN_HEIGHT-64-50) style:UITableViewStylePlain];
        [self.view addSubview:_tableView];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = [UIColor colorWithHexString:TZ_TableView_Color alpha:1.0];
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.separatorColor = [UIColor colorWithHexString:@"#dfdfdf" alpha:1.0];
    }
    return _tableView;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [TZStatusBarStyle setStatusBarColor:[UIColor whiteColor]];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

- (NSString *)title{
    return @"我的团队";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //[self initNavView];
    //[self initSortView];
    [self initTopView];
    [self tableView];
    [self bindingCommand];
    // Do any additional setup after loading the view.
}

- (void)bindingCommand{
    self.agentLevel = @"1";
    self.dataArray = [NSMutableArray array];
    self.viewModel = [TZAgentViewModel new];
    [[self.viewModel.agentEarningCommand.executionSignals switchToLatest] subscribeNext:^(NSArray *dataArray) {
        if (dataArray) {
            [self.dataArray addObjectsFromArray:[TZPartnerModel mj_objectArrayWithKeyValuesArray:dataArray]];
        }
        [self.tableView reloadData];
    }];
    [RACObserve(self, agentLevel) subscribeNext:^(NSString *agentLevel) {
        [self.dataArray removeAllObjects];
        [self.viewModel.agentEarningCommand execute:@{@"a":[MYSingleton shareInstonce].userInfoModel.agentInfo.id,@"t":[MYSingleton shareInstonce].userInfoModel.agentInfo.accessToken,@"agentLevel":self.agentLevel}];
    }];
}

- (void)initNavView{
    UIButton *sortButton = [MYBaseView buttonWithFrame:CGRectMake(SCREEN_WIDTH-59, 0, 44, 44) image:[UIImage imageNamed:@"下拉"] title:@"排序" titleColor:[UIColor colorWithHexString:TZ_BLACK alpha:1.0] font:kFont(12)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:sortButton];
    sortButton.userInteractionEnabled = YES;
    [sortButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -11, 0, 11)];
    [sortButton setImageEdgeInsets:UIEdgeInsetsMake(0, 26, 0, -26)];
    @weakify(self);
    [[sortButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        self.bgView.hidden = NO;
        self.sortBgView.hidden= NO;
    }];
}

- (void)initSortView{
    self.bgView = [MYBaseView viewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) backgroundColor:[UIColor clearColor]];
    [kWindow addSubview:self.bgView];
    self.bgView.userInteractionEnabled = YES;
    WeakSelf(self);
    [self.bgView addGestureRecognizer:[UITapGestureRecognizer nvm_gestureRecognizerWithActionBlock:^(id sender) {
        weakSelf.bgView.hidden = YES;
        weakSelf.sortBgView.hidden= YES;
    }]];
    self.sortBgView = [MYBaseView imageViewWithFrame:CGRectMake(SCREEN_WIDTH-153-5, 56, 153, 88) andImage:[UIImage imageNamed:@"排序底"]];
    [kWindow addSubview:self.sortBgView];
    self.sortBgView.userInteractionEnabled = YES;
    
    self.bgView.hidden = YES;
    self.sortBgView.hidden= YES;
    
    self.contributionSortButton = [MYBaseView buttonWithFrame:CGRectZero buttonType:UIButtonTypeCustom title:@"按贡献佣金排序" titleColor:[UIColor colorWithHexString:TZ_LIGHT_BLACK alpha:1] font:kFont(12)];
    [self.sortBgView addSubview:self.contributionSortButton];
    [self.contributionSortButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.sortBgView).offset(12);
        make.bottom.equalTo(self.sortBgView.mas_bottom);
        make.height.mas_equalTo(43);
    }];
    @weakify(self);
    [[self.contributionSortButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        [self.contributionSortButton setTitleColor:[UIColor colorWithHexString:TZ_LIGHT_RED alpha:1.0] forState:UIControlStateNormal];
        [self.timeSortButton setTitleColor:[UIColor colorWithHexString:TZ_LIGHT_BLACK alpha:1.0] forState:UIControlStateNormal];
        self.bgView.hidden = YES;
        self.sortBgView.hidden= YES;
        self.selectedImageView.hidden = NO;
        self.selectedImageView.frame = CGRectMake(153-10-14, 23.5-5+43, 14, 10);
    }];
    
    self.timeSortButton = [MYBaseView buttonWithFrame:CGRectZero buttonType:UIButtonTypeCustom title:@"按入驻时间排序" titleColor:[UIColor colorWithHexString:TZ_LIGHT_BLACK alpha:1] font:kFont(12)];
    [self.sortBgView addSubview:self.timeSortButton];
    [self.timeSortButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.sortBgView).offset(12);
        make.bottom.equalTo(self.contributionSortButton.mas_top).offset(-0.5);
        make.height.mas_equalTo(43);
    }];
    [[self.timeSortButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        [self.timeSortButton setTitleColor:[UIColor colorWithHexString:TZ_LIGHT_RED alpha:1.0] forState:UIControlStateNormal];
        [self.contributionSortButton setTitleColor:[UIColor colorWithHexString:TZ_LIGHT_BLACK alpha:1.0] forState:UIControlStateNormal];
        self.bgView.hidden = YES;
        self.sortBgView.hidden= YES;
        self.selectedImageView.hidden = NO;
        self.selectedImageView.frame = CGRectMake(153-10-14, 23.5-5, 14, 10);
    }];
    
    self.selectedImageView = [MYBaseView imageViewWithFrame:CGRectMake(153-10-14, 88-21.5+5, 14, 10) andImage:[UIImage imageNamed:@"对勾"]];
    [self.sortBgView addSubview:self.selectedImageView];
    [self.selectedImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.sortBgView).offset(-10);
        make.centerY.equalTo(self.contributionSortButton);
        make.width.mas_equalTo(14);
        make.height.mas_equalTo(10);
    }];
   self.selectedImageView.hidden = YES;
    
    UIView *lineView = [MYBaseView viewWithFrame:CGRectZero backgroundColor:[UIColor colorWithHexString:@"#dfdfdf" alpha:1.0]];
    [self.sortBgView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contributionSortButton.mas_top);
        make.left.equalTo(self.sortBgView).offset(1);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(0.5);
    }];
}

- (void)initTopView{
    @weakify(self);
    self.levelOneButton = [MYBaseView buttonWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/2, 50) buttonType:UIButtonTypeCustom title:@"一级合伙人" titleColor:[UIColor whiteColor] font:kFont(15)];
    [self.view addSubview:self.levelOneButton];
    self.levelOneButton.backgroundColor = [UIColor colorWithHexString:@"#d3af71" alpha:1.0];
    [[self.levelOneButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        self.levelOneButton.backgroundColor = [UIColor colorWithHexString:@"#d3af71" alpha:1.0];
        self.levelSecButton.backgroundColor = [UIColor whiteColor];
        [self.levelOneButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.levelSecButton setTitleColor:[UIColor colorWithHexString:TZ_BLACK alpha:1.0] forState:UIControlStateNormal];
        self.agentLevel = @"1";
        [self.dataArray removeAllObjects];
    }];
    
    self.levelSecButton = [MYBaseView buttonWithFrame:CGRectMake(SCREEN_WIDTH/2, 0, SCREEN_WIDTH/2, 50) buttonType:UIButtonTypeCustom title:@"二级合伙人" titleColor:[UIColor colorWithHexString:TZ_BLACK alpha:1.0] font:kFont(15)];
    [self.view addSubview:self.levelSecButton];
    [[self.levelSecButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        self.levelOneButton.backgroundColor = [UIColor whiteColor];
        self.levelSecButton.backgroundColor = [UIColor colorWithHexString:@"#d3af71" alpha:1.0];
        [self.levelOneButton setTitleColor:[UIColor colorWithHexString:TZ_BLACK alpha:1.0] forState:UIControlStateNormal];
        [self.levelSecButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.agentLevel = @"2";
        [self.dataArray removeAllObjects];
    }];
}

#pragma mark - tableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 2;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 30;
        }
    }
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [MYBaseView viewWithFrame:CGRectZero backgroundColor:[UIColor colorWithHexString:TZ_TableView_Color alpha:1.0]];
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && indexPath.row == 0) {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"partnerHeader"];
        [self initCellTitleWithContentView:cell.contentView];
        [cell setSeperatorInsetToZero];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        TZPartnerCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TZPartnerCell class])];
        if (cell == nil) {
            cell = [[TZPartnerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([TZPartnerCell class])];
        }
        [cell setSeperatorInsetToZero];
        if (indexPath.section < self.dataArray.count) {
            [cell setCellInfoWithModel:self.dataArray[indexPath.section]];
        }
        return cell;
    }
}

- (void)initCellTitleWithContentView:(UIView *)contentView{
    NSArray *titleArray = @[@"合伙人账号",@"贡献佣金"];
    for (int i = 0; i < 2; i ++){
        UILabel *titleLabel = [MYBaseView labelWithFrame:CGRectMake(i*SCREEN_WIDTH/2, 0, SCREEN_WIDTH/2, 30) text:titleArray[i] textColor:[UIColor colorWithHexString:TZ_BLACK alpha:1.0] textAlignment:NSTextAlignmentCenter andFont:kFont(14)];
        [contentView addSubview:titleLabel];
    }
}

#pragma mark - tableViewDelegate

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
