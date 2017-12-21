//
//  TZEarningsReportViewController.m
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/12/4.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "TZEarningsReportViewController.h"
#import "TZEarningsReportHeadCell.h"
#import "TZEarningsReportTypeCell.h"
#import "TZEarningsReportNumCell.h"
#import "TZAgentViewModel.h"
#import "TZAgentEarningReportModel.h"

@interface TZEarningsReportViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UILabel *totalNumLabel;
@property (nonatomic,strong) TZAgentViewModel *viewModel;
@property (nonatomic,strong) TZAgentEarningReportModel *earningReportModel;

@end

@implementation TZEarningsReportViewController

- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64-70) style:UITableViewStylePlain];
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
    [MYSingleton shareInstonce].tabBarView.hidden = YES;
    [TZStatusBarStyle setStatusBarColor:[UIColor whiteColor]];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

- (NSString *)title{
    return @"收益报表";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self tableView];
    [self initBottomView];
    [self bindingCommand];
    // Do any additional setup after loading the view.
}

- (void)initBottomView{
    UIView *bottomView = [MYBaseView viewWithFrame:CGRectMake(0, SCREEN_HEIGHT-70-64, SCREEN_WIDTH, 70) backgroundColor:[UIColor whiteColor]];
    [self.view addSubview:bottomView];
    
    self.totalNumLabel = [MYBaseView labelWithFrame:CGRectZero text:@"¥0.00" textColor:[UIColor colorWithHexString:@"#d23639" alpha:1.0] textAlignment:NSTextAlignmentRight andFont:kFont(19)];
    [self.view addSubview:self.totalNumLabel];
    [self.totalNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-15);
        make.centerY.equalTo(bottomView);
    }];
    self.totalNumLabel.attributedText = [NSString stringWithString:self.totalNumLabel.text Range:NSMakeRange(0, 1) color:nil font:kFont(12)];
    
    UILabel *desLabel = [MYBaseView labelWithFrame:CGRectZero text:@"累计收益：" textColor:[UIColor colorWithHexString:TZ_BLACK alpha:1.0] textAlignment:NSTextAlignmentRight andFont:kFont(14)];
    [self.view addSubview:desLabel];
    [desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.totalNumLabel.mas_left);
        make.centerY.equalTo(self.totalNumLabel);
    }];
    [RACObserve(self, earningReportModel) subscribeNext:^(TZAgentEarningReportModel *model) {
        self.totalNumLabel.text = [NSString stringWithFormat:@"%.2f",model.totalMoney];
    }];
}

- (void)bindingCommand{
    self.viewModel = [TZAgentViewModel new];
    [[self.viewModel.earningReportCommand.executionSignals switchToLatest] subscribeNext:^(NSArray *dataArray) {
        if (dataArray.count != 0) {
            self.earningReportModel = [TZAgentEarningReportModel mj_objectWithKeyValues:dataArray[0]];
            [self.tableView reloadData];
        }
    }];
    [self.viewModel.earningReportCommand execute:@{@"a":[MYSingleton shareInstonce].userInfoModel.agentInfo.id,@"t":[MYSingleton shareInstonce].userInfoModel.agentInfo.accessToken}];
}

#pragma mark - tableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 45;
    }
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [MYBaseView viewWithFrame:CGRectZero backgroundColor:[UIColor colorWithHexString:TZ_TableView_Color alpha:1.0]];
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        TZEarningsReportHeadCell *cell = [[TZEarningsReportHeadCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([TZEarningsReportHeadCell class])];
        [cell setCellInfoWithIndex:indexPath.section model:self.earningReportModel];
        return cell;
    }else if (indexPath.row == 1){
        TZEarningsReportTypeCell *cell = [[TZEarningsReportTypeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([TZEarningsReportTypeCell class])];
        [cell setCellInfoWithIndex:indexPath.section];
        return cell;
    }else{
        TZEarningsReportNumCell *cell = [[TZEarningsReportNumCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([TZEarningsReportNumCell class])];
        cell.contentView.backgroundColor = [UIColor whiteColor];
        [cell setCellInfoWithIndex:indexPath.section model:self.earningReportModel];
        return cell;
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
