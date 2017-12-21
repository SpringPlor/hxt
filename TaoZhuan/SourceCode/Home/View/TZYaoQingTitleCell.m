//
//  TZYaoQingTitleCell.m
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/10/10.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "TZYaoQingTitleCell.h"

@implementation TZYaoQingTitleCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.bgImageView = [MYBaseView imageViewWithFrame:CGRectZero andImage:[UIImage imageNamed:@"bg"]];
        [self.contentView addSubview:self.bgImageView];
        [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(self.contentView);
            make.width.mas_equalTo(SCREEN_WIDTH);
            make.height.mas_equalTo(339*kScale);
        }];
        
        self.yqCodeLabel = [MYBaseView labelWithFrame:CGRectZero text:nil textColor:[UIColor colorWithHexString:TZ_BLACK alpha:1.0] textAlignment:NSTextAlignmentCenter andFont:kFont(20)];
        [self.contentView addSubview:self.yqCodeLabel];
        [self.yqCodeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.bgImageView);
            make.bottom.equalTo(self.bgImageView.mas_bottom).offset(-55);
        }];
        
        self.yqImageView = [MYBaseView imageViewWithFrame:CGRectZero andImage:[UIImage imageNamed:@"yaoqing"]];
        [self.contentView addSubview:self.yqImageView];
        [self.yqImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.contentView);
            make.top.equalTo(self.bgImageView.mas_bottom).offset(10);
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(15);
        }];
        
        NSArray *iconArray = @[@"fxpengyouquan",@"fxweixin",@"fxkongjian",@"fxqq"];
        CGFloat spaceWith = ((SCREEN_WIDTH-100)-48*iconArray.count)/(iconArray.count - 1);
        //NSArray *iconArray = @[@"fxpengyouquan",@"fxweixin"];
        for (int i = 0; i < iconArray.count; i ++) {
            UIButton *iconButton = [MYBaseView buttonWithFrame:CGRectZero buttonType:UIButtonTypeCustom image:[UIImage imageNamed:iconArray[i]] selectImage:nil];
            [self.contentView addSubview:iconButton];
            [iconButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.contentView).offset(50+(48+spaceWith)*i);
                make.top.equalTo(self.yqImageView.mas_bottom).offset(22);
                make.width.height.mas_equalTo(48);
            }];
            [iconButton addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchUpInside];
            iconButton.tag = 1000+i;
        }
    }
    return self;
}

- (void)setInviteCode:(NSString *)code{
    self.yqCodeLabel.text = code;
}

-
(void)shareAction:(UIButton *)sender{
    if (self.shareBlock) {
        self.shareBlock(sender.tag - 1000);
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
