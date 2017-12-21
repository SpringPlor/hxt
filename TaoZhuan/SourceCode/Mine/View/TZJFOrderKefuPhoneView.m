//
//  TZJFOrderKefuPhoneView.m
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/10/14.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "TZJFOrderKefuPhoneView.h"

@implementation TZJFOrderKefuPhoneView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.bgImageView = [MYBaseView imageViewWithFrame:CGRectZero andImage:[UIImage imageNamed:@"kefukuang"]];
        [self addSubview:self.bgImageView];
        [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(self);
            make.center.equalTo(self);
        }];
        
        self.icon = [MYBaseView imageViewWithFrame:CGRectZero andImage:nil];
        [self.bgImageView addSubview:self.icon];
        [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.bgImageView).offset(7.5);
            make.centerY.equalTo(self);
            make.width.height.mas_equalTo(25);
        }];
        
        self.kefuLabel = [MYBaseView labelWithFrame:CGRectZero text:@"客服电话" textColor:[UIColor colorWithHexString:TZ_BLACK alpha:1.0] textAlignment:NSTextAlignmentLeft andFont:kFont(13)];
        [self.bgImageView addSubview:self.kefuLabel];
        [self.kefuLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.icon.mas_right).offset(10);
            make.centerY.equalTo(self.bgImageView);
        }];
        
        self.account = [MYBaseView labelWithFrame:CGRectZero text:@"024-8912 123" textColor:[UIColor colorWithHexString:TZ_BLACK alpha:1.0] textAlignment:NSTextAlignmentLeft andFont:kFont(13)];
        [self.bgImageView addSubview:self.account];
        [self.account mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.kefuLabel.mas_right).offset(10);
            make.centerY.equalTo(self.bgImageView);
        }];
        
        self.cutButton = [MYBaseView buttonWithFrame:CGRectZero buttonType:UIButtonTypeCustom title:@"复制" titleColor:[UIColor colorWithHexString:@"#f33535" alpha:1.0] font:kFont(14)];
        [self addSubview:self.cutButton];
        [self.cutButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-10);
            make.centerY.equalTo(self);
            make.width.mas_equalTo(60);
            make.height.mas_equalTo(27);
        }];
        self.cutButton.layer.cornerRadius = 5.0f;
        self.cutButton.layer.borderColor = [UIColor colorWithHexString:@"#f33535" alpha:1.0].CGColor;
        self.cutButton.layer.borderWidth = 1.0f;
        [self.cutButton addTarget:self action:@selector(copyAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)copyAction:(UIButton *)sender{
    [SVProgressHUD showSuccessWithStatus:@"复制成功"];
    [[UIPasteboard generalPasteboard] setString:self.account.text];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
