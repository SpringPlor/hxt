//
//  TZSettingCell.m
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/11/15.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "TZSettingCell.h"

@implementation TZSettingCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.titleLabel = [MYBaseView labelWithFrame:CGRectZero text:@"" textColor:[UIColor colorWithHexString:TZ_BLACK alpha:1.0] textAlignment:NSTextAlignmentLeft andFont:kFont(15)];
        [self.contentView addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(15);
            make.centerY.equalTo(self.contentView);
        }];
        
        self.infoLabel = [MYBaseView labelWithFrame:CGRectZero text:@"" textColor:[UIColor colorWithHexString:TZ_GRAY alpha:1.0] textAlignment:NSTextAlignmentLeft andFont:kFont(15)];
        [self.contentView addSubview:self.infoLabel];
        [self.infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-15);
            make.centerY.equalTo(self.contentView);
        }];

    }
    return self;
}

- (void)setCellInfoWithIndex:(NSInteger)index{
    if (index == 0) {
        self.titleLabel.text = @"版本号";
        NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
        NSString *ipaVersion = infoDict[@"CFBundleShortVersionString"];//代码版本
        NSString *appVersion = infoDict[@"CFBundleVersion"];//项目版本
        self.infoLabel.text = [NSString stringWithFormat:@"V %@",appVersion];
    }else if (index == 1){
        self.titleLabel.text = @"当前账号";
        self.infoLabel.text = [MYSingleton shareInstonce].loginModel.phoneNumber;
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
