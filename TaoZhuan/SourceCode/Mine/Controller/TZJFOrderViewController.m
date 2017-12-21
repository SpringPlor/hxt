//
//  TZJFOrderViewController.m
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/10/14.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "TZJFOrderViewController.h"
#import "TZJFOrderCell.h"
#import "TZJFOrderKefuViewController.h"
#import "TZMineViewModel.h"
#import "TZJFOrderModel.h"
#import "TZAgentViewModel.h"

@interface TZJFOrderViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) TZMineViewModel *viewModel;
@property (nonatomic,assign) NSInteger pageNo;
@property (nonatomic,strong) TZAgentViewModel *agentViewModel;

@end

@implementation TZJFOrderViewController

- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
        [self.view addSubview:_tableView];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.backgroundColor = rGB_Color(240, 240, 240);
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            self.pageNo = 0;
            [self.dataArray removeAllObjects];
            [self.viewModel.intergralOrder execute:@{@"u":[MYSingleton shareInstonce].loginModel.id,@"t":[MYSingleton shareInstonce].userInfoModel.accessToken,@"pageNum":[NSString stringWithFormat:@"%ld",self.pageNo],@"pageSize":@"20"}];
        }];
        _tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
            self.pageNo ++;
            [self.viewModel.intergralOrder execute:@{@"u":[MYSingleton shareInstonce].loginModel.id,@"t":[MYSingleton shareInstonce].userInfoModel.accessToken,@"pageNum":[NSString stringWithFormat:@"%ld",self.pageNo],@"pageSize":@"20"}];
        }];
    }
    return _tableView;
}

- (NSString *)title{
    return @"积分兑换订单";
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


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"kefubangzhu"] style:UIBarButtonItemStylePlain target:self action:@selector(kefu)];
    [self tableView];
    [self bindingCommand];
    // Do any additional setup after loading the view.
}

- (void)bindingCommand{
    self.pageNo = 0;
    self.dataArray = [NSMutableArray array];
    self.viewModel = [TZMineViewModel new];
    [[self.viewModel.intergralOrder.executionSignals switchToLatest] subscribeNext:^(NSArray *dataArray) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        if (dataArray) {
            [self.dataArray addObjectsFromArray:[TZJFOrderModel mj_objectArrayWithKeyValuesArray:dataArray]];
        }
        [self.tableView reloadData];
        
    }];
    [self.viewModel.intergralOrder execute:@{@"u":[MYSingleton shareInstonce].loginModel.id,@"t":[MYSingleton shareInstonce].userInfoModel.accessToken,@"pageNum":[NSString stringWithFormat:@"%ld",self.pageNo],@"pageSize":@"20"}];
    
   
}

#pragma mark - Action
- (void)kefu{
    TZJFOrderKefuViewController *kefuVC = [[TZJFOrderKefuViewController alloc] init];
    [self.navigationController pushViewController:kefuVC animated:YES];
}

#pragma mark - tableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 135;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *bgView = [MYBaseView viewWithFrame:CGRectZero backgroundColor:rGB_Color(240, 240, 240)];
    return bgView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TZJFOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TZJFOrderCell class])];
    if (cell == nil) {
        cell = [[TZJFOrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([TZJFOrderCell class])];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setSeperatorInsetToZero:SCREEN_WIDTH];
    [cell setCellInfoWithModel:self.dataArray[indexPath.section]];
    return cell;
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
