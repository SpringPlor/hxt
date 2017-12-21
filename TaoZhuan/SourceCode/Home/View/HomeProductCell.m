//
//  HomeProductCell.m
//  ZhaoQuanWang
//
//  Created by 彭佳伟 on 2017/10/31.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "HomeProductCell.h"

@implementation HomeProductCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.picImageView = [MYBaseView imageViewWithFrame:CGRectZero andImage:nil];
        [self.contentView addSubview:self.picImageView];
        [self.picImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(self.contentView).offset(15);
            make.width.height.mas_equalTo(110);
        }];
        self.picImageView.layer.cornerRadius = 5;
        self.picImageView.clipsToBounds = YES;
        
        self.nameLabel = [MYBaseView labelWithFrame:CGRectZero text:@"" textColor:[UIColor colorWithHexString:@"#222222" alpha:1.0] textAlignment:NSTextAlignmentLeft andFont:kFont(13)];
        [self.contentView addSubview:self.nameLabel];
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.picImageView.mas_right).offset(15);
            make.right.equalTo(self.contentView).offset(-15);
            make.top.equalTo(self.picImageView);
        }];
        self.nameLabel.numberOfLines = 2;
        
        self.saleLabel = [MYBaseView labelWithFrame:CGRectZero text:@"" textColor:[UIColor colorWithHexString:@"#666666" alpha:1.0] textAlignment:NSTextAlignmentLeft andFont:kFont(11)];
        [self.contentView addSubview:self.saleLabel];
        [self.saleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.nameLabel);
            make.top.equalTo(self.picImageView).offset(36);
        }];
        
        UILabel *leftLabel = [MYBaseView labelWithFrame:CGRectZero text:@"券后" textColor:[UIColor colorWithHexString:TZ_LIGHT_RED alpha:1.0] textAlignment:NSTextAlignmentLeft andFont:kFont(12)];
        [self.contentView addSubview:leftLabel];
        [leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.picImageView.mas_right).offset(15);
            make.bottom.equalTo(self.picImageView.mas_bottom).offset(-3);
        }];
        
        self.priceLabel = [MYBaseView labelWithFrame:CGRectZero text:@"" textColor:[UIColor colorWithHexString:TZ_Main_Color alpha:1.0] textAlignment:NSTextAlignmentLeft andFont:kFont(18)];
        [self.contentView addSubview:self.priceLabel];
        [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(leftLabel.mas_right).offset(2);
            make.centerY.equalTo(leftLabel);
        }];
        
        self.rightCoupon = [MYBaseView imageViewWithFrame:CGRectZero andImage:[UIImage imageNamed:@"quanright"]];
        [self addSubview:self.rightCoupon];
        [self.rightCoupon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView.mas_right).offset(-15);
            make.centerY.equalTo(self.priceLabel);
            make.width.mas_equalTo(39);
            make.height.mas_equalTo(14);
        }];
        
        self.leftCoupon = [MYBaseView imageViewWithFrame:CGRectZero andImage:[UIImage imageNamed:@"quanleft"]];
        [self addSubview:self.leftCoupon];
        [self.leftCoupon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(14);
            make.height.mas_equalTo(14);
            make.centerY.equalTo(self.rightCoupon);
            make.right.equalTo(self.rightCoupon.mas_left);
        }];
        
        self.couponPriceLabel = [MYBaseView labelWithFrame:CGRectZero text:@"" textColor:[UIColor colorWithHexString:TZ_LIGHT_RED alpha:1.0] textAlignment:NSTextAlignmentCenter andFont:kFont(11)];
        [self.rightCoupon addSubview:self.couponPriceLabel];
        [self.couponPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.rightCoupon);
        }];
        
        self.originLabel = [MYBaseView labelWithFrame:CGRectZero text:@"原价：¥210" textColor:[UIColor colorWithHexString:TZ_GRAY alpha:1.0] textAlignment:NSTextAlignmentLeft andFont:kFont(11)];
        [self.contentView addSubview:self.originLabel];
        [self.originLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.nameLabel);
            make.bottom.equalTo(self.leftCoupon.mas_top).offset(-7);
        }];
    }
    return self;
}

- (void)setCellInfoWith:(TZSearchProductModel *)model{
    [self.picImageView sd_setImageWithURL:[NSURL URLWithString:model.pdtpic] placeholderImage:[UIImage imageNamed:@"商品加载图片"]];
    self.nameLabel.text = model.pdttitle;
    self.saleLabel.text = [NSString stringWithFormat:@"销量 %@件", [NSString stringWithFormat:@"%@",model.pdtsell]];
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"原价 %.2f",[model.pdtprice floatValue]] attributes:@{NSStrikethroughStyleAttributeName : @(NSUnderlineStyleSingle),NSStrikethroughColorAttributeName :[UIColor colorWithHexString:TZ_GRAY alpha:1.0],NSBaselineOffsetAttributeName:@(0)}];
    self.originLabel.attributedText = attributedString;
    self.priceLabel.text = [NSString stringWithFormat:@"¥%.2f",[model.pdtbuy floatValue]];
    self.couponPriceLabel.text = [NSString stringWithFormat:@"%d元",model.cpnprice];
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
