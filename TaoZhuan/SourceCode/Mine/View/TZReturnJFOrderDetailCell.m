//
//  TZReturnJFOrderDetailCell.m
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/10/14.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "TZReturnJFOrderDetailCell.h"

@implementation TZReturnJFOrderDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.picImageView = [MYBaseView imageViewWithFrame:CGRectZero andImage:[UIImage imageNamed:@"orderdefaulttu"]];
        [self.contentView addSubview:self.picImageView];
        [self.picImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).offset(15);
            make.left.equalTo(self.contentView).offset(15);
            make.width.height.mas_equalTo(105);
        }];
        self.picImageView.backgroundColor = [UIColor orangeColor];
        
        self.nameLabel = [MYBaseView labelWithFrame:CGRectZero text:@"2017秋季韩国ulzzang原宿风BF宽学生韩版薄款百搭棒球服外套女" textColor:[UIColor colorWithHexString:TZ_BLACK alpha:1.0] textAlignment:NSTextAlignmentLeft andFont:kFont(13)];
        [self.contentView addSubview:self.nameLabel];
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.picImageView.mas_right).offset(20);
            make.top.equalTo(self.picImageView);
            make.right.equalTo(self.contentView).offset(-15);
        }];
        self.nameLabel.numberOfLines = 2;
        
        self.couponPriceLabel = [MYBaseView labelWithFrame:CGRectZero text:@"券后：¥144" textColor:[UIColor colorWithHexString:TZ_GRAY alpha:1.0] textAlignment:NSTextAlignmentLeft andFont:kFont(11)];
        [self.contentView addSubview:self.couponPriceLabel];
        [self.couponPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.nameLabel);
            make.top.equalTo(self.nameLabel.mas_bottom).offset(8);
        }];
        
        
//        self.phoneLabel = [MYBaseView labelWithFrame:CGRectZero text:@"12345678910" textColor:[UIColor colorWithHexString:TZ_GRAY alpha:1.0] textAlignment:NSTextAlignmentLeft andFont:kFont(11)];
//        [self.contentView addSubview:self.phoneLabel];
//        [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.right.equalTo(self.nameLabel);
//            make.centerY.equalTo(self.couponPriceLabel);
//        }];
//        
//        self.headImageView = [MYBaseView imageViewWithFrame:CGRectZero andImage:[UIImage imageNamed:@"taoyou1"]];
//        [self.contentView addSubview:self.headImageView];
//        [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.right.equalTo(self.phoneLabel.mas_left).offset(-6);
//            make.centerY.equalTo(self.couponPriceLabel);
//            make.width.height.mas_equalTo(13);
//        }];
        
        self.timeLabel = [MYBaseView labelWithFrame:CGRectZero text:@"交易时间 2017-10-9" textColor:[UIColor colorWithHexString:TZ_GRAY alpha:1.0] textAlignment:NSTextAlignmentLeft andFont:kFont(13)];
        [self.contentView addSubview:self.timeLabel];
        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.nameLabel);
            make.centerY.equalTo(self.picImageView.mas_centerY).offset(15);
        }];
        
        UILabel *xhjfLabel = [MYBaseView labelWithFrame:CGRectZero text:@"给我返余额" textColor:[UIColor colorWithHexString:TZ_GRAY alpha:1.0] textAlignment:NSTextAlignmentLeft andFont:kFont(13)];
        [self.contentView addSubview:xhjfLabel];
        [xhjfLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.nameLabel);
            make.bottom.equalTo(self.picImageView.mas_bottom);
        }];
        
        self.jfIcon = [MYBaseView imageViewWithFrame:CGRectZero andImage:[UIImage imageNamed:@"fanyue"]];
        [self.contentView addSubview:self.jfIcon];
        [self.jfIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(xhjfLabel);
            make.left.equalTo(xhjfLabel.mas_right).offset(10);
            make.width.height.mas_equalTo(15);
        }];
        
        self.jfNumLabel = [MYBaseView labelWithFrame:CGRectZero text:@"+¥26" textColor:[UIColor colorWithHexString:TZ_BLACK alpha:1.0] textAlignment:NSTextAlignmentLeft andFont:kFont(16)];
        [self.contentView addSubview:self.jfNumLabel];
        [self.jfNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.jfIcon.mas_right).offset(10);
            make.centerY.equalTo(xhjfLabel);
        }];
        
    }
    return self;
}

- (void)setCellInfoWithModel:(TZBalanceOrderModel *)model{
    //[self.picImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http:%@",model.commodityImgUrl]]];
    self.timeLabel.text = [NSString stringWithFormat:@"交易时间 %@",[[ZMUtils timeWithTimeIntervalString:model.creationTime] substringWithRange:NSMakeRange(0, 10)]];
    self.jfNumLabel.text = [NSString stringWithFormat:@"+¥%@",model.returnMoney];
    self.couponPriceLabel.text = [NSString stringWithFormat:@"券后：¥%@",model.payAmount];
    self.phoneLabel.text = model.phoneNumber;
    self.nameLabel.text = [NSString stringWithFormat:@"订单号 %@",model.tbOrderId];
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
