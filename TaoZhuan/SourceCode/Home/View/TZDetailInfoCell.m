//
//  TZDetailInfoCell.m
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/10/11.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "TZDetailInfoCell.h"

@implementation TZDetailInfoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setSeperatorInsetToZero:SCREEN_WIDTH];
        
        self.titleLabel = [MYBaseView labelWithFrame:CGRectZero text:@"返还小贴士" textColor:[UIColor colorWithHexString:TZ_BLACK alpha:1.0] textAlignment:NSTextAlignmentCenter andFont:kFont(16)];
        [self.contentView addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).offset(16);
            make.centerX.equalTo(self.contentView);
        }];
        
        UIImageView *leftImageView = [MYBaseView imageViewWithFrame:CGRectZero andImage:[UIImage imageNamed:@"lx"]];
        [self.contentView addSubview:leftImageView];
        [leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.titleLabel);
            make.right.equalTo(self.titleLabel.mas_left).offset(-17);
        }];
        
        UIImageView *rigthImageView = [MYBaseView imageViewWithFrame:CGRectZero andImage:[UIImage imageNamed:@"lx"]];
        [self.contentView addSubview:rigthImageView];
        [rigthImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.titleLabel);
            make.left.equalTo(self.titleLabel.mas_right).offset(17);
        }];
        
        self.label1 = [MYBaseView labelWithFrame:CGRectZero text:@"1.通过惠享淘购买淘宝/天猫商品，不仅拿优惠券，而且以实际支付金额按照比例返回积分，积分再次可兑换商品" textColor:[UIColor colorWithHexString:TZ_BLACK alpha:1.0] textAlignment:NSTextAlignmentLeft andFont:kFont(14)];
        [self.contentView addSubview:self.label1];
        [self.label1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLabel.mas_bottom).offset(30);
            make.left.equalTo(self.contentView).offset(15);
            make.centerX.equalTo(self.contentView);
        }];
        self.label1.numberOfLines = 0;
        
        self.label2 = [MYBaseView labelWithFrame:CGRectZero text:@"2.如果购买的商品，在返积分订单没有找到订单，则需要在订单补录将订单号补录进去，还会获得相应返还积分。" textColor:[UIColor colorWithHexString:TZ_BLACK alpha:1.0] textAlignment:NSTextAlignmentLeft andFont:kFont(14)];
        [self.contentView addSubview:self.label2];
        [self.label2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.label1.mas_bottom).offset(25);
            make.left.equalTo(self.contentView).offset(15);
            make.centerX.equalTo(self.contentView);
        }];
        self.label2.numberOfLines = 0;
        
        self.label3 = [MYBaseView labelWithFrame:CGRectZero text:@"3.邀请好友，用分享码注册app后，好友购买商品，我还可以获得系统返还余额进行提现。" textColor:[UIColor colorWithHexString:TZ_BLACK alpha:1.0] textAlignment:NSTextAlignmentLeft andFont:kFont(14)];
        [self.contentView addSubview:self.label3];
        [self.label3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.label2.mas_bottom).offset(25);
            make.left.equalTo(self.contentView).offset(15);
            make.centerX.equalTo(self.contentView);
        }];
        self.label3.numberOfLines = 0;
        
    }
    return self;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
