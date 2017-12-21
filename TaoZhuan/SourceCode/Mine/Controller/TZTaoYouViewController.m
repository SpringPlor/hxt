//
//  TZTaoYouViewController.m
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/10/14.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "TZTaoYouViewController.h"
#import "TZTaoYouCell.h"
#import "TZMineViewModel.h"
#import "TZYaoQingViewController.h"
#import "TZTaoYouModel.h"
#import "TZTaoYouOrderViewController.h"

@interface TZTaoYouViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) TZMineViewModel *viewModel;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) TZNoDataNoticeView *noticeView;
@property (nonatomic,strong) UIView *bgView;
@property (nonatomic,strong) UIView *applyBgView;


@end

@implementation TZTaoYouViewController

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
    return @"我的淘友";
}

-(void)viewWillAppear:(BOOL)animated{
    [TZStatusBarStyle setStatusBarColor:[UIColor whiteColor]];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavigationItem];
    [self tableView];
    [self bindingCommand];
    // Do any additional setup after loading the view.
}

- (void)initNavigationItem{
    UIButton *rightButton = [MYBaseView buttonWithFrame:CGRectZero buttonType:UIButtonTypeCustom title:@"淘友订单" titleColor:[UIColor colorWithHexString:TZ_LIGHT_BLACK alpha:1.0] font:kFont(12)];
    rightButton.frame = CGRectMake(SCREEN_WIDTH-75, 0, 60, 25);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    rightButton.layer.cornerRadius = 4;
    rightButton.layer.borderColor = [UIColor colorWithHexString:TZ_GRAY alpha:1.0].CGColor;
    rightButton.layer.borderWidth = 0.5;
    rightButton.userInteractionEnabled = YES;
    [[rightButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        if ([MYSingleton shareInstonce].userInfoModel.agentInfo.id) {
            TZTaoYouOrderViewController *orderVC = [[TZTaoYouOrderViewController alloc] init];
            [self.navigationController pushViewController:orderVC animated:YES];
        }else{
            [self initApplyView];
        }
    }];
}

- (void)initNoticeView{
    self.noticeView = [[TZNoDataNoticeView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) image:@"taoyouwsj" imageSize:CGSizeMake(90, 80) title:@"您还没有邀请淘友！" message:nil];
    self.noticeView.inviteButton.hidden = NO;
    [self.view addSubview:self.noticeView];
    WeakSelf(self);
    [self.noticeView setInviteBlock:^{
        TZYaoQingViewController *yqVC = [[TZYaoQingViewController alloc] init];
        [weakSelf.navigationController pushViewController:yqVC animated:YES];
    }];
}

- (void)initApplyView{
    self.bgView = [MYBaseView viewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) backgroundColor:[UIColor blackColor]];
    [kWindow addSubview:self.bgView];
    self.bgView.alpha = 0.3;
    self.bgView.userInteractionEnabled = YES;
    WeakSelf(self);
    [self.bgView addGestureRecognizer:[UITapGestureRecognizer nvm_gestureRecognizerWithActionBlock:^(id sender) {
        [weakSelf.bgView removeFromSuperview];
        [weakSelf.applyBgView removeFromSuperview];
    }]];
    self.applyBgView = [MYBaseView viewWithFrame:CGRectZero backgroundColor:[UIColor whiteColor]];
    [kWindow addSubview:self.applyBgView];
    [self.applyBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(kWindow);
        make.width.mas_equalTo(310);
        make.height.mas_equalTo(300);
    }];
    self.applyBgView.userInteractionEnabled = YES;
    self.applyBgView.layer.cornerRadius = 15;
    
    UIImageView *topImageView = [MYBaseView imageViewWithFrame:CGRectZero andImage:[UIImage imageNamed:@"我的淘友弹框"]];
    [self.applyBgView addSubview:topImageView];
    [topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.applyBgView);
        make.width.mas_equalTo(310);
        make.height.mas_equalTo(150);
    }];
    
    UILabel *messageLabel = [MYBaseView labelWithFrame:CGRectZero text:@"你还没有成为合伙人，无法享有查看淘友订单的权益。立即申请成为合伙人，更多权益等你拿！" textColor:[UIColor colorWithHexString:TZ_BLACK alpha:1.0] textAlignment:NSTextAlignmentLeft andFont:kFont(15)];
    [self.applyBgView addSubview:messageLabel];
    [messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topImageView.mas_bottom).offset(20);
        make.left.equalTo(self.applyBgView).offset(30);
        make.centerX.equalTo(self.applyBgView);
    }];
    messageLabel.numberOfLines = 0;
    
    UIButton *applyButton = [MYBaseView buttonWithFrame:CGRectZero buttonType:UIButtonTypeCustom title:@"立即申请" titleColor:[UIColor whiteColor] font:kFont(12)];
    [self.applyBgView addSubview:applyButton];
    [applyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.applyBgView);
        make.bottom.equalTo(self.applyBgView.mas_bottom).offset(-22);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(30);
    }];
    applyButton.layer.cornerRadius = 15;
    applyButton.backgroundColor  = [UIColor colorWithHexString:@"#f95a47" alpha:1.0];
    applyButton.userInteractionEnabled = YES;
    @weakify(self);
    [[applyButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        [self.bgView removeFromSuperview];
        [self.applyBgView removeFromSuperview];
    }];
}

- (void)bindingCommand{
    self.dataArray = [NSMutableArray array];
    self.viewModel = [TZMineViewModel new];
    [[self.viewModel.tyCommand.executionSignals switchToLatest] subscribeNext:^(NSArray *dataArray) {
        if (dataArray) {
            [self.dataArray addObjectsFromArray:[TZTaoYouModel mj_objectArrayWithKeyValuesArray:dataArray]];
        }
        if (dataArray.count == 0) {
            [self initNoticeView];
        }else{
            [self.noticeView removeFromSuperview];
            [self.tableView reloadData];
        }
    }];
    [self.viewModel.tyCommand execute:@{@"u":[MYSingleton shareInstonce].loginModel.id,@"t":[MYSingleton shareInstonce].loginModel.accessToken}];
}

#pragma mark - tableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 36;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *bgView = [MYBaseView viewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 36) backgroundColor:[UIColor colorWithHexString:@"#f2f2f2" alpha:1.0]];
    NSArray *titleArray = @[@"注册时间",@"淘友名"];
    for (int i = 0;i < 2; i++ ){
        UILabel *titleLabel = [MYBaseView labelWithFrame:CGRectZero text:titleArray[i] textColor:[UIColor colorWithHexString:@"#666666" alpha:1.0] textAlignment:NSTextAlignmentCenter andFont:kFont(15)];
        [bgView addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(bgView).offset(SCREEN_WIDTH/2*i);
            make.top.equalTo(bgView);
            make.width.mas_equalTo(SCREEN_WIDTH/2);
            make.height.mas_equalTo(40);
        }];
    }
    return bgView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TZTaoYouCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TZTaoYouCell class])];
    if (cell == nil) {
        cell = [[TZTaoYouCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([TZTaoYouCell class])];
    }
    [cell setCellInfoWithModel:self.dataArray[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setSeperatorInsetToZero:0];
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
