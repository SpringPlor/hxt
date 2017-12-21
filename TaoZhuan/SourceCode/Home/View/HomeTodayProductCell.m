//
//  HomeTodayProductCell.m
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/11/17.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "HomeTodayProductCell.h"

@implementation HomeTodayProductCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.iconImageView = [MYBaseView imageViewWithFrame:CGRectZero andImage:nil];
        [self.contentView addSubview:self.iconImageView];
        [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(self.contentView);
            make.width.height.mas_equalTo(115);
        }];
        
        self.priceLabel = [MYBaseView labelWithFrame:CGRectZero text:@"" textColor:[UIColor colorWithHexString:@"#F33535" alpha:1.0] textAlignment:NSTextAlignmentCenter andFont:kFont(14)];
        [self.contentView addSubview:self.priceLabel];
        [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.iconImageView);
            make.top.equalTo(self.iconImageView.mas_bottom).offset(10);
        }];
        
        self.couponLeft = [MYBaseView imageViewWithFrame:CGRectZero andImage:[UIImage imageNamed:@"quanleft"]];
        [self.contentView addSubview:self.couponLeft];
        [self.couponLeft mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.iconImageView.mas_centerX).offset(-20);
            make.top.equalTo(self.priceLabel.mas_bottom).offset(8);
            make.width.mas_equalTo(14);
            make.height.mas_equalTo(14);
        }];
        
        self.couponRight = [MYBaseView imageViewWithFrame:CGRectZero andImage:[UIImage imageNamed:@"quanright"]];
        [self.contentView addSubview:self.couponRight];
        [self.couponRight mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.couponLeft.mas_right);
            make.top.equalTo(self.priceLabel.mas_bottom).offset(8);
            make.width.mas_equalTo(39);
            make.height.mas_equalTo(14);
        }];
        
        self.couponPriceLabel = [MYBaseView labelWithFrame:CGRectZero text:@"" textColor:[UIColor colorWithHexString:@"#f33535" alpha:1.0] textAlignment:NSTextAlignmentLeft andFont:kFont(11)];
        [self.couponRight addSubview:self.couponPriceLabel];
        [self.couponPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.couponRight);
        }];
        
        self.tbPriceLabel = [MYBaseView labelWithFrame:CGRectZero text:@"" textColor:[UIColor colorWithHexString:TZ_GRAY alpha:1.0] textAlignment:NSTextAlignmentLeft andFont:kFont(11)];
        [self.contentView addSubview:self.tbPriceLabel];
        [self.tbPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.couponPriceLabel.mas_bottom).offset(8);
            make.centerX.equalTo(self);
        }];

    }
    return self;
}

- (void)setCellInfoWithModel:(TZServiceGoodsModel *)detailModel{
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:detailModel.imageUrl] placeholderImage:[UIImage imageNamed:@"商品加载图片"]];
    self.priceLabel.text = [NSString stringWithFormat:@"券后:%.2f",detailModel.price - detailModel.couponPrice];
    self.couponPriceLabel.text = [NSString stringWithFormat:@"%d元",(int)detailModel.couponPrice];
    self.tbPriceLabel.text = [NSString stringWithFormat:@"淘宝价:%.2f",detailModel.price];
}

@end
