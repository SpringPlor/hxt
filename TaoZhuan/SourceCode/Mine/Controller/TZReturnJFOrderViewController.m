//
//  TZReturnJFOrderViewController.m
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/10/14.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//



#import "TZReturnJFOrderViewController.h"
#import "TZReturnJFOrderCell.h"
#import "TZReturnJFOrderDetailViewController.h"
#import "TZReturnJFOrderAuditCell.h"
#import "TZReturnOrderViewModel.h"
#import "TZReturnJfOrderModel.h"
#import "TZAgentViewModel.h"
#import "TZTaoYouOrderModel.h"

@interface TZReturnJFOrderViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) NSMutableArray *imageArray;
@property (nonatomic,strong) UIView *redView;
@property (nonatomic,strong) TZReturnOrderViewModel *viewModel;
@property (nonatomic,strong) TZNoDataNoticeView *noticeView;
@property (nonatomic,strong) TZAgentViewModel *agentViewModel;

@end

@implementation TZReturnJFOrderViewController

- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, SCREEN_HEIGHT-40-64) style:UITableViewStylePlain];
        [self.view addSubview:_tableView];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.backgroundColor = rGB_Color(242, 242, 242);
    }
    return _tableView;
}

- (NSString *)title{
    return @"返积分订单";
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
    [self initTopView];
    [self tableView];
    [self initNoticeView];
    [self bindingCommand];
    // Do any additional setup after loading the view.
}

- (void)initNoticeView{
    self.noticeView = [[TZNoDataNoticeView alloc] initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, SCREEN_HEIGHT-64-40) image:@"fanjifenwsj" imageSize:CGSizeMake(93, 80) title:@"还没有订单哦!" message:@"去下单拿积分吧!"];
    [self.view addSubview:self.noticeView];
    self.noticeView.hidden = YES;
}

- (void)initTopView{
    NSArray *itemArray = @[@"审核中",@"即将到账",@"已到账",@"无效订单"];
    CGFloat itemWidth = SCREEN_WIDTH/itemArray.count;
    for (int i = 0; i < itemArray.count; i ++){
        UIButton *itemButton = [MYBaseView buttonWithFrame:CGRectZero buttonType:UIButtonTypeCustom title:itemArray[i] titleColor:[UIColor colorWithHexString:@"#666666" alpha:1.0] font:kFont(14)];
        [self.view addSubview:itemButton];
        [itemButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view);
            make.left.equalTo(self.view).offset(itemWidth*i);
            make.width.mas_equalTo(itemWidth);
            make.height.mas_equalTo(40);
        }];
        [itemButton setTitleColor:[UIColor colorWithHexString:TZ_LIGHT_RED alpha:1.0] forState:UIControlStateSelected];
        itemButton.tag = 100+i;
        if (i == self.currentStatus) {
            itemButton.selected = YES;
            self.redView = [MYBaseView viewWithFrame:CGRectMake(i*(SCREEN_WIDTH/4)+5, 37, itemWidth-10, 3) backgroundColor:[UIColor colorWithHexString:TZ_LIGHT_RED alpha:1.0]];
            [self.view addSubview:self.redView];
        }
        [itemButton addTarget:self action:@selector(switchItem:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)switchItem:(UIButton *)sender{
    if (self.currentStatus == sender.tag - 100) {
        return;
    }
    self.currentStatus = (OrderStatus)(sender.tag - 100);
    for (int i = 0 ; i < 4; i++){
        UIButton *tempBtn = (UIButton *)[self.view viewWithTag:100+i];
        tempBtn.selected = NO;
    }
    sender.selected = YES;
    self.currentStatus = (OrderStatus)sender.tag -100;
    [UIView animateWithDuration:0.3 animations:^{
        self.redView.frame = CGRectMake((sender.tag-100)*(SCREEN_WIDTH/4)+5, 37, (SCREEN_WIDTH/4)-10, 3);
    }];
    [self.dataArray removeAllObjects];
    [self.viewModel.returnOrderCommand execute:@{@"u":[MYSingleton shareInstonce].loginModel.id,@"t":[MYSingleton shareInstonce].loginModel.accessToken,@"status":[NSString stringWithFormat:@"%u",self.currentStatus+1]}];
}

- (void)bindingCommand{
    self.dataArray = [NSMutableArray array];
    self.imageArray = [NSMutableArray array];
    self.viewModel = [TZReturnOrderViewModel new];
    @weakify(self);
    [[self.viewModel.returnOrderCommand.executionSignals switchToLatest] subscribeNext:^(NSArray *dataArray) {
        if (dataArray) {
            @strongify(self);
            [self.dataArray addObjectsFromArray:[TZReturnJfOrderModel mj_objectArrayWithKeyValuesArray:dataArray]];
            if (self.dataArray.count == 0) {
                self.noticeView.hidden = NO;
            }else{
                self.noticeView.hidden = YES;
            }
            if (self.currentStatus == OrderStatusSH) {
            }else{
                if (self.dataArray.count != 0) {
                    NSMutableString *ids = [NSMutableString string];
                    for (int i = 0 ; i < self.dataArray.count; i ++) {
                        TZReturnJfOrderModel *model = self.dataArray[i];
                        if (i < self.dataArray.count-1) {
                            [ids appendString:model.tbOrderId];
                            [ids appendString:@","];
                        }else{
                            [ids appendString:model.tbOrderId];
                        }
                    }
                    [self.agentViewModel.orderImageUrlsCommand execute:@{@"ids":ids}];
                }
            }
            [self.tableView reloadData];
        }
    }];
    [self.viewModel.returnOrderCommand execute:@{@"u":[MYSingleton shareInstonce].loginModel.id,@"t":[MYSingleton shareInstonce].loginModel.accessToken,@"status":[NSString stringWithFormat:@"%u",self.currentStatus+1]}];
    
    self.agentViewModel = [TZAgentViewModel new];
    [[self.agentViewModel.orderImageUrlsCommand.executionSignals switchToLatest] subscribeNext:^(NSArray *imageUrls) {
        if (imageUrls) {
            [self.imageArray removeAllObjects];
            [self.imageArray addObjectsFromArray:[TZOrderImageModel mj_objectArrayWithKeyValuesArray:imageUrls]];
        }
        [self.tableView reloadData];
    }];
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
    if (self.currentStatus == OrderStatusSH) {
        return 80;
    }
    return 165;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *bgView = [MYBaseView viewWithFrame:CGRectZero backgroundColor:rGB_Color(242, 242, 242)];
    return bgView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.currentStatus == OrderStatusSH) {
        TZReturnJFOrderAuditCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TZReturnJFOrderAuditCell class])];
        if (cell == nil) {
            cell = [[TZReturnJFOrderAuditCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([TZReturnJFOrderAuditCell class])];
        }
        [cell setCellInfoWithModel:self.dataArray[indexPath.section]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setSeperatorInsetToZero:SCREEN_WIDTH];
        return cell;
    }else{
        TZReturnJFOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TZReturnJFOrderCell class])];
        if (cell == nil) {
            cell = [[TZReturnJFOrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([TZReturnJFOrderCell class])];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setSeperatorInsetToZero:SCREEN_WIDTH];
        [cell setCellInfoWithModel:self.dataArray[indexPath.section]];
        if (indexPath.row < self.imageArray.count) {
            cell.model = self.imageArray[indexPath.section];
        }
        return cell;
    }
}

#pragma mark - tableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    TZReturnJFOrderDetailViewController *jfOrderDetailVC = [[TZReturnJFOrderDetailViewController alloc] init];
//    [self.navigationController pushViewController:jfOrderDetailVC animated:YES];
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
