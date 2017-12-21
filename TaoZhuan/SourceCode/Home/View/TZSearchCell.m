//
//  TZSearchCell.m
//  ZhaoQuanWang
//
//  Created by 彭佳伟 on 2017/11/2.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "TZSearchCell.h"

@implementation TZSearchCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.picImageView = [MYBaseView imageViewWithFrame:CGRectZero andImage:nil];
        [self.contentView addSubview:self.picImageView];
        [self.picImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(15);
            make.centerY.equalTo(self.contentView);
            make.width.height.mas_equalTo(110);
        }];
        self.picImageView.layer.cornerRadius = 8;
        self.picImageView.clipsToBounds = YES;
        self.picImageView.backgroundColor = [UIColor colorWithHexString:TZ_GRAY alpha:1.0];
        
        self.nameLabel = [MYBaseView labelWithFrame:CGRectZero text:nil textColor:[UIColor colorWithHexString:@"#222222" alpha:1.0] textAlignment:NSTextAlignmentLeft andFont:kFont(13)];
        [self.contentView addSubview:self.nameLabel];
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.picImageView.mas_right).offset(15);
            make.top.equalTo(self.picImageView).offset(2);
            make.right.equalTo(self.contentView).offset(-15);
        }];
        self.nameLabel.numberOfLines = 2;
        
        self.originPrice = [MYBaseView labelWithFrame:CGRectZero text:nil textColor:[UIColor colorWithHexString:TZ_GRAY alpha:1.0] textAlignment:NSTextAlignmentLeft andFont:kFont(11)];
        [self.contentView addSubview:self.originPrice];
        [self.originPrice mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.picImageView.mas_right).offset(15);
            make.top.equalTo(self.picImageView).offset(42);
        }];
        
        self.saleLabel = [MYBaseView labelWithFrame:CGRectZero text:nil textColor:[UIColor colorWithHexString:TZ_GRAY alpha:1.0] textAlignment:NSTextAlignmentRight andFont:kFont(11)];
        [self.contentView addSubview:self.saleLabel];
        [self.saleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.originPrice);
            make.right.equalTo(self.contentView).offset(-15);
        }];
        
        self.priceLabel = [MYBaseView labelWithFrame:CGRectZero text:nil textColor:[UIColor colorWithHexString:TZ_Main_Color alpha:1.0] textAlignment:NSTextAlignmentRight andFont:kFont(11)];
        [self.contentView addSubview:self.priceLabel];
        [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.picImageView.mas_right).offset(15);
            make.top.equalTo(self.originPrice.mas_bottom).offset(4);
        }];
        
        self.leftCouponImg = [MYBaseView imageViewWithFrame:CGRectZero andImage:[UIImage imageNamed:@"领券省左"]];
        [self.contentView addSubview:self.leftCouponImg];
        [self.leftCouponImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.picImageView.mas_right).offset(15);
            make.bottom.equalTo(self.picImageView.mas_bottom).offset(-2);
            make.height.mas_equalTo(21);
            make.width.mas_equalTo(36);
        }];
        
        UILabel *leftCouponLabel = [MYBaseView labelWithFrame:CGRectZero text:@"领券省" textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter andFont:kFont(10)];
        [self.leftCouponImg addSubview:leftCouponLabel];
        [leftCouponLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.leftCouponImg);
        }];
        
        self.rightCouponImg = [MYBaseView imageViewWithFrame:CGRectZero andImage:[UIImage imageNamed:@"领券省右"]];
        [self.contentView addSubview:self.rightCouponImg];
        [self.rightCouponImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.leftCouponImg.mas_right);
            make.centerY.equalTo(self.leftCouponImg);
            make.height.mas_equalTo(21);
            make.width.mas_equalTo(42);
        }];
        
        self.couponPrice = [MYBaseView labelWithFrame:CGRectZero text:nil textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter andFont:kFont(13)];
        [self.rightCouponImg addSubview:self.couponPrice];
        [self.couponPrice mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.rightCouponImg);
        }];
        
        self.integralLabel = [MYBaseView labelWithFrame:CGRectZero text:@"" textColor:[UIColor colorWithHexString:@"#222222" alpha:1.0] textAlignment:NSTextAlignmentRight andFont:kFont(11)];
        [self.contentView addSubview:self.integralLabel];
        [self.integralLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-15);
            make.centerY.equalTo(self.leftCouponImg);
        }];
    }
    return self;
}

- (void)setCellInfoWithDWJModel:(TZSearchProductModel *)model{
    [self.picImageView sd_setImageWithURL:[NSURL URLWithString:model.pdtpic] placeholderImage:[UIImage imageNamed:@"商品加载图片"]];
    self.nameLabel.text = model.pdttitle;
    self.couponPrice.text = [NSString stringWithFormat:@"%d元",model.cpnprice];
    self.originPrice.text = [NSString stringWithFormat:@"淘宝价 ¥%@",model.pdtprice];
    self.saleLabel.text = [NSString stringWithFormat:@"销量 %@",model.pdtsell];
    NSString *finalPrice = [NSString stringWithFormat:@"券后价¥%@",model.pdtbuy];
    self.priceLabel.attributedText = [NSString stringWithString:finalPrice Range:NSMakeRange(4, finalPrice.length-4) color:nil font:kFont(18)];
    self.couponPrice.text = [NSString stringWithFormat:@"%d元",model.cpnprice];
    /*
    CGFloat bonus = [model.pdtbuy floatValue]/100*model.cmsrate;//商品佣金
    NSInteger hf = 0;//话费
    if (bonus < 3) {
        hf = 0;
    }
    if (bonus>= 3 && bonus < 6) {
        hf = 1;
    }
    if (bonus>= 6 && bonus < 15) {
        hf = 2;
    }
    if (bonus>= 15 && bonus < 30) {
        hf = 5;
    }
    if (bonus>= 30 && bonus < 60) {
        hf = 10;
    }
    if (bonus>= 60 && bonus < 90) {
        hf = 20;
    }
    if (bonus>= 90 && bonus < 150) {
        hf = 30;
    }
    if (bonus>= 150 && bonus < 300) {
        hf = 50;
    }
    if (bonus>= 300 && bonus < 900) {
        hf = 100;
    }
    if (bonus>= 900) {
        hf = 300;
    }
    if ([model.pdtbuy floatValue] < 1) {
        self.integralLabel.text = [NSString stringWithFormat:@"赠1积分或%ld元话费",hf];
    }else{
        self.integralLabel.text = [NSString stringWithFormat:@"赠%d积分或%ld元话费",(int)[model.pdtbuy floatValue],hf];
    }
    */
}

- (void)setCellInfoWithTBModel:(TZTaoBaoProductModel *)model{
    [self.picImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http:%@",model.pictUrl]] placeholderImage:[UIImage imageNamed:@"商品加载图片"]];
    self.nameLabel.text = [ZMUtils filterHTML:model.title];
    self.couponPrice.text = [NSString stringWithFormat:@"%ld元",(long)model.couponAmount];
    self.saleLabel.text = [NSString stringWithFormat:@"销量 %@",model.totalNum];
    self.originPrice.text = [NSString stringWithFormat:@"原价 ¥%.2f",model.couponAmount + model.zkPrice];
    NSString *finalPrice = [NSString stringWithFormat:@"销售价 ¥%.2f",model.zkPrice];
    self.priceLabel.attributedText = [NSString stringWithString:finalPrice Range:NSMakeRange(4, finalPrice.length-4) color:nil font:kFont(18)];
    /*
    CGFloat bonus = model.zkPrice/100*model.tkRate;//商品佣金
    NSLog(@"%f",model.tkRate);
    NSInteger hf = 0;//话费
    if (bonus < 3) {
        hf = 0;
    }
    if (bonus>= 3 && bonus < 6) {
        hf = 1;
    }
    if (bonus>= 6 && bonus < 15) {
        hf = 2;
    }
    if (bonus>= 15 && bonus < 30) {
        hf = 5;
    }
    if (bonus>= 30 && bonus < 60) {
        hf = 10;
    }
    if (bonus>= 60 && bonus < 90) {
        hf = 20;
    }
    if (bonus>= 90 && bonus < 150) {
        hf = 30;
    }
    if (bonus>= 150 && bonus < 300) {
        hf = 50;
    }
    if (bonus>= 300 && bonus < 900) {
        hf = 100;
    }
    if (bonus>= 900) {
        hf = 300;
    }
    if (model.zkPrice < 1) {
        self.integralLabel.text =  [NSString stringWithFormat:@"赠1积分或%ld元话费",hf];
    }else{
        self.integralLabel.text = [NSString stringWithFormat:@"赠%d积分或%ld元话费",(int)model.zkPrice,hf];
    }
    */
}

- (void)setCellInfoWithServiceModel:(TZServiceGoodsModel *)model{
    [self.picImageView sd_setImageWithURL:[NSURL URLWithString:model.imageUrl] placeholderImage:[UIImage imageNamed:@"商品加载图片"]];
    self.nameLabel.text = model.title;
    self.couponPrice.text = [NSString stringWithFormat:@"%d元",(int)model.couponPrice];
    self.originPrice.text = [NSString stringWithFormat:@"淘宝价 ¥%.2f",model.price];
    self.saleLabel.text = [NSString stringWithFormat:@"销量 %ld",(long)model.sales];
    NSString *finalPrice = [NSString stringWithFormat:@"券后 ¥%.2f",model.price - model.couponPrice];
    self.priceLabel.attributedText = [NSString stringWithString:finalPrice Range:NSMakeRange(4, finalPrice.length-4) color:nil font:kFont(18)];
    /*
    if (([model.oriPrice floatValue] - [model.couponPrice floatValue])  < 1) {
        self.integralLabel.text = @"购买后可兑换1积分";
    }else{
        self.integralLabel.text = [NSString stringWithFormat:@"购买后可兑换%d积分",(int)([model.oriPrice floatValue] - [model.couponPrice floatValue]) ];
    }
    */
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
