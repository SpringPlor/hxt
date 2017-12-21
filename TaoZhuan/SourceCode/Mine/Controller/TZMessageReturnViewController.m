//
//  TZMessageReturnViewController.m
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/11/10.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "TZMessageReturnViewController.h"
#import "TZMineViewModel.h"

@interface TZMessageReturnViewController ()<UITextViewDelegate>

@property (nonatomic,strong) TZMineViewModel *viewModel;
@property (nonatomic,strong) UITextView *textView;
@property (nonatomic,strong) UIView *noticeView;
@property (nonatomic,strong) UIView *bgView;

@end

@implementation TZMessageReturnViewController

- (UITextView *)textView{
    if (_textView == nil) {
        
    }
    return _textView;
}

- (NSString *)title{
    return @"意见反馈";
}
-(void)viewWillAppear:(BOOL)animated{
    [TZStatusBarStyle setStatusBarColor:[UIColor whiteColor]];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    [MYSingleton shareInstonce].tabBarView.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:TZ_TableView_Color alpha:1.0];
    [self initView];
    [self bindingCommand];
    // Do any additional setup after loading the view.
}

- (void)initView{
    UIView *bgView = [MYBaseView viewWithFrame:CGRectMake(15, 15, SCREEN_WIDTH-30, 200) backgroundColor:[UIColor whiteColor]];
    [self.view addSubview:bgView];
    bgView.layer.cornerRadius = 5;
    bgView.clipsToBounds = YES;
    
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(15,15, SCREEN_WIDTH-60, 170)];
    [bgView addSubview:_textView];
    _textView.delegate = self;
    _textView.font = kFont(17);
    self.textView.text = @"请输入您的建议";
    self.textView.textColor = [UIColor colorWithHexString:TZ_GRAY alpha:1.0];
    
    UIButton *submitButton = [MYBaseView buttonWithFrame:CGRectZero buttonType:UIButtonTypeCustom title:@"提交" titleColor:[UIColor whiteColor] font:kFont(17)];
    [self.view addSubview:submitButton];
    [submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-15);
        make.top.equalTo(bgView.mas_bottom).offset(15);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(40);
    }];
    submitButton.layer.cornerRadius = 5;
    submitButton.backgroundColor = [UIColor colorWithHexString:TZ_LIGHT_RED alpha:1.0];
    [submitButton addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)bindingCommand{
    @weakify(self);
    self.viewModel = [TZMineViewModel new];
    [[self.viewModel.messageReturnCommand.executionSignals switchToLatest] subscribeNext:^(id x) {
        @strongify(self);
        if (x) {
            [self showNotice];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.bgView removeFromSuperview];
                [self.noticeView removeFromSuperview];
            });
        }
    }];
}

- (void)submit:(UIButton *)sender{
    if (self.textView.text.length == 0 || [self.textView.text isEqualToString:@"请输入您的建议"]) {
        [SVProgressHUD showInfoWithStatus:@"内容不能为空"];
        return;
    }
    NSDictionary *params = @{@"u":[MYSingleton shareInstonce].loginModel.id,@"t":[MYSingleton shareInstonce].loginModel.accessToken,@"content":self.textView.text};
    [self.viewModel.messageReturnCommand execute:params];
    
}

- (void)showNotice{
    self.bgView = [MYBaseView viewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) backgroundColor:[UIColor blackColor]];
    [kWindow addSubview:self.bgView];
    self.bgView.alpha = 0.3;
    
    self.noticeView = [MYBaseView viewWithFrame:CGRectZero backgroundColor:[UIColor whiteColor]];
    [kWindow addSubview:self.noticeView];
    [self.noticeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(kWindow);
        make.width.mas_equalTo(215);
        make.height.mas_equalTo(130);
    }];
    self.noticeView.layer.cornerRadius = 5;
    
    UIImageView *noticeImageView = [MYBaseView imageViewWithFrame:CGRectZero andImage:[UIImage imageNamed:@"chengg"]];
    [self.noticeView addSubview:noticeImageView];
    [noticeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.noticeView);
        make.centerY.equalTo(self.noticeView.mas_centerY).offset(-20);
    }];
    
    UILabel *noticeLabel = [MYBaseView labelWithFrame:CGRectZero text:@"提交成功" textColor:[UIColor colorWithHexString:TZ_LIGHT_RED alpha:1.0] textAlignment:NSTextAlignmentCenter andFont:kFont(18)];
    [self.noticeView addSubview:noticeLabel];
    [noticeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(noticeImageView.mas_bottom).offset(13);
        make.centerX.equalTo(self.noticeView);
    }];
}

#pragma mark - textViewDelegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    if ([textView.text isEqualToString:@"请输入您的建议"]) {
        self.textView.text = @"";
        self.textView.textColor = [UIColor colorWithHexString:TZ_BLACK alpha:1.0];
    }
    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView{
    if (textView.text.length == 0) {
        self.textView.text = @"请输入您的建议";
        self.textView.textColor = [UIColor colorWithHexString:TZ_GRAY alpha:1.0];
    }
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
