//
//  TZMineViewController.m
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/9/28.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//
#import <AlibcTradeBiz/AlibcTradeBiz.h>
#import <AlibcTradeSDK/AlibcTradeSDK.h>
#import <AlibabaAuthSDK/albbsdk.h>

#import "TZMineViewController.h"
#import "TZMineModuleView.h"
#import "TZJiFenExchangeViewController.h"
#import "TZMineOtherView.h"
#import "TZKefuViewController.h"
#import "TZReturnJFOrderViewController.h"
#import "TZJFDetailViewController.h"
#import "TZJFOrderViewController.h"
#import "TZTaoYouViewController.h"
#import "TZTixianViewController.h"
#import "TZSettingViewController.h"
#import "TZOrderCollectionView.h"
#import "TZBalanceViewController.h"
#import "TZQianDaoViewController.h"
#import "TZLoginViewController.h"
#import "TZMineViewModel.h"
#import "TZMinePartnerView.h"
#import "TZYaoQingViewController.h"
#import "TZMessageReturnViewController.h"
#import "TZEarningsReportViewController.h"
#import "TZPartnerViewController.h"
#import "TZApplyAgentViewController.h"
#import "TZReturnJFExchangeViewController.h"
#import "TZMineHeadCell.h"
#import "TZMineAgentCell.h"
#import "TZMineIntegralCell.h"
#import "TZMineOrderCell.h"
#import "TZMineOtherCell.h"
#import "TZMineApplyCell.h"

@interface TZMineViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) TZMinePartnerView *partnerModule;//合伙人
@property (nonatomic,strong) UIImageView *blackBgView;
@property (nonatomic,strong) UIView *garyBgView;
@property (nonatomic,strong) TZMineModuleView *orderModule;//订单
@property (nonatomic,strong) TZMineModuleView *integralModule;//积分
@property (nonatomic,strong) TZMineModuleView *balanceModule;//余额
@property (nonatomic,strong) TZMineOtherView *otherModule;//余额
@property (nonatomic,strong) UIButton *iconBgButton;//头像背景
@property (nonatomic,strong) UIImageView *headImageView;//头像背景
@property (nonatomic,strong) UILabel *phoneLabel;
@property (nonatomic,strong) UIButton *qdButton;//签到背景
@property (nonatomic,strong) UILabel *integralLabel;//积分
@property (nonatomic,strong) UILabel *balanceLabel;//余额
@property (nonatomic,strong) UILabel *sqNumLabel;//省钱值
@property (nonatomic,strong) TZOrderCollectionView *orderCollectionView;
@property (nonatomic,strong) TZMineViewModel *viewModel;
@property (nonatomic,strong) TZUserInfoModel *userInfoModel;
@property (nonatomic,strong) UIImageView *applyImageView;
@property (nonatomic,strong) UITableView *tableView;

@end

@implementation TZMineViewController

- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-49) style:UITableViewStylePlain];
        [self.view addSubview:self.tableView];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.tableFooterView = [[UIView alloc] init];
        self.tableView.backgroundColor = [UIColor colorWithHexString:TZ_TableView_Color alpha:1.0];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableView.estimatedRowHeight = 0;
        self.tableView.estimatedSectionHeaderHeight = 0;
        self.tableView.estimatedSectionFooterHeight = 0;
    }
    return _tableView;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [TZStatusBarStyle setStatusBarColor:[UIColor clearColor]];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    self.navigationController.navigationBarHidden = YES;
    [MYSingleton shareInstonce].tabBarView.hidden = NO;
    [self.tableView reloadData];
    [self bindingCommand];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
    [MYSingleton shareInstonce].tabBarView.hidden = YES;
    [IQKeyboardManager sharedManager].enableAutoToolbar = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self tableView];
    // Do any additional setup after loading the view.
}

#pragma mark - tableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }else if (section == 1){
        if ([UserDefaultsOFK(Login_Status) intValue] == 1 && [MYSingleton shareInstonce].userInfoModel.agentInfo.id) {//判断登录
            return 15;
        }else{
            return 0;
        }
    }
    return 15;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 187*kScale+115*kScale-5+15;
    }else if (indexPath.section == 1){
        if ([UserDefaultsOFK(Login_Status) intValue] == 1) {//判断登录
            if ([MYSingleton shareInstonce].userInfoModel.agentInfo.id){//判断代理
                return 138;
            }else{
                return 0;
            }
        }else{
            return 0;
        }
    }else if(indexPath.section == 2){
        return 138;
    }else if(indexPath.section == 3){
        return 138;
    }else if (indexPath.section == 4){
        return 152+110;
    }else{
        if ([UserDefaultsOFK(Login_Status) intValue] == 1 && [MYSingleton shareInstonce].userInfoModel.agentInfo.id) {//判断代理
            return 0;
        }else{
            return 115*kScale+15;
        }
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [MYBaseView viewWithFrame:CGRectZero backgroundColor:[UIColor colorWithHexString:TZ_TableView_Color alpha:1.0]];
    return view;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        TZMineAgentCell *agentCell = (TZMineAgentCell *)cell;
        if ([UserDefaultsOFK(Login_Status) intValue] == 1) {//判断登录
            if (![MYSingleton shareInstonce].userInfoModel.agentInfo.id){//判断代理
                [agentCell.partnerModule removeFromSuperview];
            }else{
                //agentCell.partnerModule.hidden = NO;
            }
        }else{
            [agentCell.partnerModule removeFromSuperview];
        }
    }
    if (indexPath.section == 5) {
        TZMineApplyCell *applyCell = (TZMineApplyCell *)cell;
        if ([UserDefaultsOFK(Login_Status) intValue] == 1) {
            if ([MYSingleton shareInstonce].userInfoModel.agentInfo.id){//判断代理
                applyCell.applyImageView.hidden = YES;
            }else{
                applyCell.applyImageView.hidden = NO;
            }
        }else{
            applyCell.applyImageView.hidden = NO;
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        /*TZMineHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TZMineHeadCell class])];
        if (cell == nil) {
            cell = [[TZMineHeadCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([TZMineHeadCell class])];
        }
        */
        TZMineHeadCell *cell = [[TZMineHeadCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([TZMineHeadCell class])];
        [[cell.iconBgButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            if(![self judgeLogin]){
                [self loginActionWithTarget:self];
            }
        }];
        [cell setHeadBlock:^{
            if(![self judgeLogin]){
                [self loginActionWithTarget:self];
            }
        }];
        [cell setQiandaoBlcok:^{
            [self qdAciton];
        }];
        [cell setInviteFriendBlock:^{
            [self inviteFriend];
        }];
        [cell setItemBlock:^(NSInteger index) {
            [self headAction:index];
        }];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
    }else if(indexPath.section == 1){
        /*TZMineAgentCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TZMineAgentCell class])];
        
        if (cell == nil) {
            cell = [[TZMineAgentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([TZMineAgentCell class])];
        }
        */
        TZMineAgentCell *cell = [[TZMineAgentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([TZMineAgentCell class])];
        [cell setTapBlock:^(NSInteger index) {
            [self agentAction:index];
        }];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
    }else if (indexPath.section == 2){
        TZMineIntegralCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TZMineIntegralCell class])];
        if (cell == nil) {
            cell =  [[TZMineIntegralCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([TZMineIntegralCell class])];
        }
        [cell setTapBlock:^(NSInteger index) {
            [self intergelAction:index];
        }];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
    }else if (indexPath.section == 3){
        TZMineOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TZMineOrderCell class])];
        if (cell == nil) {
            cell =  [[TZMineOrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([TZMineOrderCell class])];
        }
        [cell setTapBlock:^(NSInteger index) {
            [self orderAction:index];
        }];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
    }else if (indexPath.section == 4){
        TZMineOtherCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TZMineOtherCell class])];
        if (cell == nil) {
            cell =  [[TZMineOtherCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([TZMineOtherCell class])];
        }
        [cell setTapBlock:^(NSInteger index) {
            [self otherAction:index];
        }];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
    }else{
        TZMineApplyCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TZMineApplyCell class])];
        if (cell == nil) {
            cell = [[TZMineApplyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([TZMineApplyCell class])];
        }
        [cell setTapBlock:^{
            if ([self judgeLogin]) {
                TZApplyAgentViewController *applyVC = [[TZApplyAgentViewController alloc] init];
                [self.navigationController pushViewController:applyVC animated:YES];
            }else{
                [self loginActionWithTarget:self];
            }
        }];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
    }
}

#pragma mark - tableViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat sectionHeaderHeight = 15;
    if (scrollView.contentOffset.y <= sectionHeaderHeight && scrollView.contentOffset.y >=0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    } else if (scrollView.contentOffset.y >= sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
}
#pragma mark - AgentAction
- (void)agentAction:(NSInteger)index{
    WeakSelf(self);
    if (![weakSelf judgeLogin]) {
        [weakSelf loginActionWithTarget:weakSelf];
        return ;
    }
    if (index == 0) {
        TZEarningsReportViewController *erVC = [[TZEarningsReportViewController alloc] init];
        [weakSelf.navigationController pushViewController:erVC animated:YES];
    }else{
        TZPartnerViewController *partnerVC = [[TZPartnerViewController alloc] init];
        [weakSelf.navigationController pushViewController:partnerVC animated:YES];
    }
}

#pragma mark - intergelAction
- (void)intergelAction:(NSInteger)index{
    WeakSelf(self);
    if (![weakSelf judgeLogin]) {
        [weakSelf loginActionWithTarget:weakSelf];
        return ;
    }
    if (index == 0) {
        [MobClick event:jifenchakan];
        TZJFDetailViewController *jfDetailVC = [[TZJFDetailViewController alloc] init];
        [weakSelf.navigationController pushViewController:jfDetailVC animated:YES];
    }
    if (index == 1) {
        [MobClick event:jifenduihshangcheng];
        TZReturnJFExchangeViewController *jifenVC = [[TZReturnJFExchangeViewController alloc] init];
        [weakSelf.navigationController pushViewController:jifenVC animated:YES];
    }
    if (index == 2) {
        [MobClick event:jifenduihuandingdan];
        TZJFOrderViewController *jfOrderVC = [[TZJFOrderViewController alloc] init];
        [weakSelf.navigationController pushViewController:jfOrderVC animated:YES];
    }
}

#pragma mark - orderAction
- (void)orderAction:(NSInteger)index{
    WeakSelf(self);
    [MobClick event:fanjifendingdan];
    if (![weakSelf judgeLogin]) {
        TZLoginViewController *loginVC = [[TZLoginViewController alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginVC];
        [weakSelf presentViewController:nav animated:YES completion:nil];
        return ;
    }
    TZReturnJFOrderViewController *jfOrderVC = [[TZReturnJFOrderViewController alloc] init];
    if (index == 0) {
        jfOrderVC.currentStatus = OrderStatusSH;
    }
    if (index == 1) {
        jfOrderVC.currentStatus = OrderStatusJJDZ;
    }
    if (index == 2) {
        jfOrderVC.currentStatus = OrderStatusYDZ;
    }
    if (index == 3) {
        jfOrderVC.currentStatus = OrderStatusWXDD;
    }
    [weakSelf.navigationController pushViewController:jfOrderVC animated:YES];
}

#pragma amrk - OtherAction
- (void)otherAction:(NSInteger)index{
    WeakSelf(self);
    if (index == 0) {
        if (![weakSelf judgeLogin]) {
            [weakSelf loginActionWithTarget:weakSelf];
            return ;
        }
        TZTaoYouViewController *tyVC = [[TZTaoYouViewController alloc] init];
        [weakSelf.navigationController pushViewController:tyVC animated:YES];
    }
    if (index == 1) {
        if(![[ALBBSession sharedInstance] isLogin]){
            [[ALBBSDK sharedInstance] auth:weakSelf successCallback:^(ALBBSession *session) {
                NSLog(@"%@",session);
            } failureCallback:^(ALBBSession *session, NSError *error) {
                NSLog(@"%@",error);
            }];
        }else{
            [SVProgressHUD showSuccessWithStatus:@"您已授权"];
            ALBBSession *session=[ALBBSession sharedInstance];
            NSString *tip = [NSString stringWithFormat:@"登录的用户信息:%@",[[session getUser] ALBBUserDescription]];
            NSLog(@"%@", tip);
        }
        return;
    }
    if (index == 2) {
        id<AlibcTradePage> page = [AlibcTradePageFactory myCartsPage];
        AlibcTradeTaokeParams *taoKeParams = [[AlibcTradeTaokeParams alloc] init];
        taoKeParams.adzoneId = @"138744610"; //your adzoneId
        taoKeParams.extParams = @{@"taokeAppkey":AliTradeSDK_Key};//your taokeAppkey
        //打开方式
        AlibcTradeShowParams* showParam = [[AlibcTradeShowParams alloc] init];
        showParam.openType = AlibcOpenTypeH5;
        //打开方式
        [[AlibcTradeSDK sharedInstance].tradeService show:weakSelf.navigationController  page:page showParams:showParam taoKeParams:nil trackParam:nil tradeProcessSuccessCallback:^(AlibcTradeResult * _Nullable result) {
            NSLog(@"%@",result);
        } tradeProcessFailedCallback:^(NSError * _Nullable error) {
            NSLog(@"%@",error);
        }];
    }
    if (index == 3) {
        [MobClick event:digndanbulu];
        if (![weakSelf judgeLogin]) {
            [weakSelf loginActionWithTarget:weakSelf];
            return ;
        }
        weakSelf.orderCollectionView = [[TZOrderCollectionView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-285/2, SCREEN_HEIGHT/2-290/2, 285, 290)];
        [kWindow addSubview:weakSelf.orderCollectionView];
        weakSelf.orderCollectionView.textField.delegate = weakSelf;
        [weakSelf.orderCollectionView setOrderNumBlock:^(NSString *orderNum){
            if (orderNum) {
                [SVProgressHUD showProgress:0];
                [weakSelf.viewModel.supplementCommand execute:@{@"u":[MYSingleton shareInstonce].loginModel.id,@"t":[MYSingleton shareInstonce].loginModel.accessToken,@"tbOrderId":orderNum,@"imgUrl":@"2222222"}];
            }else{
                [weakSelf.orderCollectionView removeFromSuperview];
                [weakSelf.orderCollectionView.bgView removeFromSuperview];
            }
        }];
        return;
    }
    if (index == 4) {
        if (![weakSelf judgeLogin]) {
            [weakSelf loginActionWithTarget:weakSelf];
            return ;
        }
        TZMessageReturnViewController *messageReturnVC = [[TZMessageReturnViewController alloc] init];
        [weakSelf.navigationController pushViewController:messageReturnVC animated:YES];
    }
    if (index == 5) {
        [MobClick event:bangzhu];
        TZKefuViewController *kefuVC = [[TZKefuViewController alloc] init];
        [weakSelf.navigationController pushViewController:kefuVC animated:YES];
        return;
    }
    if (index == 6) {
        if (![weakSelf judgeLogin]) {
            [weakSelf loginActionWithTarget:weakSelf];
            return ;
        }
        TZSettingViewController *setVC = [[TZSettingViewController alloc] init];
        [setVC setLoginOutBlock:^{
        }];
        [weakSelf.navigationController pushViewController:setVC animated:YES];
        return;
    }

}

- (void)bindingCommand{
    self.viewModel = [TZMineViewModel new];
    @weakify(self);
    [[self.viewModel.userInfoCommand.executionSignals switchToLatest] subscribeNext:^(MYBaseModel *model) {
        @strongify(self);
        if (model.data) {
            UserDefaultsSFK([[TZUserInfoModel mj_objectWithKeyValues:model.data] mj_keyValues], User_Info);//保存用户信息
            [MYSingleton shareInstonce].userInfoModel = [TZUserInfoModel mj_objectWithKeyValues:model.data];
            self.userInfoModel = [TZUserInfoModel mj_objectWithKeyValues:model.data];
            //[self.tableView reloadData];
            TZMineHeadCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
            [cell setCellInfo];
        }else{
            [UIAlertController showAlertInViewController:self withTitle:nil message:@"您的账号已在其他地方登录，请退出重新登录" cancelButtonTitle:nil destructiveButtonTitle:@"确定" otherButtonTitles:nil tapBlock:^(UIAlertController * _Nonnull controller, UIAlertAction * _Nonnull action, NSInteger buttonIndex) {
                TZSettingViewController *setVC = [[TZSettingViewController alloc] init];
                [self.navigationController pushViewController:setVC animated:YES];
            }];
        }
    }];
    if ([UserDefaultsOFK(Login_Status) intValue] == 1){
        NSLog(@"%@",UserDefaultsOFK(User_Info));
        if ([MYSingleton shareInstonce].userInfoModel.agentInfo.id) {
            [self.viewModel.userInfoCommand execute:@{@"a":[MYSingleton shareInstonce].loginModel.agentInfo.id,@"t":[MYSingleton shareInstonce].loginModel.agentInfo.accessToken}];
        }else{
            [self.viewModel.userInfoCommand execute:@{@"u":[MYSingleton shareInstonce].loginModel.id,@"t":[MYSingleton shareInstonce].loginModel.accessToken}];
        }
    }
    [[self.viewModel.supplementCommand.executionSignals switchToLatest] subscribeNext:^(MYBaseModel *model) {
        @strongify(self);
        [SVProgressHUD dismiss];
        [self.orderCollectionView removeFromSuperview];
        [self.orderCollectionView.bgView removeFromSuperview];
        if (model) {
            [SVProgressHUD showSuccessWithStatus:@"补录成功"];
        }
    }];
}

#pragma mark - Aciton
- (void)loginAction:(UIButton *)sender{
    if (![self judgeLogin]) {
        [self loginActionWithTarget:self];
    }
}

#pragma mark - HeaderAction
- (void)headAction:(NSInteger )index{
    if (index == 300) {
        if ([self judgeLogin]) {
            TZJFDetailViewController *jfVC = [[TZJFDetailViewController alloc] init];
            [self.navigationController pushViewController:jfVC animated:YES];
        }else{
            [self loginActionWithTarget:self];
        }
    }
    if (index == 301) {
        if ([self judgeLogin]) {
            TZBalanceViewController *balanceVC = [[TZBalanceViewController alloc] init];
            [self.navigationController pushViewController:balanceVC animated:YES];
        }else{
            [self loginActionWithTarget:self];
        }
    }
}

- (void)showOrderView{
    
}

-(void)qdAciton{
    if([self judgeLogin]){
        TZQianDaoViewController *qdVC = [[TZQianDaoViewController alloc] init];
        [self.navigationController pushViewController:qdVC animated:YES];
    }else{
        [self loginActionWithTarget:self];

    }
}

- (BOOL)judgeLogin{
    if ([UserDefaultsOFK(Login_Status) intValue] == 1) {
        return YES;
    }else{
        return NO;
    }
}

- (void)loginActionWithTarget:(id)target{
    TZLoginViewController *loginVC = [[TZLoginViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginVC];
    [loginVC setLoginBlock:^{
        [self.tableView reloadData];
    }];
    [target presentViewController:nav animated:YES completion:nil];
}

- (void)inviteFriend{
    if ([self judgeLogin]) {
        TZYaoQingViewController *inviteVC = [[TZYaoQingViewController alloc] init];
        [self.navigationController pushViewController:inviteVC animated:YES];
    }else{
        TZLoginViewController *loginVC = [[TZLoginViewController alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginVC];
        [self presentViewController:nav animated:YES completion:nil];
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    [UIView animateWithDuration:0.3 animations:^{
        self.orderCollectionView.frame = CGRectMake(SCREEN_WIDTH/2-285/2, SCREEN_HEIGHT/2-290, 285, 290);
    }];
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    [UIView animateWithDuration:0.3 animations:^{
        self.orderCollectionView.frame = CGRectMake(SCREEN_WIDTH/2-285/2, SCREEN_HEIGHT/2-290/2, 285, 290);
    }];
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [UIView animateWithDuration:0.3 animations:^{
        self.orderCollectionView.frame = CGRectMake(SCREEN_WIDTH/2-285/2, SCREEN_HEIGHT/2-290/2, 285, 290);
    }];
    return YES;
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
