//
//  TZTixianViewController.m
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/10/14.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "TZTixianViewController.h"
#import "TZZfbAccountViewController.h"
#import "TZTiXianNoticeView.h"
#import "TZMineViewModel.h"

@interface TZTixianViewController ()

@property (nonatomic,strong) UITextField *textField;
@property (nonatomic,strong) UILabel *limitLabel;
@property (nonatomic,strong) UILabel *noticeLabel;
@property (nonatomic,strong) NSString *zfbAccount;
@property (nonatomic,strong) TZTiXianNoticeView *noticeView;
@property (nonatomic,strong) TZMineViewModel *viewModel;
@end

@implementation TZTixianViewController

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

- (NSString *)title{
    return @"提现";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = rGB_Color(241, 242, 243);
    [self initView];
    [self bindingCommand];
    // Do any additional setup after loading the view.
}

- (void)bindingCommand{
    self.viewModel = [TZMineViewModel new];
    [[self.viewModel.zfbCashCommand.executionSignals switchToLatest] subscribeNext:^(MYBaseModel *model) {
        if (model) {
            UserDefaultsSFK(self.zfbAccount, ZFB_Account);
            WeakSelf(self);
            self.noticeView = [[TZTiXianNoticeView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
            [kWindow addSubview:self.noticeView];
            [self.noticeView setTapBlock:^{
                [weakSelf.noticeView removeFromSuperview];
            }];
        }
    }];
}

- (void)initView{
    UIView *topBgView = [MYBaseView viewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 65) backgroundColor:[UIColor whiteColor]];
    [self.view addSubview:topBgView];
    topBgView.userInteractionEnabled = YES;
    [topBgView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(zfbAction:)]];
    UIImageView *zfbImageView = [MYBaseView imageViewWithFrame:CGRectZero andImage:[UIImage imageNamed:@"zhifubao"]];
    [topBgView addSubview:zfbImageView];
    [zfbImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(topBgView).offset(15);
        make.centerY.equalTo(topBgView);
        make.width.height.mas_equalTo(30);
    }];
    UILabel *zfbLabel = [MYBaseView labelWithFrame:CGRectZero text:@"支付宝" textColor:[UIColor colorWithHexString:TZ_BLACK alpha:1.0] textAlignment:NSTextAlignmentLeft andFont:kFont(15)];
    [topBgView addSubview:zfbLabel];
    [zfbLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(zfbImageView.mas_right).offset(12);
        make.centerY.equalTo(topBgView);
    }];
    UIImageView *arrowImageView = [MYBaseView imageViewWithFrame:CGRectZero andImage:[UIImage imageNamed:@"youjiantou2"]];
    [topBgView addSubview:arrowImageView];
    [arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(topBgView).offset(-15);
        make.centerY.equalTo(topBgView);
        make.width.mas_equalTo(7);
        make.height.mas_equalTo(12);
    }];
    self.noticeLabel = [MYBaseView labelWithFrame:CGRectZero text:@"请填写支付宝账号" textColor:[UIColor colorWithHexString:TZ_GRAY alpha:1.0] textAlignment:NSTextAlignmentLeft andFont:kFont(15)];
    [topBgView addSubview:self.noticeLabel];
    [self.noticeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(arrowImageView.mas_left).offset(-12);
        make.centerY.equalTo(topBgView);
    }];
    if (UserDefaultsOFK(ZFB_Account)) {
        self.zfbAccount = UserDefaultsOFK(ZFB_Account);
        self.noticeLabel.text = [self.zfbAccount stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    }
    
    UIView *midBgView = [MYBaseView viewWithFrame:CGRectZero backgroundColor:[UIColor whiteColor]];
    [self.view addSubview:midBgView];
    [midBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.top.equalTo(topBgView.mas_bottom).offset(10);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(166);
    }];
    
    UILabel *titleLabel = [MYBaseView labelWithFrame:CGRectZero text:@"提现金额" textColor:[UIColor colorWithHexString:@"#666666" alpha:1.0] textAlignment:NSTextAlignmentLeft andFont:kFont(15)];
    [midBgView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(midBgView).offset(15);
        make.top.equalTo(midBgView).offset(20);
    }];
    
    UILabel *rmbLabel = [MYBaseView labelWithFrame:CGRectZero text:@"¥" textColor:[UIColor colorWithHexString:TZ_BLACK alpha:1.0] textAlignment:NSTextAlignmentLeft andFont:kFont(25)];
    [midBgView addSubview:rmbLabel];
    [rmbLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(midBgView).offset(15);
        make.top.equalTo(titleLabel.mas_bottom).offset(28);
    }];
    
    self.textField = [MYBaseView textFieldWithFrame:CGRectZero text:nil textColor:[UIColor colorWithHexString:TZ_BLACK alpha:1.0] textAlignment:NSTextAlignmentLeft andFontSize:20 placeholder:nil style:UITextBorderStyleNone];
    [midBgView addSubview:self.textField];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(rmbLabel.mas_right).offset(5);
        make.right.equalTo(midBgView).offset(-15);
        make.centerY.equalTo(rmbLabel);
        make.height.mas_equalTo(30);
    }];
    self.textField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    
    UIView *lineView = [MYBaseView viewWithFrame:CGRectZero backgroundColor:rGB_Color(220, 220, 220)];
    [midBgView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(rmbLabel);
        make.centerX.equalTo(midBgView);
        make.height.mas_equalTo(0.5);
        make.top.equalTo(midBgView).offset(116);
    }];
    
    self.limitLabel = [MYBaseView labelWithFrame:CGRectZero text:@"可提现金额0.00" textColor:[UIColor colorWithHexString:TZ_GRAY alpha:1.0] textAlignment:NSTextAlignmentLeft andFont:kFont(15)];
    [midBgView addSubview:self.limitLabel];
    [self.limitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(midBgView).offset(15);
        make.top.equalTo(lineView.mas_bottom).offset(17);
    }];
    self.limitLabel.text = [NSString stringWithFormat:@"可提现金额%.2f",[MYSingleton shareInstonce].userInfoModel.money];
    
    UIButton *allButton = [MYBaseView buttonWithFrame:CGRectZero buttonType:UIButtonTypeCustom title:@"全部提现" titleColor:[UIColor colorWithHexString:@"#53a0f6" alpha:1.0] font:kFont(15)];
    [midBgView addSubview:allButton];
    [allButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(midBgView).offset(-15);
        make.centerY.equalTo(self.limitLabel);
    }];
    [allButton addTarget:self action:@selector(allLoad:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *submitLabel = [MYBaseView labelWithFrame:CGRectZero text:@"提现" textColor:rGB_Color(220, 220, 220) textAlignment:NSTextAlignmentCenter andFont:kFont(15)];
    [self.view addSubview:submitLabel];
    [submitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(midBgView.mas_bottom).offset(30);
        make.left.equalTo(self.view).offset(15);
        make.centerX.equalTo(self.view);
        make.height.mas_equalTo(40);
    }];
    submitLabel.userInteractionEnabled = YES;
    submitLabel.backgroundColor = [UIColor colorWithHexString:TZ_LIGHT_RED alpha:1.0];
    submitLabel.layer.cornerRadius = 5;
    submitLabel.clipsToBounds = YES;
    [RACObserve(self.textField, text) subscribeNext:^(NSString *text) {
        if (text.length == 0) {
            //self.noticeLabel.userInteractionEnabled = NO;
            submitLabel.textColor = rGB_Color(220, 220, 220);
            [submitLabel removeGestureRecognizer:[[UITapGestureRecognizer alloc] init]];
        }else{
            submitLabel.textColor = [UIColor whiteColor];
            [submitLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(submit:)]];
            //self.noticeLabel.userInteractionEnabled = YES;
        }
    }];
}

#pragma mark - Action
- (void)zfbAction:(UITapGestureRecognizer *)sender{
    TZZfbAccountViewController *zfbVC = [[TZZfbAccountViewController alloc] init];
    [zfbVC setAccountBlock:^(NSString *account){
        self.zfbAccount = account;
        self.noticeLabel.text = [account stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    }];
    [self.navigationController pushViewController:zfbVC animated:YES];
}

- (void)allLoad:(UIButton *)sender{
    self.textField.text = [NSString stringWithFormat:@"%.2f",[MYSingleton shareInstonce].userInfoModel.money];
}

- (void)submit:(UITapGestureRecognizer *)sender{
    if (self.zfbAccount.length != 0) {
        if (![ZMUtils validateMobile:self.zfbAccount] && ![ZMUtils validateEmail:self.zfbAccount]) {
            [SVProgressHUD showInfoWithStatus:@"无效的支付宝账号"];
            return;
        }
    }else{
        [SVProgressHUD showInfoWithStatus:@"无效的支付宝账号"];
        return;
    }
    
    if (![ZMUtils isPureInt:self.textField.text] || ![ZMUtils isPureFloat:self.textField.text]) {
        [SVProgressHUD showInfoWithStatus:@"无效的提现金额"];
        return;
    }
    if ([self.textField.text floatValue] > [MYSingleton shareInstonce].userInfoModel.money) {
        [SVProgressHUD showInfoWithStatus:@"无效的提现金额"];
        return;
    }
    
    [self.viewModel.zfbCashCommand execute:@{@"a":[MYSingleton shareInstonce].userInfoModel.agentInfo.id,@"t":[MYSingleton shareInstonce].userInfoModel.agentInfo.accessToken,@"zfbAcount":self.zfbAccount,@"amount":self.textField.text}];
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
