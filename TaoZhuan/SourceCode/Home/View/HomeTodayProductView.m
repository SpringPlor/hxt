//
//  HomeTodayProductView.m
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/9/30.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "HomeTodayProductView.h"

@implementation HomeTodayProductView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.iconImageView = [MYBaseView imageViewWithFrame:CGRectZero andImage:nil];
        [self addSubview:self.iconImageView];
        [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(self);
            make.width.height.mas_equalTo(115);
        }];
        
        self.priceLabel = [MYBaseView labelWithFrame:CGRectZero text:@"券后:¥190" textColor:[UIColor colorWithHexString:@"#F33535" alpha:1.0] textAlignment:NSTextAlignmentCenter andFont:kFont(14)];
        [self addSubview:self.priceLabel];
        [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.iconImageView);
            make.top.equalTo(self.iconImageView.mas_bottom).offset(10);
        }];
        
        self.couponLeft = [MYBaseView imageViewWithFrame:CGRectZero andImage:[UIImage imageNamed:@"quanleft"]];
        [self addSubview:self.couponLeft];
        [self.couponLeft mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.iconImageView.mas_centerX).offset(-20);
            make.top.equalTo(self.priceLabel.mas_bottom).offset(8);
            make.width.mas_equalTo(14);
            make.height.mas_equalTo(14);
        }];
        
        self.couponRight = [MYBaseView imageViewWithFrame:CGRectZero andImage:[UIImage imageNamed:@"quanright"]];
        [self addSubview:self.couponRight];
        [self.couponRight mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.couponLeft.mas_right);
            make.top.equalTo(self.priceLabel.mas_bottom).offset(8);
            make.width.mas_equalTo(39);
            make.height.mas_equalTo(14);
        }];
        
        self.couponPriceLabel = [MYBaseView labelWithFrame:CGRectZero text:@"20元" textColor:[UIColor colorWithHexString:@"#F33535" alpha:1.0] textAlignment:NSTextAlignmentLeft andFont:kFont(11)];
        [self.couponRight addSubview:self.couponPriceLabel];
        [self.couponPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.couponRight);
        }];

        self.tbPriceLabel = [MYBaseView labelWithFrame:CGRectZero text:@"淘宝价：¥210" textColor:[UIColor colorWithHexString:TZ_GRAY alpha:1.0] textAlignment:NSTextAlignmentLeft andFont:kFont(11)];
        [self addSubview:self.tbPriceLabel];
        [self.tbPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.couponPriceLabel.mas_bottom).offset(8);
            make.centerX.equalTo(self);
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
