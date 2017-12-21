//
//  TZTaoYouOrderViewController.m
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/12/6.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "TZTaoYouOrderViewController.h"
#import "TZTaoYouOrderCell.h"
#import "TZTaoYouConsumptionCell.h"
#import "TZTaoYouOrderSortView.h"
#import "TZAgentViewModel.h"
#import "TZTaoYouOrderModel.h"
#import "TZTaoYouOrderOtherCell.h"

@interface TZTaoYouOrderViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) NSMutableArray *imageArray;
@property (nonatomic,strong) TZTaoYouOrderSortView *sortView;
@property (nonatomic,strong) TZAgentViewModel *viewModel;
@property (nonatomic,assign) NSInteger status;
@property (nonatomic,assign) NSInteger pageNo;

@end

@implementation TZTaoYouOrderViewController

- (TZTaoYouOrderSortView *)sortView{
    if (_sortView == nil) {
        _sortView = [[TZTaoYouOrderSortView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
        [self.view addSubview:_sortView];
        WeakSelf(self);
        [_sortView setTapBlcok:^(NSInteger index, NSString *sort){
            switch (index) {
                case 0:
                    weakSelf.status = 0;
                    break;
                case 1:
                    weakSelf.status = 1;
                    break;
                case 2:
                    weakSelf.status = 3;
                    break;
                case 3:
                    weakSelf.status = 2;
                    break;
                    
                default:
                    break;
            }
            [weakSelf.tableView.mj_header beginRefreshing];
        }];
    }
    return _sortView;
}

- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, SCREEN_HEIGHT-64-40) style:UITableViewStylePlain];
        [self.view addSubview:_tableView];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.backgroundColor = [UIColor colorWithHexString:TZ_TableView_Color alpha:1.0];
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            _pageNo = 1;
            [self.dataArray removeAllObjects];
            [self.imageArray removeAllObjects];
            [self.viewModel.agentOrderCommand execute:@{@"a":[MYSingleton shareInstonce].userInfoModel.agentInfo.id,@"t":[MYSingleton shareInstonce].userInfoModel.agentInfo.accessToken,@"status":self.status == 0 ? @"":@(self.status),@"pageNum":@(self.pageNo),@"pageSize":@"20"}];
        }];
        _tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
            _pageNo ++;
            [self.viewModel.agentOrderCommand execute:@{@"a":[MYSingleton shareInstonce].userInfoModel.agentInfo.id,@"t":[MYSingleton shareInstonce].userInfoModel.agentInfo.accessToken,@"status":self.status == 0 ? @"":@(self.status),@"pageNum":@(self.pageNo),@"pageSize":@"20"}];
        }];
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
    }
    return _tableView;
}

- (NSString *)title{
    return @"订单明细";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self sortView];
    [self tableView];
    [self bindingCommand];
    // Do any additional setup after loading the view.
}

- (void)bindingCommand{
    self.pageNo = 1;
    self.status = 0;
    self.dataArray = [NSMutableArray array];
    self.imageArray = [NSMutableArray array];
    self.viewModel = [TZAgentViewModel new];
    @weakify(self);
    [[self.viewModel.agentOrderCommand.executionSignals switchToLatest] subscribeNext:^(NSArray *dataArray) {
        @strongify(self);
        if (dataArray) {
            [self.dataArray addObjectsFromArray:[TZTaoYouOrderModel mj_objectArrayWithKeyValuesArray:dataArray]];
        }
        if (self.dataArray.count != 0) {
            NSMutableString *ids = [NSMutableString string];
            for (int i = 0 ; i < self.dataArray.count; i ++) {
                TZTaoYouOrderModel *model = self.dataArray[i];
                if (i < self.dataArray.count-1) {
                    [ids appendString:model.tbOrderId];
                    [ids appendString:@","];
                }else{
                    [ids appendString:model.tbOrderId];
                }
            }
            [self.viewModel.orderImageUrlsCommand execute:@{@"ids":ids}];
        }
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
    [self.viewModel.agentOrderCommand execute:@{@"a":[MYSingleton shareInstonce].userInfoModel.agentInfo.id,@"t":[MYSingleton shareInstonce].userInfoModel.agentInfo.accessToken,@"status":self.status == 0 ? @"":@(self.status),@"pageNum":@(self.pageNo),@"pageSize":@"20"}];
    
    [[self.viewModel.orderImageUrlsCommand.executionSignals switchToLatest] subscribeNext:^(NSArray *imageUrls) {
        if (imageUrls.count) {
            [self.imageArray removeAllObjects];
            [self.imageArray addObjectsFromArray:[TZOrderImageModel mj_objectArrayWithKeyValuesArray:imageUrls]];
        }
        [self.tableView reloadData];
    }];
}

#pragma mark - tableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 140*kScale;
    }else{
        TZTaoYouOrderModel *model = self.dataArray[indexPath.section];
        if (![model.status isEqualToString:@"订单结算"]) {
            return 37*kScale;
        }else{
            return 58*kScale;
        }
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 1) {
        TZTaoYouOrderModel *model = self.dataArray[indexPath.section];
        if (![model.status isEqualToString:@"订单结算"]) {
            model.rowHeight = 37*kScale;
        }else{
            model.rowHeight = 58*kScale;
        }
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [MYBaseView viewWithFrame:CGRectZero backgroundColor:[UIColor colorWithHexString:TZ_TableView_Color alpha:1.0]];
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        TZTaoYouOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TZTaoYouOrderCell class])];
        if (cell == nil) {
            cell = [[TZTaoYouOrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([TZTaoYouOrderCell class])];
        }
        if (indexPath.section < self.dataArray.count) {
            [cell setCellInfoWithModel:self.dataArray[indexPath.section]];
        }
        if (indexPath.section < self.imageArray.count) {
            cell.imgeModel = self.imageArray[indexPath.section];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        TZTaoYouOrderModel *model = self.dataArray[indexPath.section];
        if ([model.status isEqualToString:@"订单结算"]) {
            TZTaoYouConsumptionCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TZTaoYouConsumptionCell class])];
            if (cell == nil) {
                cell = [[TZTaoYouConsumptionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([TZTaoYouConsumptionCell class])];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell setSeperatorInsetToZero];
            [cell setCellInfoWithModel:self.dataArray[indexPath.section]];
            return cell;
        }else{
            TZTaoYouOrderOtherCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TZTaoYouOrderOtherCell class])];
            if (cell == nil) {
                cell = [[TZTaoYouOrderOtherCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([TZTaoYouOrderOtherCell class])];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell setSeperatorInsetToZero];
            [cell setCellInfoWithModel:self.dataArray[indexPath.section]];
            return cell;
        }
    }
}

#pragma mark - tableViewDataSource
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - tableViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat sectionHeaderHeight = 10;
    if (scrollView.contentOffset.y <= sectionHeaderHeight && scrollView.contentOffset.y >=0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    } else if (scrollView.contentOffset.y >= sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
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
