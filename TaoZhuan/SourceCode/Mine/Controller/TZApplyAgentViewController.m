//
//  TZApplyAgentViewController.m
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/12/11.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "TZApplyAgentViewController.h"
#import "TZMineViewModel.h"

@interface TZApplyAgentViewController ()<UIScrollViewDelegate>

@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIImageView *agentImageView;
@property (nonatomic,strong) UIButton *upgradeButton;
@property (nonatomic,strong) UIView *bgView;
@property (nonatomic,strong) UIView *whiteBgView;
@property (nonatomic,strong) TZMineViewModel *viewModel;

@end

@implementation TZApplyAgentViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [TZStatusBarStyle setStatusBarColor:[UIColor whiteColor]];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    [self initBottomView];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.upgradeButton removeFromSuperview];
}

- (NSString *)title{
    return @"升级代理";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    [self bindingCommand];
    // Do any additional setup after loading the view.
}

- (void)initView{
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64-45)];
    [self.view addSubview:self.scrollView];
    self.scrollView.delegate = self;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.backgroundColor = rGB_Color(241, 242, 243);
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_WIDTH*1131/750);

    self.agentImageView = [MYBaseView imageViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH*1131/750) andImage:[UIImage imageNamed:@"升级代理内容"]];
    [self.scrollView addSubview:self.agentImageView];
}

- (void)initBottomView{
    //Make(0, SCREEN_HEIGHT-45-64, SCREEN_WIDTH, 45)
    self.upgradeButton = [MYBaseView buttonWithFrame:CGRectZero buttonType:UIButtonTypeCustom image:[UIImage imageNamed:@"按钮升级"] selectImage:nil];
    [self.view addSubview:self.upgradeButton];
    [self.upgradeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(45);
    }];
    self.upgradeButton.userInteractionEnabled = YES;
    @weakify(self);
    [[self.upgradeButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        [self.viewModel.agentApplyCommand execute:@{@"u":[MYSingleton shareInstonce].userInfoModel.id,@"t":[MYSingleton shareInstonce].userInfoModel.accessToken}];
    }];
}

- (void)initNoticeView{
    self.bgView = [MYBaseView viewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) backgroundColor:[UIColor blackColor]];
    [kWindow addSubview:self.bgView];
    self.bgView.alpha = 0.3;
    self.whiteBgView = [MYBaseView viewWithFrame:CGRectZero backgroundColor:[UIColor whiteColor]];
    [kWindow addSubview:self.whiteBgView];
    [self.whiteBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(kWindow);
        make.width.mas_equalTo(310);
        make.height.mas_equalTo(200);
    }];
    self.whiteBgView.layer.cornerRadius = 15;
    
    UIImageView *topImageView = [MYBaseView imageViewWithFrame:CGRectZero andImage:[UIImage imageNamed:@"代理弹框"]];
    [self.whiteBgView addSubview:topImageView];
    [topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.whiteBgView);
        make.width.mas_equalTo(310);
        make.height.mas_equalTo(75);
    }];
    
    UILabel *topLabel = [MYBaseView labelWithFrame:CGRectZero text:@"合伙人申请已发送" textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentLeft andFont:kFont(15)];
    [topImageView addSubview:topLabel];
    [topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(topImageView);
    }];
    
    UILabel *noticeLabel = [MYBaseView labelWithFrame:CGRectZero text:@"我们会尽快处理您的申请，并在12小时内联系您，请保护电话通畅~" textColor:[UIColor colorWithHexString:TZ_BLACK alpha:1.0] textAlignment:NSTextAlignmentLeft andFont:kFont(15)];
    [self.whiteBgView addSubview:noticeLabel];
    [noticeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.whiteBgView).offset(31);
        make.top.equalTo(topImageView.mas_bottom).offset(25);
        make.centerX.equalTo(self.whiteBgView);
    }];
    noticeLabel.numberOfLines = 2;
    
    UIButton *confirmButton = [MYBaseView buttonWithFrame:CGRectZero buttonType:UIButtonTypeCustom title:@"确定" titleColor:[UIColor whiteColor] font:kFont(12)];
    [self.whiteBgView addSubview:confirmButton];
    [confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.whiteBgView);
        make.top.equalTo(noticeLabel.mas_bottom).offset(20);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(30);
    }];
    confirmButton.userInteractionEnabled = YES;
    confirmButton.backgroundColor = [UIColor colorWithHexString:@"#ff4c43" alpha:1.0];
    confirmButton.layer.cornerRadius = 15;
    [[confirmButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [self.bgView removeFromSuperview];
        [self.whiteBgView removeFromSuperview];
    }];
}

- (void)bindingCommand{
    self.viewModel = [TZMineViewModel new];
    [[self.viewModel.agentApplyCommand.executionSignals switchToLatest] subscribeNext:^(NSDictionary *data) {
        if (data) {
            [self initNoticeView];
        }
    }];
    
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
