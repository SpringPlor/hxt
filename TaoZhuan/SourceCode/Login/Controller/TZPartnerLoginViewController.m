//
//  TZLoginViewController.m
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/10/16.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "TZPartnerLoginViewController.h"
#import "TZLoginViewModel.h"
#import "MYTabBarViewController.h"
#import "TZDeviceModel.h"
#import "TZKeyChain.h"
#import "TZBaseModel.h"
#import "TZPartnerLoginViewModel.h"

@interface TZPartnerLoginViewController ()

@property (nonatomic,strong) UIView *partnerView;
@property (nonatomic,strong) UILabel *partnerLabel;
@property (nonatomic,strong) UIImageView *partnerArrow;
@property (nonatomic,assign) BOOL drop;//是否展开
@property (nonatomic,strong) UITextField *verCodeTextField;
@property (nonatomic,strong) UITextField *inviteTextField;
@property (nonatomic,strong) UILabel *quickLabel;
@property (nonatomic,strong) UIButton *partnerButton;
@property (nonatomic,strong) TZPartnerLoginViewModel *viewModel;
@property (nonatomic,strong) UIView *dropBgView;
@property (nonatomic,strong) UIView *dropView;
@property (nonatomic,strong) UILabel *dropLabel;;
@property (nonatomic,strong) UIImageView *dropArrow;
@property (nonatomic,copy) NSArray *partnetArray;//后台类型
@property (nonatomic,assign) NSInteger index;//选中后台

@end

@implementation TZPartnerLoginViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    [self initView];
    [self initDropView];
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
    
    self.partnerView = [MYBaseView viewWithFrame:CGRectMake(50, 215*kScale, 150, 30) backgroundColor:[UIColor colorWithHexString:@"#f5f5f5" alpha:1.0]];
    [self.view addSubview:self.partnerView];
    self.partnerView.layer.cornerRadius = 4;
    self.partnerView.layer.borderWidth = 1;
    self.partnerView.layer.borderColor = [UIColor colorWithHexString:@"#dfdfdf" alpha:1.0].CGColor;
    self.partnerView.userInteractionEnabled = YES;
    [self.partnerView addGestureRecognizer:[UITapGestureRecognizer nvm_gestureRecognizerWithActionBlock:^(id sender) {
        self.drop = !self.drop;
    }]];
    
    self.partnerLabel = [MYBaseView labelWithFrame:CGRectZero text:@"请选择合伙人后台" textColor:[UIColor colorWithHexString:TZ_GRAY alpha:1.0] textAlignment:NSTextAlignmentLeft andFont:kFont(14)];
    [self.partnerView addSubview:self.partnerLabel];
    [self.partnerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.partnerView).offset(10);
        make.centerY.equalTo(self.partnerView);
    }];
    
    self.partnerArrow = [MYBaseView imageViewWithFrame:CGRectZero andImage:[UIImage imageNamed:@"下拉icon"]];
    [self.partnerView addSubview:self.partnerArrow];
    [self.partnerArrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.partnerView);
        make.width.mas_equalTo(8);
        make.height.mas_equalTo(6);
        make.right.equalTo(self.partnerView).offset(-10);
    }];
    
    UIImageView *phoneImageView = [MYBaseView imageViewWithFrame:CGRectZero andImage:[UIImage imageNamed:@"dailihoutaiicon@3x"]];
    [self.view addSubview:phoneImageView];
    [phoneImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(25);
        make.centerY.equalTo(self.partnerView);
        make.width.height.mas_equalTo(15);
    }];
    
    UIView *phoneLine = [MYBaseView viewWithFrame:CGRectZero backgroundColor:[UIColor colorWithHexString:@"#dfdfdf" alpha:1.0]];
    [self.view addSubview:phoneLine];
    [phoneLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(phoneImageView);
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.partnerView.mas_bottom).offset(7);
        make.height.mas_equalTo(0.5);
    }];
    
    UIImageView *verImageView = [MYBaseView imageViewWithFrame:CGRectZero andImage:[UIImage imageNamed:@"hhraccount"]];
    [self.view addSubview:verImageView];
    [verImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(25);
        make.top.equalTo(phoneLine.mas_bottom).offset(14.5);
        make.width.height.mas_equalTo(15);
    }];
    
    self.verCodeTextField = [MYBaseView textFieldWithFrame:CGRectZero text:nil textColor:[UIColor colorWithHexString:TZ_BLACK alpha:1.0] textAlignment:NSTextAlignmentLeft andFontSize:14 placeholder:@"输入后台账号" style:UITextBorderStyleNone];
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
    
    UIImageView *inviteImageView = [MYBaseView imageViewWithFrame:CGRectZero andImage:[UIImage imageNamed:@"hhrpassword"]];
    [self.view addSubview:inviteImageView];
    [inviteImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(25);
        make.top.equalTo(verLine.mas_bottom).offset(14.5);
        make.width.height.mas_equalTo(15);
    }];
    
    self.inviteTextField = [MYBaseView textFieldWithFrame:CGRectZero text:nil textColor:[UIColor colorWithHexString:TZ_BLACK alpha:1.0] textAlignment:NSTextAlignmentLeft andFontSize:14 placeholder:@"输入密码" style:UITextBorderStyleNone];
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
        make.left.equalTo(self.view).offset(25);
        make.top.equalTo(inviteLine.mas_bottom).offset(45*kScale);
        make.centerX.equalTo(self.view);
        make.height.mas_equalTo(40);
    }];
    [loginButton addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
    
    self.quickLabel = [MYBaseView labelWithFrame:CGRectZero text:@"登录系统" textColor:[UIColor colorWithHexString:@"#ffcccc" alpha:1.0] textAlignment:NSTextAlignmentCenter andFont:kFont(16)];
    [self.view addSubview:self.quickLabel];
    [self.quickLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(loginButton);
    }];
    self.quickLabel.userInteractionEnabled = NO;
    
    @weakify(self);
    [RACObserve(self.partnerLabel,text) subscribeNext:^(NSString *partnerStr) {
        @strongify(self);
        if ([self.partnerLabel.text isEqualToString:@"请选择合伙人后台"]) {
            loginButton.enabled = NO;
            self.quickLabel.textColor = [UIColor colorWithHexString:@"#ffcccc" alpha:1.0];
        }else{
            loginButton.enabled = YES;
            self.quickLabel.textColor = [UIColor whiteColor];
        }
    }];
    
    [RACObserve(self, drop) subscribeNext:^(id x) {
        @strongify(self);
        if ([x boolValue]) {//展开
            self.dropBgView.hidden = NO;
            self.dropView.hidden = NO;
            [UIView animateWithDuration:0.1 animations:^{
                self.dropView.frame = CGRectMake(50, 215*kScale, 150, 30+30*self.partnetArray.count);
            }];
        }else{//收起
            self.dropBgView.hidden = YES;
            self.dropView.hidden = YES;
            [UIView animateWithDuration:0.1 animations:^{
                self.dropView.frame = CGRectMake(50, 215*kScale, 150, 30);
            }];
        }
    }];
}

- (void)initDropView{
    self.index = -1;
    self.dropBgView = [MYBaseView viewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) backgroundColor:[UIColor clearColor]];
    [kWindow addSubview:self.dropBgView];
    self.dropBgView.hidden = YES;
    [self.dropBgView addGestureRecognizer:[UITapGestureRecognizer nvm_gestureRecognizerWithActionBlock:^(id sender) {
        self.drop = !self.drop;
    }]];
    
    self.dropView = [MYBaseView viewWithFrame:CGRectMake(50, 215*kScale, 150, 30) backgroundColor:[UIColor colorWithHexString:@"#f5f5f5" alpha:1.0]];
    [kWindow addSubview:self.dropView];
    self.dropView.hidden = YES;
    self.dropView.layer.cornerRadius = 4;
    self.dropView.layer.borderWidth = 1;
    self.dropView.layer.borderColor = [UIColor colorWithHexString:TZ_LIGHT_RED alpha:1.0].CGColor;
    self.dropView.userInteractionEnabled = YES;
    [self.dropView addGestureRecognizer:[UITapGestureRecognizer nvm_gestureRecognizerWithActionBlock:^(id sender) {
        self.drop = !self.drop;
    }]];
    self.dropView.clipsToBounds = YES;
    
    self.dropLabel = [MYBaseView labelWithFrame:CGRectZero text:@"请选择合伙人后台" textColor:[UIColor colorWithHexString:TZ_GRAY alpha:1.0] textAlignment:NSTextAlignmentLeft andFont:kFont(14)];
    [self.dropView addSubview:self.dropLabel];
    [self.dropLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.dropView).offset(10);
        make.top.equalTo(self.dropView);
        make.height.mas_equalTo(30);
    }];
    
    self.dropArrow = [MYBaseView imageViewWithFrame:CGRectZero andImage:[UIImage imageNamed:@"上拉icon"]];
    [self.dropView addSubview:self.dropArrow];
    [self.dropArrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.dropView).offset(12);
        make.width.mas_equalTo(8);
        make.height.mas_equalTo(6);
        make.right.equalTo(self.dropView).offset(-10);
    }];
    if (self.partnetArray.count == 0) {
        [self.viewModel.partnerTypeCommand execute:nil];
    }
    [RACObserve(self, partnetArray) subscribeNext:^(NSArray *array) {
        for (int i = 0; i < array.count; i++){
            UIView *typeView = [MYBaseView viewWithFrame:CGRectZero backgroundColor:[UIColor colorWithHexString:@"#f5f5f5" alpha:1.0]];
            [self.dropView addSubview:typeView];
            [typeView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.dropView);
                make.top.equalTo(self.dropView).offset(30+30*i);
                make.height.mas_equalTo(30);
                make.right.equalTo(self.dropView);
            }];
            typeView.tag = 110 +i;
            
            UILabel *typeLabel = [MYBaseView labelWithFrame:CGRectZero text:array[i] textColor:[UIColor colorWithHexString:TZ_GRAY alpha:1.0] textAlignment:NSTextAlignmentLeft andFont:kFont(14)];
            [self.dropView addSubview:typeLabel];
            [typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.dropView).offset(10);
                make.top.equalTo(self.dropView).offset(30+30*i);
                make.height.mas_equalTo(30);
                make.right.equalTo(self.dropView);
            }];
            typeLabel.userInteractionEnabled = YES;
            typeLabel.tag = 120+i;
            
            [typeLabel addGestureRecognizer:[UITapGestureRecognizer nvm_gestureRecognizerWithActionBlock:^(UITapGestureRecognizer * sender) {
                UILabel *tempLabel = (UILabel *)sender.view;
                self.partnerLabel.text = tempLabel.text;
                self.drop = !self.drop;
                self.index = sender.view.tag;
                tempLabel.textColor = [UIColor whiteColor];
            }]];
            typeLabel.clipsToBounds = YES;
        }

    }];
    [RACObserve(self, index) subscribeNext:^(id x) {
        NSInteger index = [x intValue];
        for (int i = 0 ; i < self.partnetArray.count; i ++){
            UIView *typeView = (UIView *)[self.dropView viewWithTag:110+i];
            typeView.backgroundColor = [UIColor colorWithHexString:@"#f5f5f5" alpha:1.0];
        }
        UIView *typeView = (UIView *)[self.dropView viewWithTag:index-10];
        if (typeView){
            typeView.backgroundColor = [UIColor colorWithHexString:@"#fb5a50" alpha:1.0];
        }
        
        for (int i = 0 ; i < self.partnetArray.count; i ++){
            UILabel *typeLabel = (UILabel *)[self.dropView viewWithTag:120+i];
            typeLabel.textColor = [UIColor colorWithHexString:TZ_GRAY alpha:1.0];
        }
        UILabel *typeLabel = (UILabel *)[self.dropView viewWithTag:index];
        if (typeLabel) {
            typeLabel.textColor = [UIColor whiteColor];
        }
    }];
}

- (void)bindCommand{
    self.viewModel = [TZPartnerLoginViewModel new];
    @weakify(self);
    [[self.viewModel.partnerTypeCommand.executionSignals switchToLatest] subscribeNext:^(TZBaseModel *model) {
        @strongify(self);
        if ([model.success intValue] == 1) {
            self.partnetArray = model.data;
        }
    }];
    [self.viewModel.partnerTypeCommand execute:nil];
    
    [[self.viewModel.agentLoginCommand.executionSignals switchToLatest] subscribeNext:^(MYBaseModel *model) {
        if (model) {
            UserDefaultsSFK(@"1", Login_Status);
            TZLoginModel *loginModel =  [TZLoginModel mj_objectWithKeyValues:model.data];
            UserDefaultsSFK([loginModel mj_keyValues], User_Info);//保存登录信息
            UserDefaultsSynchronize;
            [[MYSingleton shareInstonce] setLoginInfo];
            [[MYSingleton shareInstonce] setUserInfo];
            if (self.isRoot) {
                kWindow.rootViewController = [[MYTabBarViewController alloc] init];
            }else{
                if (self.loginBlock) {
                    self.loginBlock();
                }
                [self dismissViewControllerAnimated:YES completion:nil];
            }
        }
    }];
}

#pragma mark - Action

- (void)cancelLogin:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
    return;
}

- (void)login:(UITapGestureRecognizer *)sender{
    if (self.verCodeTextField.text.length == 0) {
        [SVProgressHUD showInfoWithStatus:@"请填写完整信息"];
        return;
    }
    if (self.inviteTextField.text.length == 0) {
        [SVProgressHUD showInfoWithStatus:@"请填写完整信息"];
        return;
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (self.partnetArray.count != 0) {
        params[@"source"] = self.partnetArray[self.index-120];
    }
    params[@"account"]  = self.verCodeTextField.text;
    params[@"password"] = self.inviteTextField.text;
    [SVProgressHUD showProgress:0];
    [self.viewModel.agentLoginCommand execute:params];
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
