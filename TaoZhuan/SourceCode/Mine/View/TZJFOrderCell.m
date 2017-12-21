//
//  TZJFOrderCell.m
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/10/14.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "TZJFOrderCell.h"

@implementation TZJFOrderCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.picImageView = [MYBaseView imageViewWithFrame:CGRectZero andImage:nil];
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
        self.nameLabel.numberOfLines = 3;
        
        self.timeLabel = [MYBaseView labelWithFrame:CGRectZero text:@"兑换时间 2017-10-9" textColor:[UIColor colorWithHexString:TZ_GRAY alpha:1.0] textAlignment:NSTextAlignmentLeft andFont:kFont(13)];
        [self.contentView addSubview:self.timeLabel];
        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.nameLabel);
            make.centerY.equalTo(self.picImageView.mas_centerY).offset(15);
        }];
        
        UILabel *xhjfLabel = [MYBaseView labelWithFrame:CGRectZero text:@"消耗积分" textColor:[UIColor colorWithHexString:TZ_GRAY alpha:1.0] textAlignment:NSTextAlignmentLeft andFont:kFont(13)];
        [self.contentView addSubview:xhjfLabel];
        [xhjfLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.nameLabel);
            make.bottom.equalTo(self.picImageView.mas_bottom);
        }];
        
        self.jfIcon = [MYBaseView imageViewWithFrame:CGRectZero andImage:[UIImage imageNamed:@"jifen"]];
        [self.contentView addSubview:self.jfIcon];
        [self.jfIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(xhjfLabel);
            make.left.equalTo(xhjfLabel.mas_right).offset(10);
            make.width.height.mas_equalTo(15);
        }];
        
        self.jfNumLabel = [MYBaseView labelWithFrame:CGRectZero text:@"-2400" textColor:[UIColor colorWithHexString:TZ_BLACK alpha:1.0] textAlignment:NSTextAlignmentLeft andFont:kFont(16)];
        [self.contentView addSubview:self.jfNumLabel];
        [self.jfNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.jfIcon.mas_right).offset(10);
            make.centerY.equalTo(xhjfLabel);
        }];
    }
    return self;
}

- (void)setCellInfoWithModel:(TZJFOrderModel *)model{
    [self.picImageView sd_setImageWithURL:[NSURL URLWithString:model.imgUrl] placeholderImage:[UIImage imageNamed:@"商品加载图片"]];
    self.nameLabel.text = model.title;
    self.timeLabel.text = [NSString stringWithFormat:@"兑换时间 %@",[[ZMUtils timeWithTimeIntervalString:model.orderCreateDate] substringWithRange:NSMakeRange(0, 10)]];
    self.jfNumLabel.text = [NSString stringWithFormat:@"-%@",model.payAmount];
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
