//
//  TZTaoYouCell.m
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/10/14.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "TZTaoYouCell.h"

@implementation TZTaoYouCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.timeLabel = [MYBaseView labelWithFrame:CGRectZero text:@"2017-10-11" textColor:[UIColor colorWithHexString:TZ_BLACK alpha:1.0] textAlignment:NSTextAlignmentCenter andFont:kFont(15)];
        [self.contentView addSubview:self.timeLabel];
        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(self.contentView);
            make.centerY.equalTo(self.contentView);
            make.width.mas_equalTo(SCREEN_WIDTH/2);
        }];
        
        self.nameLabel = [MYBaseView labelWithFrame:CGRectZero text:@"张静怡" textColor:[UIColor colorWithHexString:TZ_BLACK alpha:1.0] textAlignment:NSTextAlignmentCenter andFont:kFont(15)];
        [self.contentView addSubview:self.nameLabel];
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.top.equalTo(self.contentView);
            make.centerY.equalTo(self.contentView);
            make.width.mas_equalTo(SCREEN_WIDTH/2);
        }];
    }
    return self;
}

- (void)setCellInfoWithModel:(TZTaoYouModel *)model{
    self.timeLabel.text = [[ZMUtils timeWithTimeIntervalString:model.creationTime] substringWithRange:NSMakeRange(0, 10)];
    self.nameLabel.text = model.phoneNumber;
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
