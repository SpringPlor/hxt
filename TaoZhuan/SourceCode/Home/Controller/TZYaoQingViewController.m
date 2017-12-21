//
//  TZYaoQingViewController.m
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/10/10.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "TZYaoQingViewController.h"
#import "TZYaoQingTitleCell.h"
#import "TZYaoQingRulesCell.h"
#import "TZMineViewModel.h"
#import "TZThirdShare.h"
#import "TZYaoQingQRCodeCell.h"
#import "TZShareQRCodeViewController.h"
#import "TZSearchProductViewModel.h"

@interface TZYaoQingViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) TZMineViewModel *viewModel;
@property (nonatomic,strong) TZSearchProductViewModel *shortViewModel;
@property (nonatomic,copy) NSString *inviteCode;
@property (nonatomic,copy) NSString *shortUrl;

@end

@implementation TZYaoQingViewController

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
}

- (NSString *)title{
    return @"邀请有奖";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.inviteCode = @"";
    [self tableView];
    [self bindingCommand];
    // Do any additional setup after loading the view.
}

- (void)bindingCommand{
    self.viewModel = [TZMineViewModel new];
    [SVProgressHUD showProgress:0];
    [[self.viewModel.inviteVodeCommand.executionSignals switchToLatest] subscribeNext:^(MYBaseModel *model) {
        [SVProgressHUD dismiss];
        if (model.data) {
            self.inviteCode = model.data[@"code"];
            [self.tableView reloadData];
            NSString *shareUrl = [NSString stringWithFormat:@"http://www.0760jeans.cn:9000/down?invitationCode=%@",self.inviteCode];
            [self.shortViewModel.shortUrlCommand execute:@{@"url":shareUrl}];
        }
    }];
    [self.viewModel.inviteVodeCommand execute:@{@"u":[MYSingleton shareInstonce].loginModel.id,@"t":[MYSingleton shareInstonce].loginModel.accessToken}];
    
    self.shortViewModel = [TZSearchProductViewModel new];
    [[self.shortViewModel.shortUrlCommand.executionSignals switchToLatest] subscribeNext:^(NSString *url) {
        [SVProgressHUD dismiss];
        if (url) {
            self.shortUrl = url;
        }
    }];
}

#pragma mark - tableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 2;
    }
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
        if (indexPath.row == 0) {
            return 338*kScale+124;
        }else{
            return 53;
        }
    }return 150;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            TZYaoQingTitleCell *cell = [[TZYaoQingTitleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([TZYaoQingTitleCell class])];
            [cell setInviteCode:self.inviteCode];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell setSeperatorInsetToZero:0];
            [cell setShareBlock:^(NSInteger index){
                if (!self.shortUrl) {
                    if (self.inviteCode) {
                        [SVProgressHUD showProgress:0];
                        NSString *shareUrl = [NSString stringWithFormat:@"http://www.0760jeans.cn:9000/down?invitationCode=%@",self.inviteCode];
                        [self.shortViewModel.shortUrlCommand execute:@{@"url":shareUrl}];
                    }else{
                        return ;
                    }
                }else{
                    if (index == 0){
                        [TZThirdShare shareRegisterToAppWith:UMSocialPlatformType_WechatTimeLine inviteCode:self.shortUrl];
                    }else if (index == 1){
                        [TZThirdShare shareRegisterToAppWith:UMSocialPlatformType_WechatSession inviteCode:self.shortUrl];
                    }else if (index == 2){
                        [TZThirdShare shareRegisterToAppWith:UMSocialPlatformType_Qzone inviteCode:self.shortUrl];
                    }else{
                        [TZThirdShare shareRegisterToAppWith:UMSocialPlatformType_QQ inviteCode:self.shortUrl];
                    }
                }
            }];
            return cell;
        }else{
            TZYaoQingQRCodeCell *cell  = [[TZYaoQingQRCodeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([TZYaoQingQRCodeCell class])];
            [cell setSeperatorInsetToZero:0];
            return cell;
        }
    }else{
        TZYaoQingRulesCell *cell = [[TZYaoQingRulesCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([TZYaoQingRulesCell class])];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

#pragma mark - tableViewDelagate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0 && indexPath.row == 1) {
        TZShareQRCodeViewController *shareVC = [[TZShareQRCodeViewController alloc] init];
        shareVC.inviteCode = self.inviteCode;
        [self.navigationController pushViewController:shareVC animated:YES];
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
