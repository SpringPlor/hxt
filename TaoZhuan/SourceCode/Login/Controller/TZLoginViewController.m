//
//  TZLoginViewController.m
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/10/16.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "TZLoginViewController.h"
#import "TZLoginViewModel.h"
#import "MYTabBarViewController.h"
#import "TZDeviceModel.h"
#import "TZKeyChain.h"
#import "TZPartnerLoginViewController.h"

@interface TZLoginViewController ()

@property (nonatomic,strong) UITextField *phoneTextField;
@property (nonatomic,strong) UITextField *verCodeTextField;
@property (nonatomic,strong) UITextField *inviteTextField;
@property (nonatomic,strong) UIButton *verButton;
@property (nonatomic,strong) UILabel *quickLabel;
@property (nonatomic,strong) UIButton *partnerButton;
@property (nonatomic,assign) NSInteger num;//验证码计时
@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,strong) TZLoginViewModel *viewModel;

@end

@implementation TZLoginViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [TZStatusBarStyle setStatusBarColor:[UIColor whiteColor]];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    [self initView];
    [self initTimer];
    [self bindCommand];
    // Do any additional setup after loading the view.
}

- (void)initView{
    UIButton *cancelButton = [MYBaseView buttonWithFrame:CGRectZero buttonType:UIButtonTypeCustom image:[UIImage imageNamed:@"quxiao"] selectImage:nil];
    [self.view addSubview:cancelButton];
    [cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(15);
        make.top.equalTo(self.view).offset(35);
        make.width.height.mas_equalTo(15);
    }];
    [cancelButton addTarget:self action:@selector(cancelLogin:) forControlEvents:UIControlEventTouchUpInside];
    cancelButton.hitTestEdgeInsets = UIEdgeInsetsMake(-10, -10, -10, -10);
    
    UIImageView *iconImageView = [MYBaseView imageViewWithFrame:CGRectZero andImage:[UIImage imageNamed:@"120"]];
    [self.view addSubview:iconImageView];
    [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(75);
        make.width.height.mas_equalTo(60);
    }];
    iconImageView.layer.cornerRadius = 10;
    iconImageView.clipsToBounds = YES;
    
    self.verButton = [MYBaseView buttonWithFrame:CGRectZero buttonType:UIButtonTypeCustom title:@"验证" titleColor:[UIColor colorWithHexString:TZ_LIGHT_RED alpha:1.0] font:kFont(16)];
    [self.view addSubview:self.verButton];
    [self.verButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-25);
        make.top.equalTo(iconImageView.mas_bottom).offset(80);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(30);
    }];
    self.verButton.layer.cornerRadius = 5.0f;
    self.verButton.layer.borderColor = [UIColor colorWithHexString:TZ_LIGHT_RED alpha:1.0].CGColor;
    self.verButton.layer.borderWidth = 0.5;
    [self.verButton addTarget:self action:@selector(fetchVerCode:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *phoneImageView = [MYBaseView imageViewWithFrame:CGRectZero andImage:[UIImage imageNamed:@"图层10"]];
    [self.view addSubview:phoneImageView];
    [phoneImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(25);
        make.centerY.equalTo(self.verButton);
        make.width.height.mas_equalTo(15);
    }];
    
    self.phoneTextField = [MYBaseView textFieldWithFrame:CGRectZero text:nil textColor:[UIColor colorWithHexString:TZ_BLACK alpha:1.0] textAlignment:NSTextAlignmentLeft andFontSize:14 placeholder:@"输入手机号" style:UITextBorderStyleNone];
    [self.view addSubview:self.phoneTextField];
    [self.phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(phoneImageView.mas_right).offset(10);
        make.right.equalTo(self.verButton.mas_left).offset(-10);
        make.centerY.equalTo(self.verButton);
        make.height.mas_equalTo(30);
    }];
    
    UIView *phoneLine = [MYBaseView viewWithFrame:CGRectZero backgroundColor:[UIColor colorWithHexString:@"#dfdfdf" alpha:1.0]];
    [self.view addSubview:phoneLine];
    [phoneLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(phoneImageView);
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.verButton.mas_bottom).offset(7);
        make.height.mas_equalTo(0.5);
    }];
    
    UIImageView *verImageView = [MYBaseView imageViewWithFrame:CGRectZero andImage:[UIImage imageNamed:@"yanz"]];
    [self.view addSubview:verImageView];
    [verImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(25);
        make.top.equalTo(phoneLine.mas_bottom).offset(14.5);
        make.width.height.mas_equalTo(15);
    }];
    
    self.verCodeTextField = [MYBaseView textFieldWithFrame:CGRectZero text:nil textColor:[UIColor colorWithHexString:TZ_BLACK alpha:1.0] textAlignment:NSTextAlignmentLeft andFontSize:14 placeholder:@"输入验证码" style:UITextBorderStyleNone];
    [self.view addSubview:self.verCodeTextField];
    [self.verCodeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(phoneImageView.mas_right).offset(10);
        make.right.equalTo(self.view).offset(-25);
        make.centerY.equalTo(verImageView);
        make.height.mas_equalTo(30);
    }];
    
    UIView *verLine = [MYBaseView viewWithFrame:CGRectZero backgroundColor:[UIColor colorWithHexString:@"#dfdfdf" alpha:1.0]];
    [self.view addSubview:verLine];
    [verLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(phoneImageView);
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.verCodeTextField.mas_bottom).offset(7);
        make.height.mas_equalTo(0.5);
    }];
    
    UIImageView *inviteImageView = [MYBaseView imageViewWithFrame:CGRectZero andImage:[UIImage imageNamed:@"yaoqingma"]];
    [self.view addSubview:inviteImageView];
    [inviteImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(25);
        make.top.equalTo(verLine.mas_bottom).offset(14.5);
        make.width.height.mas_equalTo(15);
    }];
    
    self.inviteTextField = [MYBaseView textFieldWithFrame:CGRectZero text:nil textColor:[UIColor colorWithHexString:TZ_BLACK alpha:1.0] textAlignment:NSTextAlignmentLeft andFontSize:14 placeholder:@"输入邀请码（可不填）" style:UITextBorderStyleNone];
    [self.view addSubview:self.inviteTextField];
    [self.inviteTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(phoneImageView.mas_right).offset(10);
        make.right.equalTo(self.view).offset(-25);
        make.centerY.equalTo(inviteImageView);
        make.height.mas_equalTo(30);
    }];
    
    UIView *inviteLine = [MYBaseView viewWithFrame:CGRectZero backgroundColor:[UIColor colorWithHexString:@"#dfdfdf" alpha:1.0]];
    [self.view addSubview:inviteLine];
    [inviteLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(phoneImageView);
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.inviteTextField.mas_bottom).offset(7);
        make.height.mas_equalTo(0.5);
    }];
    
    UIButton *loginButton = [MYBaseView buttonWithFrame:CGRectZero buttonType:UIButtonTypeCustom image:[UIImage imageNamed:@"矩形4"] selectImage:nil];
    [self.view addSubview:loginButton];
    [loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(inviteLine.mas_bottom).offset(45);
        make.centerX.equalTo(self.view);
        make.width.mas_equalTo(325*kScale);
        make.height.mas_equalTo(40);
    }];
    [loginButton addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
    
    self.quickLabel = [MYBaseView labelWithFrame:CGRectZero text:@"快速登录" textColor:[UIColor colorWithHexString:@"#ffcccc" alpha:1.0] textAlignment:NSTextAlignmentCenter andFont:kFont(16)];
    [self.view addSubview:self.quickLabel];
    [self.quickLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(loginButton);
    }];
    self.quickLabel.userInteractionEnabled = NO;
    
    self.partnerButton = [MYBaseView buttonWithFrame:CGRectZero buttonType:UIButtonTypeCustom title:@"合伙人入口" titleColor:[UIColor colorWithHexString:TZ_LIGHT_RED alpha:1.0] font:kFont(16)];
    [self.view addSubview:self.partnerButton];
    [self.partnerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(loginButton.mas_bottom).offset(20*kScale);
        make.left.equalTo(loginButton);
        make.width.mas_equalTo(325*kScale);
        make.height.mas_offset(40);
    }];
    self.partnerButton.backgroundColor = [UIColor whiteColor];
    self.partnerButton.layer.borderColor = [UIColor colorWithHexString:TZ_LIGHT_RED alpha:1.0].CGColor;
    self.partnerButton.layer.borderWidth = 0.5f;
    self.partnerButton.layer.cornerRadius = 20;
    self.partnerButton.clipsToBounds = YES;
    @weakify(self);
    [[self.partnerButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        TZPartnerLoginViewController *partnerVC = [[TZPartnerLoginViewController alloc] init];
        [partnerVC setLoginBlock:^{
            if (self.loginBlock) {
                self.loginBlock();
            }
        }];
        [self.navigationController pushViewController:partnerVC animated:YES];
    }];
    
    UIButton *cancelLogin = [MYBaseView buttonWithFrame:CGRectZero buttonType:UIButtonTypeCustom title:@"先去找券下次再注册" titleColor:[UIColor colorWithHexString:@"#666666" alpha:1.0] font:kFont(14)];
    [self.view addSubview:cancelLogin];
    [cancelLogin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.partnerButton.mas_bottom).offset(10);
        make.left.equalTo(loginButton);
        make.centerX.equalTo(self.view);
        make.height.mas_equalTo(30);
    }];
    [cancelLogin addTarget:self action:@selector(cutRootVC:) forControlEvents:UIControlEventTouchUpInside];
    
    RAC(phoneImageView,image) = [self.phoneTextField.rac_textSignal map:^id(NSString *phone) {
        return phone.length != 0 ? [UIImage imageNamed:@"图层10"] :[UIImage imageNamed:@"shoujihao "];
    }];
    
    RAC(verImageView,image) = [self.verCodeTextField.rac_textSignal map:^id(NSString *ver) {
        return ver.length != 0 ? [UIImage imageNamed:@"图层11"] :[UIImage imageNamed:@"yanz"];
    }];
    
    RAC(inviteImageView,image) = [self.inviteTextField.rac_textSignal map:^id(NSString *invite) {
        return invite.length != 0 ? [UIImage imageNamed:@"图层12"] :[UIImage imageNamed:@"yaoqingma"];
    }];

    
    RAC(self.quickLabel,textColor) = [RACSignal combineLatest:@[self.phoneTextField.rac_textSignal,self.verCodeTextField.rac_textSignal] reduce:^id{
        return self.phoneTextField.text.length != 0 && self.verCodeTextField.text.length != 0 ? [UIColor whiteColor] : [UIColor colorWithHexString:@"#ffcccc" alpha:1.0];
    }];
    
    RAC(loginButton,enabled) = [RACSignal combineLatest:@[self.phoneTextField.rac_textSignal,self.verCodeTextField.rac_textSignal] reduce:^id{
        return self.phoneTextField.text.length != 0 && self.verCodeTextField.text.length != 0 ? @(YES) : @(NO);
    }];
}

- (void)initTimer{
    self.num = 60;
    self.timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(repeatVerifyCode) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSDefaultRunLoopMode];
    [self.timer setFireDate:[NSDate distantFuture]];
}

- (void)bindCommand{
    self.viewModel = [TZLoginViewModel new];
    @weakify(self);
    [[self.viewModel.verCommand.executionSignals switchToLatest] subscribeNext:^(MYBaseModel *model) {
        if ([model.success intValue] == 1) {
            NSLog(@"%@",model.data);
        }
    }];
    [[self.viewModel.loginCommand.executionSignals switchToLatest] subscribeNext:^(MYBaseModel *model) {
        @strongify(self);
        if (model) {
            UserDefaultsSFK(@"1", Login_Status);
            UserDefaultsSFK([[TZLoginModel mj_objectWithKeyValues:model.data] mj_keyValues], User_Info);//保存登录信息
            UserDefaultsSynchronize;
            [[MYSingleton shareInstonce] setLoginInfo];
            [[MYSingleton shareInstonce] setUserInfo];
            if (self.loginBlock) {
                self.loginBlock();
            }
            if (self.isRoot) {
                kWindow.rootViewController = [[MYTabBarViewController alloc] init];
            }else{
                [self dismissViewControllerAnimated:YES completion:nil];
            }
        }
    }];
    [[self.viewModel.deviceIdCommand.executionSignals switchToLatest] subscribeNext:^(MYBaseModel *model) {
        @strongify(self);
        if (model) {
            UserDefaultsSFK([[TZDeviceModel mj_objectWithKeyValues:model.data] mj_keyValues], User_Device_Info);//保存登录信息
            if (self.isRoot) {
                kWindow.rootViewController = [[MYTabBarViewController alloc] init];
            }else{
                [self dismissViewControllerAnimated:YES completion:nil];
            }
        }
    }];
}

#pragma mark - Action

- (void)cancelLogin:(UIButton *)sender{
    if (!UserDefaultsOFK(User_Device_Info)) {
        NSData *UUID = [TZKeyChain load:kUUIDKeyChainKey];
        NSString *deviceUUID = [[NSString alloc] initWithData:UUID encoding:NSUTF8StringEncoding];
        [self.viewModel.deviceIdCommand execute:@{@"deviceId":deviceUUID}];
    }else{
        if (self.isRoot) {
            kWindow.rootViewController = [[MYTabBarViewController alloc] init];
        }else{
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }
}

- (void)fetchVerCode:(UIButton *)sender{
    if ([ZMUtils validateMobile:self.phoneTextField.text]) {
        [self.timer setFireDate:[NSDate distantPast]];
        NSData *UUID = [TZKeyChain load:kUUIDKeyChainKey];
        NSString *deviceUUID = [[NSString alloc] initWithData:UUID encoding:NSUTF8StringEncoding];
        [self.viewModel.verCommand execute:@{@"phoneNumber":self.phoneTextField.text,@"deviceId":deviceUUID}];
    }else{
        [SVProgressHUD showErrorWithStatus:@"请输入正确手机号"];
    }
}

- (void)login:(UITapGestureRecognizer *)sender{
    [MobClick event:denglu];
    NSMutableDictionary *paramas = [NSMutableDictionary dictionary];
    paramas[@"phoneNumber"] = self.phoneTextField.text;
    paramas[@"verifyCode"] = self.verCodeTextField.text;
    if (self.inviteTextField.text.length != 0) {
        paramas[@"invitationCode"] = self.inviteTextField.text;
    }
    NSData *UUID = [TZKeyChain load:kUUIDKeyChainKey];
    NSString *deviceUUID = [[NSString alloc] initWithData:UUID encoding:NSUTF8StringEncoding];
    paramas[@"deviceId"] = deviceUUID;
    [SVProgressHUD showProgress:0];
    [self.viewModel.loginCommand execute:paramas];
}

- (void)repeatVerifyCode{
    if (_num > 0) {
        _num --;
        [self.verButton setTitle:[NSString stringWithFormat:@"%ldS",(long)_num] forState:UIControlStateNormal];
        self.verButton.userInteractionEnabled = NO;
        [self.verButton setTitleColor:[UIColor colorWithHexString:TZ_GRAY alpha:1.0] forState:UIControlStateNormal];
        self.verButton.layer.borderColor = [UIColor colorWithHexString:TZ_GRAY alpha:1.0].CGColor;
        return;
    }
    if (_num == 0) {
        _num = 60;
        [_timer setFireDate:[NSDate distantFuture]];
        self.verButton.userInteractionEnabled = YES;
        [self.verButton setTitle:@"验证" forState:UIControlStateNormal];
        [self.verButton setTitleColor:[UIColor colorWithHexString:TZ_LIGHT_RED alpha:1.0] forState:UIControlStateNormal];
        self.verButton.layer.borderColor = [UIColor colorWithHexString:TZ_LIGHT_RED alpha:1.0].CGColor;
    }
}

- (void)dealloc{
    [_timer invalidate];
}

- (void)cutRootVC:(UIButton *)sender{
    if (!UserDefaultsOFK(User_Device_Info)) {
        NSData *UUID = [TZKeyChain load:kUUIDKeyChainKey];
        NSString *deviceUUID = [[NSString alloc] initWithData:UUID encoding:NSUTF8StringEncoding];
        [self.viewModel.deviceIdCommand execute:@{@"deviceId":deviceUUID}];
    }else{
        if (self.isRoot) {
            kWindow.rootViewController = [[MYTabBarViewController alloc] init];
        }else{
            [self dismissViewControllerAnimated:YES completion:nil];
        }
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
