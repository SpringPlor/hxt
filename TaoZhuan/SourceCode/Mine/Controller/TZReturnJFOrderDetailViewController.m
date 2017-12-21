//
//  TZReturnJFOrderDetailViewController.m
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/10/14.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "TZReturnJFOrderDetailViewController.h"
#import "TZReturnJFOrderDetailCell.h"
#import "TZMineViewModel.h"
#import "TZBalanceOrderModel.h"

@interface TZReturnJFOrderDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) TZNoDataNoticeView *noticeView;
@property (nonatomic,strong) TZMineViewModel *viewModel;

@end

@implementation TZReturnJFOrderDetailViewController

- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
        [self.view addSubview:_tableView];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.backgroundColor = rGB_Color(240, 240, 240);
    }
    return _tableView;
}

- (NSString *)title{
    return @"订单明细";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self tableView];
    [self bindingCommand];
    // Do any additional setup after loading the view.
}

- (void)initNoticeView{
    self.noticeView = [[TZNoDataNoticeView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) image:@"dingdanwsj" imageSize:CGSizeMake(90, 80) title:@"您还没有订单明细!" message:nil];
    [self.view addSubview:self.noticeView];
}

- (void)bindingCommand{
    self.dataArray = [NSMutableArray array];
    self.viewModel = [TZMineViewModel new];
    [[self.viewModel.balanceOrderCommand.executionSignals switchToLatest] subscribeNext:^(NSArray *dataArray) {
        if (dataArray) {
            [self.dataArray addObjectsFromArray:[TZBalanceOrderModel mj_objectArrayWithKeyValuesArray:dataArray]];
            if (self.dataArray.count != 0) {
                [self.noticeView removeFromSuperview];
                [self.tableView reloadData];
            }else{
                [self initNoticeView];
            }
        }
    }];
    [self.viewModel.balanceOrderCommand execute:@{@"u":[MYSingleton shareInstonce].loginModel.id,@"t":[MYSingleton shareInstonce].loginModel.accessToken}];
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
    return 132;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *bgView = [MYBaseView viewWithFrame:CGRectZero backgroundColor:rGB_Color(240, 240, 240)];
    return bgView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TZReturnJFOrderDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TZReturnJFOrderDetailCell class])];
    if (cell == nil) {
        cell = [[TZReturnJFOrderDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([TZReturnJFOrderDetailCell class])];
    }
    [cell setSeperatorInsetToZero:SCREEN_WIDTH];
    [cell setCellInfoWithModel:self.dataArray[indexPath.section]];
    return cell;
}


#pragma mark - tableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
