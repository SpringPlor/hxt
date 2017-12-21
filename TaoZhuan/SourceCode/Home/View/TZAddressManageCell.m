//
//  TZAddressManageCell.m
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/10/10.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "TZAddressManageCell.h"

@implementation TZAddressManageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.nameLabel = [MYBaseView labelWithFrame:CGRectZero text:@"李茉莉" textColor:[UIColor colorWithHexString:TZ_BLACK alpha:1.0] textAlignment:NSTextAlignmentLeft andFont:kFont(15)];
        [self.contentView addSubview:self.nameLabel];
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(15);
            make.top.equalTo(self.contentView).offset(10);
        }];
        
        self.phoneLabel = [MYBaseView labelWithFrame:CGRectZero text:@"123456789101" textColor:[UIColor colorWithHexString:TZ_BLACK alpha:1.0] textAlignment:NSTextAlignmentLeft andFont:kFont(15)];
        [self.contentView addSubview:self.phoneLabel];
        [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-15);
            make.centerY.equalTo(self.nameLabel);
        }];
        
        self.addressLabel = [MYBaseView labelWithFrame:CGRectZero text:@"李茉莉" textColor:[UIColor colorWithHexString:TZ_BLACK alpha:1.0] textAlignment:NSTextAlignmentLeft andFont:kFont(15)];
        [self.contentView addSubview:self.addressLabel];
        [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.nameLabel);
            make.top.equalTo(self.nameLabel.mas_bottom).offset(10);
            make.centerX.equalTo(self.contentView);
        }];
        self.addressLabel.numberOfLines = 0;
        
        self.lineView = [MYBaseView viewWithFrame:CGRectZero backgroundColor:[UIColor colorWithHexString:TZ_GRAY alpha:1.0]];
        [self.contentView addSubview:self.lineView];
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.nameLabel);
            make.centerX.equalTo(self.contentView);
            make.top.equalTo(self.addressLabel.mas_bottom).offset(10);
            make.height.mas_equalTo(1);
        }];
        
        self.defaultButton = [MYBaseView buttonWithFrame:CGRectZero buttonType:UIButtonTypeCustom image:nil selectImage:nil];
        [self.contentView addSubview:self.defaultButton];
        [self.defaultButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.nameLabel);
            make.top.equalTo(self.lineView).offset(10);
            make.width.height.mas_equalTo(30);
        }];
        self.defaultButton.backgroundColor = [UIColor redColor];
        self.defaultButton.hidden = YES;
        
        self.defaultLabel = [MYBaseView labelWithFrame:CGRectZero text:@"默认地址" textColor:[UIColor colorWithHexString:TZ_BLACK alpha:1.0] textAlignment:NSTextAlignmentLeft andFont:kFont(15)];
        [self.contentView addSubview:self.defaultLabel];
        [self.defaultLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.defaultButton.mas_right).offset(10);
            make.centerY.equalTo(self.defaultButton);
        }];
        
        self.deleteButton = [MYBaseView buttonWithFrame:CGRectZero buttonType:UIButtonTypeCustom title:@"删除" titleColor:[UIColor colorWithHexString:TZ_BLACK alpha:1.0] font:kFont(15)];
        [self.contentView addSubview:self.deleteButton];
        [self.deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-15);
            make.centerY.equalTo(self.defaultButton);
            make.width.mas_equalTo(50);
            make.height.mas_equalTo(50);
        }];
        
        UIView *line = [MYBaseView viewWithFrame:CGRectZero backgroundColor:[UIColor colorWithHexString:TZ_GRAY alpha:1.0]];
        [self.contentView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.deleteButton.mas_left).offset(-10);
            make.centerY.equalTo(self.contentView);
            make.height.mas_equalTo(30);
            make.width.mas_equalTo(1);
        }];
        
        self.editButton = [MYBaseView buttonWithFrame:CGRectZero buttonType:UIButtonTypeCustom title:@"编辑" titleColor:[UIColor colorWithHexString:TZ_BLACK alpha:1.0] font:kFont(15)];
        [self.contentView addSubview:self.editButton];
        [self.editButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(line.mas_left).offset(-10);
            make.centerY.equalTo(self.defaultButton);
            make.width.mas_equalTo(50);
            make.height.mas_equalTo(50);
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
