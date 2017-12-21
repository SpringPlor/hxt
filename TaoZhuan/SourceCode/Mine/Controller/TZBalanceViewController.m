//
//  TZBalanceViewController.m
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/10/14.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "TZBalanceViewController.h"
#import "TZReturnJFOrderDetailViewController.h"
#import "TZNoDataNoticeView.h"
#import "TZMineViewModel.h"
#import "TZBalanceModel.h"
#import "TZBalanceCell.h"
#import "TZBalanceHeaderView.h"
#import "TZTixianViewController.h"

@interface TZBalanceViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) TZNoDataNoticeView *noticeView;
@property (nonatomic,strong) UILabel *todayBalanceLabel;
@property (nonatomic,strong) UILabel *monthBalanceLabel;
@property (nonatomic,strong) TZMineViewModel *mineViewModel;

@end

@implementation TZBalanceViewController

- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
        [self.view addSubview:_tableView];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        [_tableView setSeparatorColor:[UIColor colorWithHexString:@"#dfdfdf" alpha:1.0]];
    }
    return _tableView;
}

- (NSString *)title{
    return @"余额明细";
}

-(void)viewWillAppear:(BOOL)animated{
    [TZStatusBarStyle setStatusBarColor:[UIColor whiteColor]];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //[self initNavigationItem];
    [self tableView];
    [self bindingCommand];
    // Do any additional setup after loading the view.
}

- (void)initNavigationItem{
    UIButton *rightButton = [MYBaseView buttonWithFrame:CGRectZero buttonType:UIButtonTypeCustom title:@"订单明细" titleColor:[UIColor colorWithHexString:TZ_GRAY alpha:1.0] font:kFont(15)];
    rightButton.frame = CGRectMake(SCREEN_WIDTH-80, 0, 64, 44);
    [rightButton addTarget:self action:@selector(orderDetail) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
}

- (void)initBottomView{
    UIView *bgView = [MYBaseView viewWithFrame:CGRectZero backgroundColor:[UIColor whiteColor]];
    [self.view addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(40);
    }];
    self.todayBalanceLabel = [MYBaseView labelWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/2-0.3, 40) text:nil textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter andFont:kFont(16)];
    self.todayBalanceLabel.backgroundColor = [UIColor redColor];
    [bgView addSubview:self.todayBalanceLabel];
    
    self.monthBalanceLabel = [MYBaseView labelWithFrame:CGRectMake(SCREEN_WIDTH/2+0.3, 0, SCREEN_WIDTH/2-0.3, 40) text:nil textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter andFont:kFont(16)];
    [bgView addSubview:self.monthBalanceLabel];
    self.monthBalanceLabel.backgroundColor = [UIColor redColor];
    self.todayBalanceLabel.text = [NSString stringWithFormat:@"今日预估%.2f",[MYSingleton shareInstonce].userInfoModel.evaluationToday];
    self.monthBalanceLabel.text = [NSString stringWithFormat:@"当月预估%.2f",[MYSingleton shareInstonce].userInfoModel.evaluationMonth];
}

- (void)initNoticeView{
    self.noticeView = [[TZNoDataNoticeView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) image:@"yuewsj" imageSize:CGSizeMake(93, 80) title:@"您还没有余额明细!" message:nil];
    [self.view addSubview:self.noticeView];
}

- (void)orderDetail{
    TZReturnJFOrderDetailViewController *orderDetail = [[TZReturnJFOrderDetailViewController alloc] init];
    [self.navigationController pushViewController:orderDetail animated:YES];
}

- (void)bindingCommand{
    self.dataArray = [NSMutableArray array];
    self.mineViewModel = [TZMineViewModel new];
    @weakify(self);
    [[self.mineViewModel.balanceCommand.executionSignals switchToLatest] subscribeNext:^(NSArray *dataArray) {
        @strongify(self);
        if (dataArray.count != 0) {
            [self.noticeView removeFromSuperview];
            [self.dataArray addObjectsFromArray:[TZBalanceModel mj_objectArrayWithKeyValuesArray:dataArray]];
            [self.tableView reloadData];
        }else{
            [self initNoticeView];
        }
    }];
    [self.mineViewModel.balanceCommand execute:@{@"u":[MYSingleton shareInstonce].loginModel.id,@"t":[MYSingleton shareInstonce].loginModel.accessToken}];
}

#pragma mark - tableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 75*kScale+40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    @weakify(self);
    TZBalanceHeaderView *headView = [[TZBalanceHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 75*kScale+40)];
    [[headView.txButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        TZTixianViewController *tixVC = [[TZTixianViewController alloc] init];
        [self.navigationController pushViewController:tixVC animated:YES];
    }];
    return headView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TZBalanceCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TZBalanceCell class])];
    if (cell == nil) {
        cell = [[TZBalanceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([TZBalanceCell class])];
    }
    [cell setSeperatorInsetToZero:0];
    [cell setCellInfoWithModel:self.dataArray[indexPath.row]];
    return cell;
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
