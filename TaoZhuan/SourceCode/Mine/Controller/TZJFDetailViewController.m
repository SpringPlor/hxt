//
//  TZJFDetailViewController.m
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/10/14.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "TZJFDetailViewController.h"
#import "TZJFDetailCell.h"
#import "TZMineViewModel.h"
#import "TZJFDetailModel.h"

@interface TZJFDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) TZMineViewModel *viewModel;
@property (nonatomic,strong) TZNoDataNoticeView *noticeView;

@end

@implementation TZJFDetailViewController

- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
        [self.view addSubview:_tableView];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableFooterView = [[UIView alloc] init];
    }
    return _tableView;
}

- (NSString *)title{
    return @"积分明细";
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
    [self bindingCommand];
    [self tableView];
    // Do any additional setup after loading the view.
}

- (void)initNoticeView{
    self.noticeView = [[TZNoDataNoticeView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) image:@"jifenwsj" imageSize:CGSizeMake(93, 80) title:@"您还没有积分使用记录哦!" message:nil];
    [self.view addSubview:self.noticeView];
}

- (void)bindingCommand{
    self.dataArray = [NSMutableArray array];
    self.viewModel = [TZMineViewModel new];
    @weakify(self);
    [[self.viewModel.integralDetailCommand.executionSignals switchToLatest] subscribeNext:^(NSArray *dataArray) {
        @strongify(self);
        if (dataArray) {
            [self.dataArray addObjectsFromArray:[TZJFDetailModel mj_objectArrayWithKeyValuesArray:dataArray]];
            if (self.dataArray.count == 0) {
                [self initNoticeView];
            }else{
                [self.noticeView removeFromSuperview];
            }
            [self.tableView reloadData];
        }
    }];
    [self.viewModel.integralDetailCommand execute:@{@"u":[MYSingleton shareInstonce].loginModel.id,@"t":[MYSingleton shareInstonce].loginModel.accessToken}];
}

#pragma mark - tableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TZJFDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TZJFDetailCell class])];
    if (cell == nil) {
        cell = [[TZJFDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([TZJFDetailCell class])];
    }
    [cell setCellInfoWithModel:self.dataArray[indexPath.row]];
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
