//
//  TZYaoQingQRCodeCell.m
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/11/3.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "TZYaoQingQRCodeCell.h"

@implementation TZYaoQingQRCodeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.shareLabel = [MYBaseView labelWithFrame:CGRectZero text:@"分享二维码" textColor:[UIColor colorWithHexString:TZ_LIGHT_RED alpha:1.0] textAlignment:NSTextAlignmentCenter andFont:kFont(14)];
        [self.contentView addSubview:self.shareLabel];
        [self.shareLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.contentView);
        }];
        
        self.qrCodeIcon = [MYBaseView imageViewWithFrame:CGRectZero andImage:[UIImage imageNamed:@"fenxiangerweim"]];
        [self.contentView addSubview:self.qrCodeIcon];
        [self.qrCodeIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.shareLabel);
            make.right.equalTo(self.shareLabel.mas_left).offset(-6);
            make.width.mas_equalTo(14);
            make.height.mas_equalTo(15);
        }];
        
        self.shareIcon = [MYBaseView imageViewWithFrame:CGRectZero andImage:[UIImage imageNamed:@"jiantou"]];
        [self.contentView addSubview:self.shareIcon];
        [self.shareIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.shareLabel);
            make.left.equalTo(self.shareLabel.mas_right).offset(5);
            make.width.mas_equalTo(4.5);
            make.height.mas_equalTo(8);
        }];
    }
    return self;
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
