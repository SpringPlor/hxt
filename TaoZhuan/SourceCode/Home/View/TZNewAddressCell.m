//
//  TZNewAddressCell.m
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/10/10.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "TZNewAddressCell.h"

@implementation TZNewAddressCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;

        self.titleLabel = [MYBaseView labelWithFrame:CGRectZero text:nil textColor:[UIColor colorWithHexString:TZ_BLACK alpha:1.0] textAlignment:NSTextAlignmentLeft andFont:kFont(15)];
        [self.contentView addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(15);
            make.centerY.equalTo(self.contentView);
        }];
        self.textField = [MYBaseView textFieldWithFrame:CGRectZero text:nil textColor:[UIColor colorWithHexString:TZ_BLACK alpha:1.0] textAlignment:NSTextAlignmentLeft andFontSize:15 placeholder:nil style:UITextBorderStyleNone];
        [self.contentView addSubview:self.textField];
        [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(100);
            make.centerY.equalTo(self.contentView);
            make.right.equalTo(self.contentView).offset(-15);
            make.height.mas_equalTo(30);
        }];
        
        self.defaultButton = [MYBaseView buttonWithFrame:CGRectZero buttonType:UIButtonTypeCustom image:nil selectImage:nil];
        [self.contentView addSubview:self.defaultButton];
        [self.defaultButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-15);
            make.centerY.equalTo(self.contentView);
            make.width.height.mas_equalTo(30);
        }];
        self.defaultButton.backgroundColor = [UIColor redColor];
        self.defaultButton.hidden = YES;
    }
    return self;
}

- (void)setCellTitleWithIndex:(NSInteger)index{
    switch (index) {
        case 0:{
            self.textLabel.text = @"收货人";
            self.textField.placeholder = @"请输入收货人姓名";
        }
            break;
        case 1:{
            self.textLabel.text = @"手机号码";
            self.textField.placeholder = @"请输入手机号";
        }
            break;
        case 2:{
            self.textLabel.text = @"地区";
            self.textField.placeholder = @"请输入您所在区域";
        }
            break;
        case 3:{
//            self.textLabel.text = @"详细地址";
//            self.textField.placeholder = @"请输入详细地址";
        }
            break;
        case 4:
        {
            self.textLabel.text = @"默认地址";
            self.textField.hidden = YES;
            self.defaultButton.hidden = NO;
        }
            break;
        default:
            break;
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
