//
//  TZHomeRecommandCell.m
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/12/8.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "TZHomeRecommandCell.h"

@implementation TZHomeRecommandCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setSeperatorInsetToZero];
        self.pdtImageView = [MYBaseView imageViewWithFrame:CGRectZero andImage:[UIImage imageNamed:@""]];
        [self.contentView addSubview:self.pdtImageView];
        [self.pdtImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(10);
            make.centerY.equalTo(self.contentView);
            make.width.height.mas_equalTo(90);
        }];
        self.pdtImageView.backgroundColor = [UIColor colorWithHexString:TZ_GRAY alpha:1.0];
        self.pdtImageView.layer.cornerRadius = 10;
        
        self.nameLabel = [MYBaseView labelWithFrame:CGRectZero text:@"艾克斯臣秋冬套装白色毛衣+格子短裤英伦风经典风" textColor:[UIColor colorWithHexString:TZ_BLACK alpha:1.0] textAlignment:NSTextAlignmentLeft andFont:kFont(14)];
        [self.contentView addSubview:self.nameLabel];
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.pdtImageView.mas_right).offset(10);
            make.right.equalTo(self.contentView).offset(-10);
            make.top.equalTo(self.pdtImageView);
        }];
        self.nameLabel.numberOfLines = 2;
        
        self.couponButton = [MYBaseView buttonWithFrame:CGRectZero buttonType:UIButtonTypeCustom image:[UIImage imageNamed:@"用券立减"] selectImage:nil];
        [self.contentView addSubview:self.couponButton];
        [self.couponButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.nameLabel);
            make.bottom.equalTo(self.pdtImageView.mas_bottom);
            make.width.mas_equalTo(160);
            make.height.mas_equalTo(25);
        }];
        
        self.priceLabel = [MYBaseView labelWithFrame:CGRectZero text:@"淘宝价 ¥210" textColor:[UIColor colorWithHexString:@"#f44141" alpha:1.0] textAlignment:NSTextAlignmentLeft andFont:kFont(14)];
        [self.contentView addSubview:self.priceLabel];
        [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.pdtImageView.mas_right).offset(10);
            make.bottom.equalTo(self.couponButton.mas_top).offset(-10);
        }];
        self.nameLabel.numberOfLines = 2;
        
        self.noticeLabel = [MYBaseView labelWithFrame:CGRectZero text:nil textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter andFont:kFont(12)];
        [self.couponButton addSubview:self.noticeLabel];
        [self.noticeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.couponButton);
        }];
    }
    return self;
}

- (void)setCellInfoWithModel:(TZServiceGoodsModel *)model{
    [self.pdtImageView sd_setImageWithURL:[NSURL URLWithString:model.imageUrl] placeholderImage:[UIImage imageNamed:@"商品加载图片"]];
    self.nameLabel.text = model.title;
    self.priceLabel.text = [NSString stringWithFormat:@"淘宝价 ¥%.2f",model.price+model.couponPrice];
    self.noticeLabel.text = [NSString stringWithFormat:@"用券立减¥%d",(int)model.couponPrice];
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
