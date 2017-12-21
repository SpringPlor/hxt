//
//  TZNewVersionView.m
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/11/15.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "TZNewVersionView.h"

@implementation TZNewVersionView

- (instancetype) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.bgView = [MYBaseView viewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) backgroundColor:[UIColor blackColor]];
        [kWindow addSubview:self.bgView];
        self.bgView.alpha = 0.3;
        
        self.versionView = [MYBaseView imageViewWithFrame:CGRectZero andImage:[UIImage imageNamed:@"versiondi"]];
        [self addSubview:self.versionView];
        [self.versionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
            make.width.mas_equalTo(300);
            make.height.mas_equalTo(350);
        }];
        self.versionView.userInteractionEnabled = YES;
        
        UILabel *noticeLabel = [MYBaseView labelWithFrame:CGRectZero text:@"发现新版本" textColor:[UIColor colorWithHexString:@"#fef737" alpha:1.0] textAlignment:NSTextAlignmentCenter andFont:kFont(18)];
        [self.versionView addSubview:noticeLabel];
        [noticeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.versionView);
            make.top.equalTo(self.versionView).offset(67);
        }];
        
        self.versionLabel = [MYBaseView labelWithFrame:CGRectZero text:@"" textColor:[UIColor colorWithHexString:@"#fef737" alpha:1.0] textAlignment:NSTextAlignmentCenter andFont:kFont(14)];
        [self.versionView addSubview:self.versionLabel];
        [self.versionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.versionView);
            make.top.equalTo(noticeLabel.mas_bottom).offset(5);
        }];
        NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
        NSString *appVersion   = infoDict[@"CFBundleVersion"];//项目版本
        self.versionLabel.text = [NSString stringWithFormat:@"V %@",appVersion];
        
        UILabel *function1 = [MYBaseView labelWithFrame:CGRectZero text:@"1.增加购物车" textColor:[UIColor colorWithHexString:TZ_LIGHT_BLACK alpha:1.0] textAlignment:NSTextAlignmentCenter andFont:kFont(14)];
        [self.versionView addSubview:function1];
        [function1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.versionView).offset(15);
            make.top.equalTo(self.versionView).offset(135);
        }];
        
        UILabel *function2 = [MYBaseView labelWithFrame:CGRectZero text:@"2.增加意见反馈页面" textColor:[UIColor colorWithHexString:TZ_LIGHT_BLACK alpha:1.0] textAlignment:NSTextAlignmentCenter andFont:kFont(14)];
        [self.versionView addSubview:function2];
        [function2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.versionView).offset(15);
            make.top.equalTo(function1.mas_bottom).offset(10);
        }];
        
        UILabel *function3 = [MYBaseView labelWithFrame:CGRectZero text:@"3.增加购买必看教程" textColor:[UIColor colorWithHexString:TZ_LIGHT_BLACK alpha:1.0] textAlignment:NSTextAlignmentCenter andFont:kFont(14)];
        [self.versionView addSubview:function3];
        [function3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.versionView).offset(15);
            make.top.equalTo(function2.mas_bottom).offset(10);
        }];
        
        UILabel *function4 = [MYBaseView labelWithFrame:CGRectZero text:@"4.优化页面" textColor:[UIColor colorWithHexString:TZ_LIGHT_BLACK alpha:1.0] textAlignment:NSTextAlignmentCenter andFont:kFont(14)];
        [self.versionView addSubview:function4];
        [function4 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.versionView).offset(15);
            make.top.equalTo(function3.mas_bottom).offset(10);
        }];
        
        UIButton *upgradeButton = [MYBaseView buttonWithFrame:CGRectZero buttonType:UIButtonTypeCustom title:@"立即升级" titleColor:[UIColor whiteColor] font:kFont(18)];
        [self.versionView addSubview:upgradeButton];
        [upgradeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(function4.mas_bottom).offset(20);
            make.left.equalTo(self.versionView).offset(25);
            make.centerX.equalTo(self.versionView);
            make.height.mas_equalTo(40);
        }];
        upgradeButton.backgroundColor = rGB_Color(240, 66, 70);
        upgradeButton.layer.cornerRadius = 5;
        upgradeButton.clipsToBounds = YES;
        [upgradeButton addTarget:self action:@selector(upgrade:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *cancelButton = [MYBaseView buttonWithFrame:CGRectZero buttonType:UIButtonTypeCustom title:@"暂不升级" titleColor:[UIColor colorWithHexString:TZ_LIGHT_BLACK alpha:1.0] font:kFont(18)];
        [self.versionView addSubview:cancelButton];
        [cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(upgradeButton.mas_bottom).offset(10);
            make.left.equalTo(self.versionView).offset(25);
            make.centerX.equalTo(self.versionView);
            make.height.mas_equalTo(40);
        }];
        [cancelButton addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)upgrade:(UIButton *)sender{
    if (self.tapBlock) {
        self.tapBlock(YES);
    }
}

- (void)cancel:(UIButton *)sender{
    if (self.tapBlock) {
        self.tapBlock(NO);
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
