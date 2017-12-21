//
//  TZTiXianNoticeView.m
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/10/14.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "TZTiXianNoticeView.h"

@implementation TZTiXianNoticeView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UIView *bgView = [MYBaseView viewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) backgroundColor:[UIColor blackColor]];
        [self addSubview:bgView];
        bgView.alpha = 0.3;
        bgView.userInteractionEnabled = YES;
        [bgView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelShow:)]];
        
        UIImageView *bgImageView = [MYBaseView imageViewWithFrame:CGRectZero andImage:nil];
        [self addSubview:bgImageView];
        [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
            make.width.mas_equalTo(271);
            make.height.mas_equalTo(230);
        }];
        bgImageView.backgroundColor = [UIColor whiteColor];
        bgImageView.layer.cornerRadius = 5;
        bgImageView.userInteractionEnabled = YES;
        bgImageView.clipsToBounds = YES;

        UIImageView *iconImageView = [MYBaseView imageViewWithFrame:CGRectZero andImage:[UIImage imageNamed:@"tixiancg"]];
        [self addSubview:iconImageView];
        [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(bgImageView);
            make.top.equalTo(bgImageView).offset(30);
            make.width.mas_equalTo(40);
            make.height.mas_equalTo(40);
        }];
        
        UILabel *titleLabel = [MYBaseView labelWithFrame:CGRectZero text:@"提现成功!" textColor:[UIColor colorWithHexString:TZ_LIGHT_RED alpha:1.0] textAlignment:NSTextAlignmentCenter andFont:kFont(17)];
        [bgImageView addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(iconImageView.mas_bottom).offset(15);
            make.centerX.equalTo(bgImageView);
        }];
        
        UILabel *kefuLabel = [MYBaseView labelWithFrame:CGRectZero text:@"您的提现金额24小时内到账，有问题请联系客服，谢谢！" textColor:[UIColor colorWithHexString:TZ_BLACK alpha:1.0] textAlignment:NSTextAlignmentCenter andFont:kFont(16)];
        [bgImageView addSubview:kefuLabel];
        [kefuLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(titleLabel.mas_bottom).offset(17);
            make.left.equalTo(bgImageView).offset(15);
            make.centerX.equalTo(self);
        }];
        kefuLabel.numberOfLines = 0;
        
//        UILabel *kefuPhoneLabel = [MYBaseView labelWithFrame:CGRectZero text:@"客服电话：024-8912123" textColor:[UIColor colorWithHexString:TZ_BLACK alpha:1.0] textAlignment:NSTextAlignmentCenter andFont:kFont(15)];
//        [bgImageView addSubview:kefuPhoneLabel];
//        [kefuPhoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(kefuLabel.mas_bottom).offset(10);
//            make.centerX.equalTo(bgImageView);
//        }];
        
        UILabel *submitLabel = [MYBaseView labelWithFrame:CGRectZero text:@"确定" textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter andFont:kFont(17)];
        [bgImageView addSubview:submitLabel];
        [submitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(bgImageView.mas_bottom);
            make.left.equalTo(bgImageView);
            make.centerX.equalTo(bgImageView);
            make.height.mas_equalTo(45);
        }];
        submitLabel.backgroundColor = [UIColor colorWithHexString:TZ_LIGHT_RED alpha:1.0];
        submitLabel.clipsToBounds = YES;
        submitLabel.userInteractionEnabled = YES;
        [submitLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelShow:)]];
    }
    return self;
}

- (void)cancelShow:(UITapGestureRecognizer *)sender{
    if (self.tapBlock) {
        self.tapBlock();
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
