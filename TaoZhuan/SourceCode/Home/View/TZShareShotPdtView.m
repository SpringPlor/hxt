//
//  TZShareShotPdtView.m
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/12/8.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "TZShareShotPdtView.h"
#import "ZMImageTool.h"

@implementation TZShareShotPdtView

- (instancetype)initWithFrame:(CGRect)frame withModel:(id )model{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.pdtImageView = [MYBaseView imageViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH) andImage:nil];
        [self addSubview:self.pdtImageView];
        
        self.QRCodeBgView = [MYBaseView imageViewWithFrame:CGRectZero andImage:[UIImage imageNamed:@"二维码框"]];
        [self addSubview:self.QRCodeBgView];
        [self.QRCodeBgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-15);
            make.top.equalTo(self.pdtImageView.mas_bottom).offset(15);
            make.width.height.mas_equalTo(120*kScale);
        }];
        
        UILabel *noticeLabel = [MYBaseView labelWithFrame:CGRectZero text:@"长按识别二维码" textColor:[UIColor colorWithHexString:@"#e1483f" alpha:1.0] textAlignment:NSTextAlignmentCenter andFont:kFont(10)];
        [self addSubview:noticeLabel];
        [noticeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.QRCodeBgView);
            make.centerY.equalTo(self.QRCodeBgView.mas_bottom);
        }];
        
        self.QRCodeImageView = [MYBaseView imageViewWithFrame:CGRectZero andImage:nil];
        [self.QRCodeBgView addSubview:self.QRCodeImageView];
        [self.QRCodeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.QRCodeBgView);
            make.width.height.mas_equalTo(110*kScale);
        }];
        
        self.nameLabel = [MYBaseView labelWithFrame:CGRectZero text:nil textColor:[UIColor colorWithHexString:TZ_BLACK alpha:1.0] textAlignment:NSTextAlignmentLeft andFont:kFont(15)];
        [self addSubview:self.nameLabel];
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(15);
            make.top.equalTo(self.pdtImageView.mas_bottom).offset(15);
            make.right.equalTo(self.QRCodeImageView.mas_left).offset(-15);
        }];
        self.nameLabel.numberOfLines = 0;
        
        self.couponLeft = [MYBaseView imageViewWithFrame:CGRectZero andImage:[UIImage imageNamed:@"quanleft"]];
        [self addSubview:self.couponLeft];
        [self.couponLeft mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.nameLabel);
            make.bottom.equalTo(self.QRCodeBgView.mas_bottom);
            make.width.mas_equalTo(15);
            make.height.mas_equalTo(15);
        }];
        
        self.couponRight = [MYBaseView imageViewWithFrame:CGRectZero andImage:[UIImage imageNamed:@"quanright"]];
        [self addSubview:self.couponRight];
        [self.couponRight mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.couponLeft.mas_right);
            make.centerY.equalTo(self.couponLeft);
            make.width.mas_equalTo(39);
            make.height.mas_equalTo(15);
        }];
        
        self.couponPriceLabel = [MYBaseView labelWithFrame:CGRectZero text:nil textColor:[UIColor colorWithHexString:@"#f33535" alpha:1.0] textAlignment:NSTextAlignmentCenter andFont:kFont(11)];
        [self.couponRight addSubview:self.couponPriceLabel];
        [self.couponPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.couponRight);
        }];
        
        self.finalPriceLabel = [MYBaseView labelWithFrame:CGRectZero text:@"" textColor:[UIColor colorWithHexString:@"#f33535" alpha:1.0] textAlignment:NSTextAlignmentLeft andFont:kFont(17)];
        [self addSubview:self.finalPriceLabel];
        [self.finalPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.couponLeft);
            make.left.equalTo(self.couponRight.mas_right).offset(10*kScale);
        }];
        
        self.tbPriceLabel = [MYBaseView labelWithFrame:CGRectZero text:nil textColor:[UIColor colorWithHexString:TZ_GRAY alpha:1.0] textAlignment:NSTextAlignmentLeft andFont:kFont(13)];
        [self addSubview:self.tbPriceLabel];
        [self.tbPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.nameLabel);
            make.bottom.equalTo(self.couponLeft.mas_top).offset(-10);
        }];
        
        if ([model isKindOfClass:[TZSearchProductModel class]]) {
            TZSearchProductModel *dwjModel = model;
            [self.pdtImageView sd_setImageWithURL:[NSURL URLWithString:dwjModel.pdtpic] placeholderImage:[UIImage imageNamed:@"商品加载图片"]];
            
            NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@" %@",dwjModel.pdttitle]];
            NSTextAttachment *attch = [[NSTextAttachment alloc] init];
            if ([dwjModel.shoptmall intValue] == 1) {
                attch.image = [UIImage imageNamed:@"天猫"];
            }else{
                attch.image = [UIImage imageNamed:@"淘宝"];
            }
            attch.bounds = CGRectMake(0, -2, 14, 14);
            NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attch];
            [attri insertAttributedString:string atIndex:0];
            self.nameLabel.attributedText = attri;
            
            self.couponPriceLabel.text = [NSString stringWithFormat:@"%d元",dwjModel.cpnprice];
            
            self.finalPriceLabel.text = [NSString stringWithFormat:@"券后价:¥%.2f",[dwjModel.pdtbuy floatValue]];
            self.finalPriceLabel.attributedText = [NSString stringWithString:self.finalPriceLabel.text Range:NSMakeRange(0, 5) color:nil font:kFont(13)];
            
            self.tbPriceLabel.text = [NSString stringWithFormat:@"淘宝价 %.2f",[dwjModel.pdtprice floatValue]];
            self.tbPriceLabel.attributedText = [NSString addThroughLineWithString:self.tbPriceLabel.text Color:[UIColor colorWithHexString:TZ_GRAY alpha:1.0]];
        }
        if ([model isKindOfClass:[TZTaoBaoProductModel class]]) {
            TZTaoBaoProductModel *tbModel = model;
            [self.pdtImageView sd_setImageWithURL:[NSURL URLWithString:tbModel.pictUrl] placeholderImage:[UIImage imageNamed:@"商品加载图片"]];
            
            NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@" %@",[ZMUtils filterHTML:tbModel.title]]];
            NSTextAttachment *attch = [[NSTextAttachment alloc] init];
            if ([tbModel.userType intValue] == 1) {
                attch.image = [UIImage imageNamed:@"天猫"];
            }else{
                attch.image = [UIImage imageNamed:@"淘宝"];
            }
            attch.bounds = CGRectMake(0, -2, 14, 14);
            NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attch];
            [attri insertAttributedString:string atIndex:0];
            self.nameLabel.attributedText = attri;
            
            self.couponPriceLabel.text = [NSString stringWithFormat:@"%ld元",(long)tbModel.couponAmount];
            
            self.finalPriceLabel.text = [NSString stringWithFormat:@"券后价:¥%.2f",tbModel.zkPrice];
            self.finalPriceLabel.attributedText = [NSString stringWithString:self.finalPriceLabel.text Range:NSMakeRange(0, 5) color:nil font:kFont(13)];
            
            self.tbPriceLabel.text = [NSString stringWithFormat:@"淘宝价 %.2f",tbModel.zkPrice + tbModel.couponAmount];
            self.tbPriceLabel.attributedText = [NSString addThroughLineWithString:self.tbPriceLabel.text Color:[UIColor colorWithHexString:TZ_GRAY alpha:1.0]];
        }
        
        if ([model isKindOfClass:[TZServiceGoodsModel class]]) {
            TZServiceGoodsModel *serviceModel = model;
            [self.pdtImageView sd_setImageWithURL:[NSURL URLWithString:serviceModel.imageUrl] placeholderImage:[UIImage imageNamed:@"商品加载图片"]];
            
            NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@" %@",serviceModel.title]];
            NSTextAttachment *attch = [[NSTextAttachment alloc] init];
            if (serviceModel.isTmall) {
                attch.image = [UIImage imageNamed:@"天猫"];
            }else{
                attch.image = [UIImage imageNamed:@"淘宝"];
            }
            attch.bounds = CGRectMake(0, -2, 14, 14);
            NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attch];
            [attri insertAttributedString:string atIndex:0];
            self.nameLabel.attributedText = attri;
            
            self.couponPriceLabel.text = [NSString stringWithFormat:@"%d元",(int)serviceModel.couponPrice];
            
            self.finalPriceLabel.text = [NSString stringWithFormat:@"券后价:¥%.2f",serviceModel.price - serviceModel.couponPrice];
            self.finalPriceLabel.attributedText = [NSString stringWithString:self.finalPriceLabel.text Range:NSMakeRange(0, 5) color:nil font:kFont(13)];
            
            self.tbPriceLabel.text = [NSString stringWithFormat:@"淘宝价 %.2f",serviceModel.price];
            self.tbPriceLabel.attributedText = [NSString addThroughLineWithString:self.tbPriceLabel.text Color:[UIColor colorWithHexString:TZ_GRAY alpha:1.0]];
        }
        
        [RACObserve(self, shareUrl) subscribeNext:^(NSString *shareUrl) {
            self.QRCodeImageView.image = [ZMImageTool drawQRCodeImageWithURL:shareUrl size:110*kScale];
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
