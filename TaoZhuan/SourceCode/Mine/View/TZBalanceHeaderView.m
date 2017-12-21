//
//  TZBalanceHeaderView.m
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/12/4.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "TZBalanceHeaderView.h"

@implementation TZBalanceHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.balanceImageView = [MYBaseView imageViewWithFrame:CGRectZero andImage:[UIImage imageNamed:@"我的余额"]];
        [self addSubview:self.balanceImageView];
        [self.balanceImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(self);
            make.width.mas_equalTo(345*kScale);
            make.height.mas_equalTo(75*kScale);
        }];
        self.balanceImageView.userInteractionEnabled = YES;
        
        self.balanceLabel = [MYBaseView labelWithFrame:CGRectZero text:@"" textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentLeft andFont:kFont(18)];
        [self.balanceImageView addSubview:self.balanceLabel];
        [self.balanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.balanceImageView).offset(12);
            make.centerY.equalTo(self.balanceImageView);
        }];
        NSString *balanceString = [NSString stringWithFormat:@"我的余额：%.2f",[MYSingleton shareInstonce].userInfoModel.money];
        self.balanceLabel.attributedText = [NSString stringWithString:balanceString Range:NSMakeRange(0, 5) color:nil font:kFont(13)];
        
        self.txButton = [MYBaseView buttonWithFrame:CGRectZero buttonType:UIButtonTypeCustom title:@"提现" titleColor:[UIColor whiteColor] font:kFont(13)];
        [self.balanceImageView addSubview:self.txButton];
        [self.txButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.balanceImageView.mas_right).offset(-12);
            make.centerY.equalTo(self.balanceImageView);
            make.width.mas_equalTo(60);
            make.height.mas_equalTo(25);
        }];
        self.txButton.backgroundColor = [UIColor colorWithHexString:@"#cc2828" alpha:1.0];
        self.txButton.layer.cornerRadius = 12.5;
        
        UIView *line = [MYBaseView viewWithFrame:CGRectZero backgroundColor:[UIColor colorWithHexString:@"#dfdfdf" alpha:1.0]];
        [self addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.bottom.equalTo(self.mas_bottom);
            make.width.mas_equalTo(SCREEN_WIDTH);
            make.height.mas_equalTo(0.5);
        }];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
