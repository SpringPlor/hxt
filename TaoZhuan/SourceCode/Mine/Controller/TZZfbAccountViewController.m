//
//  TZZfbAccountViewController.m
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/10/14.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "TZZfbAccountViewController.h"

@interface TZZfbAccountViewController ()

@property (nonatomic,strong) UITextField *nameTextField;
@property (nonatomic,strong) UITextField *zfbTextField;

@end

@implementation TZZfbAccountViewController

- (NSString *)title{
    return @"支付宝账号";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = rGB_Color(241, 242, 243);
    [self initView];
    // Do any additional setup after loading the view.
}

- (void)initView{
    UIView *topBgView = [MYBaseView viewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 107) backgroundColor:[UIColor whiteColor]];
    [self.view addSubview:topBgView];
    topBgView.userInteractionEnabled = YES;
    NSArray *titleArray = @[@"姓名",@"支付宝账号"];
    NSArray *placeHolderArray = @[@"请输入姓名",@"请输入支付宝账号"];
    for (int i = 0; i < 2 ; i ++){
        UILabel *leftLabel = [MYBaseView labelWithFrame:CGRectZero text:titleArray[i] textColor:[UIColor colorWithHexString:@"#666666" alpha:1.0] textAlignment:NSTextAlignmentLeft andFont:kFont(15)];
        [topBgView addSubview:leftLabel];
        [leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view).offset(15);
            make.top.equalTo(topBgView).offset(54*i);
            make.height.mas_equalTo(54);
        }];
        
        UITextField *textField = [MYBaseView textFieldWithFrame:CGRectZero text:nil textColor:[UIColor colorWithHexString:@"#666666" alpha:1.0] textAlignment:NSTextAlignmentLeft andFontSize:15 placeholder:placeHolderArray[i] style:UITextBorderStyleNone];
        [topBgView addSubview:textField];
        [textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(topBgView).offset(100);
            make.centerY.equalTo(leftLabel);
            make.height.mas_equalTo(20);
            make.right.equalTo(topBgView).offset(-15);
        }];
        if (i == 0 ) {
            self.nameTextField = textField;
        }else{
            self.zfbTextField = textField;
        }
    }
    
    UIView *lineView = [MYBaseView viewWithFrame:CGRectZero backgroundColor:rGB_Color(220, 220, 220)];
    [topBgView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(topBgView).offset(15);
        make.centerX.equalTo(topBgView);
        make.height.mas_equalTo(0.5);
        make.top.equalTo(topBgView).offset(53);
    }];
    
    UILabel *submitLabel = [MYBaseView labelWithFrame:CGRectZero text:@"确定" textColor:rGB_Color(220, 220, 220) textAlignment:NSTextAlignmentCenter andFont:kFont(15)];
    [self.view addSubview:submitLabel];
    [submitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topBgView.mas_bottom).offset(30);
        make.left.equalTo(self.view).offset(15);
        make.centerX.equalTo(self.view);
        make.height.mas_equalTo(40);
    }];
    submitLabel.userInteractionEnabled = YES;
    submitLabel.backgroundColor = [UIColor colorWithHexString:TZ_LIGHT_RED alpha:1.0];
    submitLabel.layer.cornerRadius = 5;
    submitLabel.clipsToBounds = YES;
    [submitLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(submit:)]];
    RAC(submitLabel,textColor) = [RACSignal combineLatest:@[self.nameTextField.rac_textSignal,self.zfbTextField.rac_textSignal] reduce:^id(NSString *nameString,NSString *zfbString){
        if (nameString.length > 0 && zfbString.length > 0) {
            return [UIColor whiteColor];
        }else{
            return rGB_Color(220, 220, 220);
        }
    }];
    RAC(submitLabel,userInteractionEnabled) = [RACSignal combineLatest:@[self.nameTextField.rac_textSignal,self.zfbTextField.rac_textSignal] reduce:^id(NSString *nameString,NSString *zfbString){
        if (nameString.length > 0 && zfbString.length > 0) {
            return @(YES);
        }else{
            return @(NO);
        }
    }];
}

- (void)submit:(UITapGestureRecognizer *)sender{
    if ([ZMUtils validateEmail:self.zfbTextField.text] || [ZMUtils validateMobile:self.zfbTextField.text]){
        if (self.accountBlock) {
            self.accountBlock(self.zfbTextField.text);
        }
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [SVProgressHUD showInfoWithStatus:@"请填写正确的支付宝账号"];
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
