//
//  TZNoDataNoticeView.m
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/10/19.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "TZNoDataNoticeView.h"

@implementation TZNoDataNoticeView

- (instancetype)initWithFrame:(CGRect)frame image:(NSString *)image imageSize:(CGSize)imageSize title:(NSString *)title message:(NSString *)message{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = rGB_Color(241, 242, 243);
        
        UIImageView *picImageView = [MYBaseView imageViewWithFrame:CGRectZero andImage:[UIImage imageNamed:image]];
        [self addSubview:picImageView];
        [picImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.centerY.equalTo(self.mas_centerY).offset(-40);
            make.width.mas_equalTo(imageSize.width);
            make.height.mas_equalTo(imageSize.height);
        }];
        
        UILabel *titleLabel = [MYBaseView labelWithFrame:CGRectZero text:title textColor:[UIColor colorWithHexString:@"#666666" alpha:1.0] textAlignment:NSTextAlignmentCenter andFont:kFont(16)];
        [self addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(picImageView.mas_bottom).offset(20);
            make.centerX.equalTo(picImageView);
        }];
        
        self.messageLabel = [MYBaseView labelWithFrame:CGRectZero text:message textColor:[UIColor colorWithHexString:@"#666666" alpha:1.0] textAlignment:NSTextAlignmentCenter andFont:kFont(16)];
        [self addSubview:self.messageLabel];
        [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(titleLabel.mas_bottom).offset(2);
            make.centerX.equalTo(picImageView);
        }];
        
        self.inviteButton = [MYBaseView buttonWithFrame:CGRectZero buttonType:UIButtonTypeCustom title:@"立即邀请" titleColor:[UIColor colorWithHexString:TZ_LIGHT_RED alpha:1.0] font:kFont(16)];
        [self addSubview:self.inviteButton];
        [self.inviteButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(titleLabel.mas_bottom).offset(35);
            make.width.mas_equalTo(136);
            make.height.mas_equalTo(40);
        }];
        self.inviteButton.layer.cornerRadius = 5;
        self.inviteButton.layer.borderColor = [UIColor colorWithHexString:TZ_LIGHT_RED alpha:1.0].CGColor;
        self.inviteButton.layer.borderWidth = 0.5;
        self.inviteButton.hidden = YES;
        [self.inviteButton addTarget:self action:@selector(inviteAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)inviteAction:(UIButton *)sender{
    if (self.inviteBlock) {
        self.inviteBlock();
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
