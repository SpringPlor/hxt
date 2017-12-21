//
//  TZTaoYouOrderCell.m
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/12/6.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "TZTaoYouOrderCell.h"

@implementation TZTaoYouOrderCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.orderNumLabel = [MYBaseView labelWithFrame:CGRectZero text:@"订单号：12345678910" textColor:[UIColor colorWithHexString:TZ_LIGHT_BLACK alpha:1.0] textAlignment:NSTextAlignmentLeft andFont:kFont(13*kScale)];
        [self.contentView addSubview:self.orderNumLabel];
        [self.orderNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.left.equalTo(self.contentView).offset(15*kScale);
            make.top.equalTo(self.contentView).offset(15*kScale);
        }];
        
        self.orderTimeLabel = [MYBaseView labelWithFrame:CGRectZero text:@"下单" textColor:[UIColor colorWithHexString:TZ_LIGHT_BLACK alpha:1.0] textAlignment:NSTextAlignmentLeft andFont:kFont(11*kScale)];
        [self.contentView addSubview:self.orderTimeLabel];
        [self.orderTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-15*kScale);
            make.centerY.equalTo(self.orderNumLabel);
        }];
        
        self.picImageView = [MYBaseView imageViewWithFrame:CGRectZero andImage:nil];
        [self.contentView addSubview:self.picImageView];
        [self.picImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.orderNumLabel);
            make.top.equalTo(self.orderNumLabel.mas_bottom).offset(15*kScale);
            make.width.height.mas_equalTo(75*kScale);
        }];
        self.picImageView.backgroundColor = [UIColor lightGrayColor];
        self.picImageView.layer.cornerRadius = 4.0f;
        
        self.nameLabel = [MYBaseView labelWithFrame:CGRectZero text:@"固定发快递福利购漏电了年历史买电脑客服解决方法" textColor:[UIColor colorWithHexString:TZ_BLACK alpha:1.0] textAlignment:NSTextAlignmentLeft andFont:kFont(15*kScale)];
        [self.contentView addSubview:self.nameLabel];
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.picImageView.mas_right).offset(10*kScale);
            make.top.equalTo(self.picImageView);
            make.right.equalTo(self.orderTimeLabel);
        }];
        self.nameLabel.numberOfLines = 0;
        [RACObserve(self, imgeModel) subscribeNext:^(TZOrderImageModel *model) {
            [self.picImageView sd_setImageWithURL:[NSURL URLWithString:model.mainImageUrl] placeholderImage:[UIImage imageNamed:@"淘友订单-商品下架"]];
        }];
    }
    return self;
}

- (void)setCellInfoWithModel:(TZTaoYouOrderModel *)model{
    self.orderNumLabel.text = [NSString stringWithFormat:@"订单号：%@",model.tbOrderId];
    [self.picImageView sd_setImageWithURL:[NSURL URLWithString:model.commodityImgUrl] placeholderImage:[UIImage imageNamed:@"淘友订单-商品下架"]];
    self.orderTimeLabel.text = [NSString stringWithFormat:@"%@下单",[[ZMUtils timeWithTimeIntervalString:model.orderCreateDate] substringWithRange:NSMakeRange(0, 10)]];
    self.nameLabel.text = model.commodityInfo;
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
