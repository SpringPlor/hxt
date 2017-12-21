//
//  TZReturnJFOrderCell.m
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/10/14.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "TZReturnJFOrderCell.h"

@implementation TZReturnJFOrderCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.orderNumber = [MYBaseView labelWithFrame:CGRectZero text:@"淘宝网·订单号：12345678910" textColor:[UIColor colorWithHexString:TZ_GRAY alpha:1.0] textAlignment:NSTextAlignmentLeft andFont:kFont(13)];
        [self.contentView addSubview:self.orderNumber];
        [self.orderNumber mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(15);
            make.top.equalTo(self.contentView).offset(15);
        }];
        
        self.timeLabel = [MYBaseView labelWithFrame:CGRectZero text:nil textColor:[UIColor colorWithHexString:TZ_GRAY alpha:1.0] textAlignment:NSTextAlignmentLeft andFont:kFont(13)];
        [self.contentView addSubview:self.timeLabel];
        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-15);
            make.centerY.equalTo(self.orderNumber);
        }];

        self.picImageView = [MYBaseView imageViewWithFrame:CGRectZero andImage:nil];
        [self.contentView addSubview:self.picImageView];
        [self.picImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.orderNumber.mas_bottom).offset(15);
            make.left.equalTo(self.orderNumber);
            make.width.height.mas_equalTo(100);
        }];
        self.picImageView.backgroundColor = [UIColor lightGrayColor];
        
        self.nameLabel = [MYBaseView labelWithFrame:CGRectZero text:@"2017秋季韩国ulzzang原宿风BF宽学生韩版薄款百搭棒球服外套女" textColor:[UIColor colorWithHexString:TZ_BLACK alpha:1.0] textAlignment:NSTextAlignmentLeft andFont:kFont(13)];
        [self.contentView addSubview:self.nameLabel];
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.picImageView.mas_right).offset(20);
            make.top.equalTo(self.picImageView);
            make.right.equalTo(self.contentView).offset(-15);
        }];
        self.nameLabel.numberOfLines = 2;
        
        self.typeLabel = [MYBaseView labelWithFrame:CGRectZero text:@"哈伦 品牌商品 韩国秋款" textColor:[UIColor colorWithHexString:TZ_LIGHT_RED alpha:1.0] textAlignment:NSTextAlignmentLeft andFont:kFont(13)];
        [self.contentView addSubview:self.typeLabel];
        [self.typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.picImageView.mas_right).offset(20);
            make.centerY.equalTo(self.picImageView);
            make.right.equalTo(self.contentView).offset(-15);
        }];
        self.typeLabel.numberOfLines = 2;
        self.typeLabel.hidden = YES;
        
        self.orderStatusLabel = [MYBaseView labelWithFrame:CGRectZero text:@"即将到账" textColor:[UIColor colorWithHexString:TZ_LIGHT_RED alpha:1.0] textAlignment:NSTextAlignmentCenter andFont:kFont(13)];
        [self.contentView addSubview:self.orderStatusLabel];
        [self.orderStatusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.picImageView.mas_right).offset(20);
            make.bottom.equalTo(self.picImageView.mas_bottom);
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(24);
        }];
        self.orderStatusLabel.layer.cornerRadius = 12;
        self.orderStatusLabel.layer.borderColor = [UIColor colorWithHexString:TZ_LIGHT_RED alpha:1.0].CGColor;
        self.orderStatusLabel.layer.borderWidth = 0.5;
        
        
        self.jfLabel = [MYBaseView labelWithFrame:CGRectZero text:@"积分返还：149" textColor:[UIColor colorWithHexString:TZ_GRAY alpha:1.0] textAlignment:NSTextAlignmentRight andFont:kFont(11)];
        [self.contentView addSubview:self.jfLabel];
        [self.jfLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.picImageView.mas_bottom);
            make.right.equalTo(self.contentView).offset(-15);
        }];
        self.jfLabel.attributedText = [NSString stringWithString:self.jfLabel.text Range:NSMakeRange(5, self.jfLabel.text.length-5) color:[UIColor colorWithHexString:TZ_BLACK alpha:1.0] font:kFont(15)];
        
        [RACObserve(self, model) subscribeNext:^(TZOrderImageModel *model) {
            [self.picImageView sd_setImageWithURL:[NSURL URLWithString:model.mainImageUrl] placeholderImage:[UIImage imageNamed:@"积分订单-商品下架"]];
        }];
        
    }
    return self;
}

- (void)setCellInfoWithModel:(TZReturnJfOrderModel *)model{
    [self.picImageView sd_setImageWithURL:[NSURL URLWithString:model.commodityImgUrl] placeholderImage:[UIImage imageNamed:@"积分订单-商品下架"]];
    self.nameLabel.text = model.commodityInfo;
    self.orderNumber.text = [NSString stringWithFormat:@"淘宝网·订单号：%@",model.tbOrderId];
    self.timeLabel.text = [[ZMUtils timeWithTimeIntervalString:model.creationTime] substringWithRange:NSMakeRange(0, 10)];
    NSString *jf = [NSString stringWithFormat:@"积分返还：%ld",model.returnIntegral];
    self.jfLabel.attributedText = [NSString stringWithString:jf Range:NSMakeRange(5, jf.length-5) color:[UIColor colorWithHexString:TZ_BLACK alpha:1.0] font:kFont(15)];
    if ([model.status isEqualToString:@"订单付款"]) {
        self.orderStatusLabel.layer.borderColor = [UIColor colorWithHexString:TZ_LIGHT_RED alpha:1.0].CGColor;
        self.orderStatusLabel.textColor = [UIColor colorWithHexString:TZ_LIGHT_RED alpha:1.0];
        self.orderStatusLabel.text = @"即将到账";
    }
    if ([model.status isEqualToString:@"订单结算"]){
        self.orderStatusLabel.layer.borderColor = [UIColor colorWithHexString:@"#7ac017" alpha:1.0].CGColor;
        self.orderStatusLabel.textColor = [UIColor colorWithHexString:@"#7ac017" alpha:1.0];
        self.orderStatusLabel.text = @"已到账";
    }
    
    if ([model.status isEqualToString:@"订单成功"] || [model.status isEqualToString:@"订单失效"]){
        self.orderStatusLabel.layer.borderColor = [UIColor colorWithHexString:TZ_GRAY alpha:1.0].CGColor;
        self.orderStatusLabel.textColor = [UIColor colorWithHexString:TZ_GRAY alpha:1.0];
        self.orderStatusLabel.text = @"订单失效";
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
