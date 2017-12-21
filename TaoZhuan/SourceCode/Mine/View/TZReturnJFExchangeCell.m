//
//  TZReturnJFExchangeCell.m
//  ZhaoQuanWang
//
//  Created by 彭佳伟 on 2017/11/21.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "TZReturnJFExchangeCell.h"

@implementation TZReturnJFExchangeCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        self.picImageView = [MYBaseView imageViewWithFrame:CGRectZero andImage:nil];
        [self.contentView addSubview:self.picImageView];
        [self.picImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.contentView);
            make.top.equalTo(self.contentView).offset(30);
            make.width.mas_equalTo(126*kScale);
            make.height.mas_equalTo(123*kScale);
        }];
        self.picImageView.backgroundColor = [UIColor colorWithHexString:TZ_TableView_Color alpha:1.0];
        
        self.lineImageView = [MYBaseView imageViewWithFrame:CGRectZero andImage:[UIImage imageNamed:@""]];
        [self.contentView addSubview:self.lineImageView];
        [self.lineImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(15);
            make.top.equalTo(self.picImageView.mas_bottom).offset(23);
            make.right.equalTo(self.contentView).offset(-5);
            make.height.mas_equalTo(1);
        }];
        self.lineImageView.backgroundColor = [UIColor colorWithHexString:TZ_TableView_Color alpha:1.0];
        
        self.nameLabel = [MYBaseView labelWithFrame:CGRectZero text:@"全网话费50元满防了打瞌睡美国可能" textColor:[UIColor colorWithHexString:TZ_BLACK alpha:1.0] textAlignment:NSTextAlignmentLeft andFont:kFont(13)];
        [self.contentView addSubview:self.nameLabel];
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(15);
            make.centerX.equalTo(self.contentView);
            make.top.equalTo(self.lineImageView.mas_bottom).offset(10);
        }];
        self.nameLabel.numberOfLines = 2;
        
        /*
        self.stockLabel = [MYBaseView labelWithFrame:CGRectZero text:@"仅剩192件" textColor:[UIColor colorWithHexString:TZ_LIGHT_BLACK alpha:1.0] textAlignment:NSTextAlignmentLeft andFont:kFont(11)];
        [self.contentView addSubview:self.stockLabel];
        [self.stockLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(15);
            make.top.equalTo(self.nameLabel.mas_bottom).offset(9);
        }];
        
        self.garyView = [MYBaseView viewWithFrame:CGRectZero backgroundColor:[UIColor colorWithHexString:TZ_GRAY alpha:1.0]];
        [self.contentView addSubview:self.garyView];
        [self.garyView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(75);
            make.centerY.equalTo(self.stockLabel);
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(4);
        }];
        self.garyView.layer.cornerRadius = 4;
        self.garyView.clipsToBounds = YES;
        
        self.redView = [MYBaseView viewWithFrame:CGRectZero backgroundColor:[UIColor colorWithHexString:@"#ff777d" alpha:1.0]];
        [self.contentView addSubview:self.redView];
        [self.redView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(100);
            make.centerY.equalTo(self.stockLabel);
            make.width.mas_equalTo(60);
            make.height.mas_equalTo(4);
        }];
        self.redView.layer.cornerRadius = 4;
        self.redView.clipsToBounds = YES;
         */
        
        self.jfLabel = [MYBaseView labelWithFrame:CGRectZero text:@"210 积分" textColor:[UIColor colorWithHexString:@"#ff777d" alpha:1.0] textAlignment:NSTextAlignmentLeft andFont:kFont(14)];
        [self.contentView addSubview:self.jfLabel];
        [self.jfLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(15);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-5);
        }];
        self.jfLabel.attributedText = [NSString stringWithString:self.jfLabel.text Range:NSMakeRange(self.jfLabel.text.length-2, 2) color:nil font:kFont(11)];
        
        self.priceLabel = [MYBaseView labelWithFrame:CGRectZero text:@"¥49.0" textColor:[UIColor colorWithHexString:TZ_GRAY alpha:1.0] textAlignment:NSTextAlignmentLeft andFont:kFont(11)];
        [self.contentView addSubview:self.priceLabel];
        [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.jfLabel.mas_right).offset(10);
            make.centerY.equalTo(self.jfLabel);
        }];
        NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:self.priceLabel.text attributes:@{NSStrikethroughStyleAttributeName : @(NSUnderlineStyleSingle),NSStrikethroughColorAttributeName :[UIColor colorWithHexString:TZ_GRAY alpha:1.0],NSBaselineOffsetAttributeName:@(0)}];
        self.priceLabel.attributedText = attributedString;
    }
    return self;
}

- (void)setCellInfoWithModel:(TZJFProductModel *)model{
    [self.picImageView sd_setImageWithURL:[NSURL URLWithString:model.imgUrl] placeholderImage:[UIImage imageNamed:@"商品加载图片"]];
    self.nameLabel.text = model.title;
    NSString *jf = [NSString stringWithFormat:@"%d 积分",(int)model.integral];
    self.jfLabel.attributedText = [NSString stringWithString:jf Range:NSMakeRange(jf.length-2, 2) color:nil font:kFont(11)];
    NSString *price = [NSString stringWithFormat:@"¥%.2f",[model.marketPrice floatValue]];
    self.priceLabel.attributedText = [NSString addThroughLineWithString:price Color:[UIColor colorWithHexString:TZ_GRAY alpha:1.0]];
}

@end
