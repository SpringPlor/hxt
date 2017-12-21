//
//  TZQianDaoViewController.m
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/10/10.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "TZQianDaoViewController.h"
#import "TZQianDaoTitleCell.h"
#import "TZQianDaoRulesCell.h"
#import "TZMineViewModel.h"
#import "TZJiFenExchangeViewController.h"

@interface TZQianDaoViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) TZMineViewModel *viewModel;

@end

@implementation TZQianDaoViewController

- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
        [self.view addSubview:_tableView];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.backgroundColor = [UIColor whiteColor];
    }
    return _tableView;
}

-(void)viewWillAppear:(BOOL)animated{
    [TZStatusBarStyle setStatusBarColor:[UIColor whiteColor]];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:kFont(17)}];
    [MobClick event:qiandao];
}

- (NSString *)title{
    return @"签到领钱";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self bindingCommand];
    [self tableView];
    // Do any additional setup after loading the view.
}

- (void)bindingCommand{
    self.viewModel = [TZMineViewModel new];
    [[self.viewModel.signinCommand.executionSignals switchToLatest] subscribeNext:^(NSDictionary *value) {
        if (value) {
            if ([MYSingleton shareInstonce].userInfoModel.agentInfo.id) {
                [self.viewModel.userInfoCommand execute:@{@"a":[MYSingleton shareInstonce].userInfoModel.agentInfo.id,@"t":[MYSingleton shareInstonce].userInfoModel.agentInfo.accessToken}];
            }else{
                [self.viewModel.userInfoCommand execute:@{@"u":[MYSingleton shareInstonce].loginModel.id,@"t":[MYSingleton shareInstonce].loginModel.accessToken}];
            }
        }
    }];
    
    [[self.viewModel.userInfoCommand.executionSignals switchToLatest] subscribeNext:^(MYBaseModel *model) {
        if (model.data) {
            [MYSingleton shareInstonce].userInfoModel = [TZUserInfoModel mj_objectWithKeyValues:model.data];
            UserDefaultsSFK([[MYSingleton shareInstonce].userInfoModel mj_keyValues], User_Info);
        }
        [self.tableView reloadData];
    }];
}

#pragma mark - tableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return 10;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return (210+105)*kScale;
    }return 281*kScale;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        TZQianDaoTitleCell *cell = [[TZQianDaoTitleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([TZQianDaoTitleCell class])];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setCellInfoWithUserInfoModel];
        [cell setSignInBlock:^{
            [self.viewModel.signinCommand execute:@{@"u":[MYSingleton shareInstonce].loginModel.id,@"t":[MYSingleton shareInstonce].loginModel.accessToken}];
        }];
        [cell setJfBlock:^{
            TZJiFenExchangeViewController *exchangeVC = [[TZJiFenExchangeViewController alloc] init];
            [self.navigationController pushViewController:exchangeVC animated:YES];
        }];
        return cell;
    }else{
        TZQianDaoRulesCell *cell = [[TZQianDaoRulesCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([TZQianDaoRulesCell class])];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

#pragma mark - tableViewDelagate

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
