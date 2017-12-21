//
//  TZDetailDescribeCell.m
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/10/11.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "TZDetailDescribeCell.h"

@implementation TZDetailDescribeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        /*self.titleLabel = [MYBaseView labelWithFrame:CGRectZero text:@"小编酷评" textColor:[UIColor colorWithHexString:TZ_BLACK alpha:1.0] textAlignment:NSTextAlignmentCenter andFont:kFont(16)];
        [self.contentView addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).offset(16);
            make.centerX.equalTo(self.contentView);
        }];
        
        UIImageView *leftImageView = [MYBaseView imageViewWithFrame:CGRectZero andImage:[UIImage imageNamed:@"lx"]];
        [self.contentView addSubview:leftImageView];
        [leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.titleLabel);
            make.right.equalTo(self.titleLabel.mas_left).offset(-17);
        }];
        
        UIImageView *rigthImageView = [MYBaseView imageViewWithFrame:CGRectZero andImage:[UIImage imageNamed:@"lx"]];
        [self.contentView addSubview:rigthImageView];
        [rigthImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.titleLabel);
            make.left.equalTo(self.titleLabel.mas_right).offset(17);
        }];
        
        self.infoLabel = [MYBaseView labelWithFrame:CGRectZero text:@"" textColor:[UIColor colorWithHexString:TZ_BLACK alpha:1.0] textAlignment:NSTextAlignmentLeft andFont:kFont(14)];
        [self.contentView addSubview:self.infoLabel];
        [self.infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLabel.mas_bottom).offset(30);
            make.left.equalTo(self.contentView).offset(15);
            make.centerX.equalTo(self.contentView);
        }];
        self.infoLabel.numberOfLines = 0;
        */
        
        self.picImageView = [MYBaseView imageViewWithFrame:CGRectZero andImage:nil];
        [self.contentView addSubview:self.picImageView];
        [self.picImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(self.contentView);
            make.center.equalTo(self.contentView);
        }];
    }
    return self;
}

- (void)setCellInfoWithDWJModel:(TZSearchProductModel *)model{
    self.infoLabel.text = model.pdtdesc;
}

- (void)setCellInfoWithTBModel:(TZTaoBaoProductModel *)model{
    self.infoLabel.text = [ZMUtils filterHTML:model.title];
}

- (void)setCellInfoWithServiceModel:(TZHomeBannerDetailModel *)model{
    self.infoLabel.text = model.describe;
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
