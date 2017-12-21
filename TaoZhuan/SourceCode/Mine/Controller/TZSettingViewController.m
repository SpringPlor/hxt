//
//  TZSettingViewController.m
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/10/14.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "TZSettingViewController.h"
#import "TZMineViewModel.h"
#import "TZSettingCell.h"
#import "TZSettingQuitCell.h"
#import "TZNewVersionView.h"

@interface TZSettingViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *taleView;
@property (nonatomic,strong) UILabel *numLabel;
@property (nonatomic,strong) TZMineViewModel *viewModel;;

@end


@implementation TZSettingViewController

- (UITableView *)taleView{
    if (_taleView == nil) {
        _taleView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
        [self.view addSubview:_taleView];
        _taleView.delegate = self;
        _taleView.dataSource = self;
        _taleView.tableFooterView = [[UIView alloc] init];
        _taleView.backgroundColor = [UIColor colorWithHexString:TZ_TableView_Color alpha:1.0];
        _taleView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _taleView.scrollEnabled = NO;
    }
    return _taleView;
}

- (void)viewWillAppear:(BOOL)animated{
    [TZStatusBarStyle setStatusBarColor:[UIColor whiteColor]];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

- (NSString *)title{
    return @"设置";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self taleView];
    [self bindingCommand];
    // Do any additional setup after loading the view.
}


- (void)bindingCommand{
    self.viewModel = [TZMineViewModel new];
    [[self.viewModel.loginOutCommand.executionSignals switchToLatest] subscribeNext:^(MYBaseModel *model) {
        if (model) {
            UserDefaultsSFK(@"0", Login_Status);
            UserDefaultsSFK(@{}, User_Info);
            [[MYSingleton shareInstonce] setUserInfo];
            [[MYSingleton shareInstonce] setLoginInfo];
            if (self.loginOutBlock) {
                self.loginOutBlock();
            }
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
}

#pragma mark - tableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 2) {
        return 70;
    }
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *bgView = [MYBaseView viewWithFrame:CGRectZero backgroundColor:[UIColor colorWithHexString:TZ_TableView_Color alpha:1.0]];
    return bgView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section != 2) {
        TZSettingCell *cell = [[TZSettingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([TZSettingCell class])];
        [cell setCellInfoWithIndex:indexPath.section];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        TZSettingQuitCell *cell = [[TZSettingQuitCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([TZSettingQuitCell class])];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setQuitBlock:^{
            [UIAlertController showAlertInViewController:self withTitle:@"是否退出登录" message:nil cancelButtonTitle:@"点错了" destructiveButtonTitle:@"退出" otherButtonTitles:nil tapBlock:^(UIAlertController * _Nonnull controller, UIAlertAction * _Nonnull action, NSInteger buttonIndex) {
                if (buttonIndex == 0) {
                    NSLog(@"点错了");
                }else{
                    [self.viewModel.loginOutCommand execute:@{@"u":[MYSingleton shareInstonce].loginModel.id,@"t":[MYSingleton shareInstonce].loginModel.accessToken}];
                    NSLog(@"退出");
                }
            }];
        }];
        return cell;
    }
}

#pragma mark - tableViewDataSource

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
