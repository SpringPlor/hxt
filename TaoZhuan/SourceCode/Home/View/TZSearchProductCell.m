//
//  TZSearchProductCell.m
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/10/9.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "TZSearchProductCell.h"

@implementation TZSearchProductCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.picImageView = [MYBaseView imageViewWithFrame:CGRectZero andImage:nil];
        [self.contentView addSubview:self.picImageView];
        [self.picImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(self.contentView);
            make.width.height.mas_equalTo((SCREEN_WIDTH-5)/2);
        }];
        
        self.nameLabel = [MYBaseView labelWithFrame:CGRectZero text:nil textColor:[UIColor colorWithHexString:TZ_BLACK alpha:1.0] textAlignment:NSTextAlignmentLeft andFont:kFont(14)];
        [self.contentView addSubview:self.nameLabel];
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(5);
            make.top.equalTo(self.picImageView.mas_bottom).offset(5);
            make.centerX.equalTo(self.contentView);
        }];
        self.nameLabel.numberOfLines = 2;
        
        self.couponLeft = [MYBaseView imageViewWithFrame:CGRectZero andImage:[UIImage imageNamed:@"quanleft"]];
        [self addSubview:self.couponLeft];
        [self.couponLeft mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.nameLabel);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
            make.width.mas_equalTo(14);
            make.height.mas_equalTo(14);
        }];
        
        self.couponRight = [MYBaseView imageViewWithFrame:CGRectZero andImage:[UIImage imageNamed:@"quanright"]];
        [self addSubview:self.couponRight];
        [self.couponRight mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.couponLeft.mas_right);
            make.centerY.equalTo(self.couponLeft);
            make.width.mas_equalTo(39);
            make.height.mas_equalTo(14);
        }];
        
        self.couponPriceLabel = [MYBaseView labelWithFrame:CGRectZero text:nil textColor:[UIColor colorWithHexString:@"#F33535" alpha:1.0] textAlignment:NSTextAlignmentCenter andFont:kFont(11)];
        [self.couponRight addSubview:self.couponPriceLabel];
        [self.couponPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.couponRight);
        }];
        
        self.finalPriceLabel = [MYBaseView labelWithFrame:CGRectZero text:@"券后 ¥190" textColor:[UIColor colorWithHexString:@"#F33535" alpha:1.0] textAlignment:NSTextAlignmentLeft andFont:kFont(11)];
        [self.contentView addSubview:self.finalPriceLabel];
        [self.finalPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.couponLeft);
            make.right.equalTo(self.contentView).offset(-5);
        }];
        
        
        self.tbPriceLabel = [MYBaseView labelWithFrame:CGRectZero text:nil textColor:[UIColor colorWithHexString:TZ_GRAY alpha:1.0] textAlignment:NSTextAlignmentLeft andFont:kFont(11)];
        [self.contentView addSubview:self.tbPriceLabel];
        [self.tbPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.nameLabel);
            make.bottom.equalTo(self.couponLeft.mas_top).offset(-10);
        }];
        
        self.salesNum = [MYBaseView labelWithFrame:CGRectZero text:nil textColor:[UIColor colorWithHexString:TZ_GRAY alpha:1.0] textAlignment:NSTextAlignmentRight andFont:kFont(11)];
        [self.contentView addSubview:self.salesNum];
        [self.salesNum mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.nameLabel);
            make.centerY.equalTo(self.tbPriceLabel);
        }];
    }
    return self;
}

- (void)setCellInfoWithDWJModel:(TZSearchProductModel *)model{
    [self.picImageView sd_setImageWithURL:[NSURL URLWithString:model.pdtpic] placeholderImage:[UIImage imageNamed:@"商品加载图片"]];
    self.nameLabel.text = model.pdttitle;
    self.couponPriceLabel.text = [NSString stringWithFormat:@"%d元",model.cpnprice];
    self.tbPriceLabel.text = [NSString stringWithFormat:@"淘宝价 ¥%@",model.pdtprice];
    self.salesNum.text = [NSString stringWithFormat:@"销量 %@",model.pdtsell];
    NSString *finalPrice = [NSString stringWithFormat:@"券后 ¥%@",model.pdtbuy];
    self.finalPriceLabel.attributedText = [NSString stringWithString:finalPrice Range:NSMakeRange(4, finalPrice.length-4) color:nil font:kFont(15)];
    self.couponLeft.hidden = NO;
    self.couponRight.hidden = NO;
}

- (void)setCellInfoWithTBModel:(TZTaoBaoProductModel *)model{
    [self.picImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http:%@",model.pictUrl]] placeholderImage:[UIImage imageNamed:@"商品加载图片"]];
    self.nameLabel.text = [ZMUtils filterHTML:model.title];
//    CGFloat top = 25; // 顶端盖高度
//    CGFloat bottom = 25 ; // 底端盖高度
//    CGFloat left = 10; // 左端盖宽度
//    CGFloat right = 10; // 右端盖宽度
//    UIEdgeInsets insets = UIEdgeInsetsMake(top, left, bottom, right);
//    // 指定为拉伸模式，伸缩后重新赋值
//    image = [image resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
    if (model.couponAmount == 0) {
        self.couponLeft.hidden = YES;
        self.couponRight.hidden = YES;
    }else{
        self.couponLeft.hidden = YES;
        self.couponRight.hidden = YES;
        self.couponPriceLabel.text = [NSString stringWithFormat:@"%ld元",(long)model.couponAmount];
    }
    self.couponPriceLabel.text = [NSString stringWithFormat:@"%ld元",(long)model.couponAmount];
    self.salesNum.text = [NSString stringWithFormat:@"销量 %@",model.totalNum];
    self.tbPriceLabel.text = [NSString stringWithFormat:@"原价 ¥%.2f",model.couponAmount + model.zkPrice];
    NSString *finalPrice = [NSString stringWithFormat:@"销售价 ¥%.2f",model.zkPrice];
    self.finalPriceLabel.attributedText = [NSString stringWithString:finalPrice Range:NSMakeRange(4, finalPrice.length-4) color:nil font:kFont(15)];
}

- (void)setCellInfoWithServiceModel:(TZServiceGoodsModel *)model{
    [self.picImageView sd_setImageWithURL:[NSURL URLWithString:model.imageUrl] placeholderImage:[UIImage imageNamed:@"商品加载图片"]];
    self.nameLabel.text = model.title;
    self.couponPriceLabel.text = [NSString stringWithFormat:@"%d元",(int)model.couponPrice];
    self.tbPriceLabel.text = [NSString stringWithFormat:@"淘宝价 ¥%.2f",model.price];
    self.salesNum.text = [NSString stringWithFormat:@"销量 %ld",(long)model.sales];
    NSString *finalPrice = [NSString stringWithFormat:@"券后 ¥%.2f",model.price - model.couponPrice];
    self.finalPriceLabel.attributedText = [NSString stringWithString:finalPrice Range:NSMakeRange(4, finalPrice.length-4) color:nil font:kFont(15)];
    self.couponLeft.hidden = NO;
    self.couponRight.hidden = NO;
}

@end
