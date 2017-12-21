//
//  TZDetailTitleCell.m
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/10/11.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "TZDetailTitleCell.h"

@implementation TZDetailTitleCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setSeperatorInsetToZero:SCREEN_WIDTH];
        
        self.scrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 360*kScale) imageURLStringsGroup:nil];
        [self.contentView addSubview:self.scrollView];
        
        self.nameLabel = [MYBaseView labelWithFrame:CGRectZero text:@"" textColor:[UIColor colorWithHexString:TZ_BLACK alpha:1.0] textAlignment:NSTextAlignmentLeft andFont:kFont(15)];
        [self.contentView addSubview:self.nameLabel];
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(15);
            make.centerX.equalTo(self.contentView);
            make.top.equalTo(self.scrollView.mas_bottom).offset(14);
        }];
        self.nameLabel.numberOfLines = 0;
        
        self.couponArrow = [MYBaseView imageViewWithFrame:CGRectZero andImage:[UIImage imageNamed:@"qhj"]];
        [self.contentView addSubview:self.couponArrow];
        [self.couponArrow mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.nameLabel.mas_bottom).offset(12);
            make.left.equalTo(self.nameLabel);
            make.width.mas_equalTo(49);
            make.height.mas_equalTo(15);
        }];
        
        self.priceLabel = [MYBaseView labelWithFrame:CGRectZero text:@"" textColor:[UIColor colorWithHexString:@"#f33535" alpha:1.0] textAlignment:NSTextAlignmentLeft andFont:kFont(18)];
        [self.contentView addSubview:self.priceLabel];
        [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.couponArrow);
            make.left.equalTo(self.couponArrow.mas_right).offset(6);
        }];
        
        self.tbPriceLabel = [MYBaseView labelWithFrame:CGRectZero text:@"淘宝价" textColor:[UIColor colorWithHexString:TZ_GRAY alpha:1.0] textAlignment:NSTextAlignmentLeft andFont:kFont(11)];
        [self.contentView addSubview:self.tbPriceLabel];
        [self.tbPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.couponArrow);
            make.left.equalTo(self.priceLabel.mas_right).offset(12);
        }];
        
        self.saleLabel = [MYBaseView labelWithFrame:CGRectZero text:@"笔成交" textColor:[UIColor colorWithHexString:TZ_GRAY alpha:1.0] textAlignment:NSTextAlignmentLeft andFont:kFont(11)];
        [self.contentView addSubview:self.saleLabel];
        [self.saleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.couponArrow);
            make.right.equalTo(self.contentView).offset(-15);
        }];
        
        self.couponLeftBgView = [MYBaseView imageViewWithFrame:CGRectZero andImage:[UIImage imageNamed:@"cpnquan"]];
        [self.contentView addSubview:self.couponLeftBgView];
        [self.couponLeftBgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.couponArrow.mas_bottom).offset(17);
            make.left.equalTo(self.nameLabel);
            make.width.mas_equalTo(238*kScale);
            make.height.mas_equalTo(70*kScale);
        }];
        self.couponRightBgView = [MYBaseView imageViewWithFrame:CGRectZero andImage:[UIImage imageNamed:@"lingqu"]];
        [self.contentView addSubview:self.couponRightBgView];
        [self.couponRightBgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.couponArrow.mas_bottom).offset(17);
            make.right.equalTo(self.contentView).offset(-15);
            make.width.mas_equalTo(107*kScale);
            make.height.mas_equalTo(70*kScale);
        }];
        self.couponRightBgView.userInteractionEnabled = YES;
        
        self.couponPirce = [MYBaseView labelWithFrame:CGRectZero text:@"优惠券" textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter andFont:kFont(13)];
        [self.couponLeftBgView addSubview:self.couponPirce];
        [self.couponPirce mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.couponLeftBgView);
            make.top.equalTo(self.couponLeftBgView).offset(15*kScale);
        }];
        
        self.timeLabel = [MYBaseView labelWithFrame:CGRectZero text:@"使用期限：" textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter andFont:kFont(11)];
        [self.couponLeftBgView addSubview:self.timeLabel];
        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.couponPirce);
            make.bottom.equalTo(self.couponLeftBgView.mas_bottom).offset(-18*kScale);
        }];
        
        UIButton *pickButton = [MYBaseView buttonWithFrame:CGRectZero buttonType:UIButtonTypeCustom title:@"立即领券" titleColor:[UIColor colorWithHexString:TZ_BLACK alpha:1.0] font:kFont(12)];
        [self.couponRightBgView addSubview:pickButton];
        [pickButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(self.couponRightBgView);
            make.center.equalTo(self.couponRightBgView);
        }];
        [pickButton addTarget:self action:@selector(buy:) forControlEvents:UIControlEventTouchUpInside];
        
        UIImageView *jfBgImageView = [MYBaseView imageViewWithFrame:CGRectZero andImage:[UIImage imageNamed:@"yongjbg"]];
        [self.contentView addSubview:jfBgImageView];
        [jfBgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(pickButton.mas_bottom).offset(15);
            make.centerX.equalTo(self.contentView);
            make.width.mas_equalTo(283*kScale);
            make.height.mas_equalTo(33*kScale);
        }];
        jfBgImageView.userInteractionEnabled = YES;
        [jfBgImageView addGestureRecognizer:[UITapGestureRecognizer nvm_gestureRecognizerWithActionBlock:^(id sender) {
            if (self.applyBlock) {
                self.applyBlock();
            }
        }]];
        
        self.jfLabel = [MYBaseView labelWithFrame:CGRectZero text:@"" textColor:[UIColor colorWithHexString:@"#ff5575" alpha:1.0] textAlignment:NSTextAlignmentCenter andFont:kFont(11*kScale)];
        [jfBgImageView addSubview:self.jfLabel];
        [self.jfLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(jfBgImageView);
//            make.left.equalTo(bellImageView.mas_right).offset(5*kScale);
//            make.centerY.equalTo(jfBgImageView);
        }];
        
        UIImageView *bellImageView = [MYBaseView imageViewWithFrame:CGRectZero andImage:[UIImage imageNamed:@"注意icon"]];
        [jfBgImageView addSubview:bellImageView];
        [bellImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.jfLabel.mas_left).offset(-5*kScale);
            make.centerY.equalTo(jfBgImageView);
            make.width.mas_equalTo(13);
            make.height.mas_equalTo(14);
        }];
        
        self.showAllButton = [MYBaseView buttonWithFrame:CGRectZero buttonType:UIButtonTypeCustom title:@"查看图文详情" titleColor:[UIColor colorWithHexString:TZ_GRAY alpha:1.0] font:kFont(12)];
        [self.contentView addSubview:self.showAllButton];
        [self.showAllButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.contentView);
            make.height.mas_equalTo(30);
            make.top.equalTo(jfBgImageView.mas_bottom).offset(5);
        }];
        self.showAllButton.userInteractionEnabled = YES;
        
        UIImageView *arrowImage = [MYBaseView imageViewWithFrame:CGRectZero andImage:[UIImage imageNamed:@"into"]];
        [self.contentView addSubview:arrowImage];
        [arrowImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.showAllButton.mas_right).offset(5);
            make.centerY.equalTo(self.showAllButton);
            make.width.mas_equalTo(5);
            make.height.mas_equalTo(9);
        }];
    }
    return self;
}

- (void)setCellInfoWithDWJModel:(TZSearchProductModel *)model{
    self.scrollView.imageURLStringsGroup = @[model.pdtpic];
    self.scrollView.autoScroll = NO;
    self.scrollView.showPageControl = NO;
    self.nameLabel.text = model.pdttitle;
    self.priceLabel.text = [NSString stringWithFormat:@"¥%@",model.pdtbuy];
    self.tbPriceLabel.text = [NSString stringWithFormat:@"淘宝价 ¥%@",model.pdtprice];
    self.saleLabel.text = [NSString stringWithFormat:@"%@笔成交",model.pdtsell];
    self.couponPirce.text = [NSString stringWithFormat:@"%d元优惠券",model.cpnprice];
    self.timeLabel.text = [NSString stringWithFormat:@"使用期限：%@ - %@", [model.cpnstart substringWithRange:NSMakeRange(0, 10)], [model.cpnend substringWithRange:NSMakeRange(0, 10)]];
    CGFloat bonus = [model.pdtbuy floatValue]/100*model.cmsrate;//商品佣金
    if ([MYSingleton shareInstonce].userInfoModel.agentInfo.id) {
        self.jfLabel.text = [NSString stringWithFormat:@"推广本商品即可获得¥%.2f元佣金",bonus];
    }else{
        self.jfLabel.text = @"申请成为合伙人，推广商品拿奖励";
    }
    
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@" %@",model.pdttitle]];
    NSTextAttachment *attch = [[NSTextAttachment alloc] init];
    if ([model.shoptmall intValue] == 1) {
        attch.image = [UIImage imageNamed:@"天猫"];
    }else{
        attch.image = [UIImage imageNamed:@"淘宝"];
    }
    attch.bounds = CGRectMake(0, -2, 14, 14);
    NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attch];
    [attri insertAttributedString:string atIndex:0];
    self.nameLabel.attributedText = attri;
}

- (void)setCellInfoWithServiceModel:(TZServiceGoodsModel *)model{
    self.scrollView.imageURLStringsGroup = @[model.imageUrl];
    self.scrollView.autoScroll = NO;
    self.scrollView.showPageControl = NO;
    self.nameLabel.text = model.title;
    self.priceLabel.text = [NSString stringWithFormat:@"¥%.2f",model.price - model.couponPrice];
    self.tbPriceLabel.text = [NSString stringWithFormat:@"淘宝价 ¥%.2f",model.price];
    self.saleLabel.text = [NSString stringWithFormat:@"%ld笔成交",(long)model.sales];
    self.couponPirce.text = [NSString stringWithFormat:@"%d元优惠券",(int)model.couponPrice];
    self.timeLabel.text = [NSString stringWithFormat:@"使用期限：%@ - %@", [[ZMUtils timeWithTimeIntervalString:model.couponStartTime] substringWithRange:NSMakeRange(0, 10)] ,[[ZMUtils timeWithTimeIntervalString:model.couponEndTime] substringWithRange:NSMakeRange(0, 10)]];
    if ([MYSingleton shareInstonce].userInfoModel.agentInfo.id) {
        self.jfLabel.text = [NSString stringWithFormat:@"推广本商品即可获得¥%.2f元佣金",model.commission];
    }else{
        self.jfLabel.text = @"申请成为合伙人，推广商品拿奖励";
    }
    
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@" %@",model.title]];
    NSTextAttachment *attch = [[NSTextAttachment alloc] init];
    if (model.isTmall) {
        attch.image = [UIImage imageNamed:@"天猫"];
    }else{
        attch.image = [UIImage imageNamed:@"淘宝"];
    }
    attch.bounds = CGRectMake(0, -2, 14, 14);
    NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attch];
    [attri insertAttributedString:string atIndex:0];
    self.nameLabel.attributedText = attri;

}

- (void)setCellInfoWithTBModel:(TZTaoBaoProductModel *)model{
    self.scrollView.imageURLStringsGroup = @[[NSString stringWithFormat:@"http:%@",model.pictUrl]];
    self.scrollView.autoScroll = NO;
    self.scrollView.showPageControl = NO;
    self.nameLabel.text = [ZMUtils filterHTML:model.title];
    self.couponPirce.text = [NSString stringWithFormat:@"%ld元优惠券",(long)model.couponAmount];
    self.priceLabel.text = [NSString stringWithFormat:@"%.2f",model.zkPrice];
    self.tbPriceLabel.text = [NSString stringWithFormat:@"淘宝价 ¥%.2f",model.zkPrice + model.couponAmount];
    self.saleLabel.text = [NSString stringWithFormat:@"%@笔成交",model.totalNum == nil ? @"0" : model.totalNum];
    if ([MYSingleton shareInstonce].userInfoModel.agentInfo.id) {
        self.jfLabel.text = [NSString stringWithFormat:@"推广本商品即可获得¥%.2f元佣金", model.zkPrice/100*model.tkRate];
    }else{
        self.jfLabel.text = @"申请成为合伙人，推广商品拿奖励";
    }
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@" %@",self.nameLabel.text]];
    NSTextAttachment *attch = [[NSTextAttachment alloc] init];
    if ([model.userType intValue] == 1) {
        attch.image = [UIImage imageNamed:@"天猫"];
    }else{
        attch.image = [UIImage imageNamed:@"淘宝"];
    }
    attch.bounds = CGRectMake(0, -2, 14, 14);
    NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attch];
    [attri insertAttributedString:string atIndex:0];
    self.nameLabel.attributedText = attri;

}

- (void)buy:(UIButton *)sender{
    if (self.buyBlock) {
        self.buyBlock();
    }
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
