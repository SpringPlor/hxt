//
//  TZSettingQuitCell.m
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/11/15.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "TZSettingQuitCell.h"

@implementation TZSettingQuitCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setSeperatorInsetToZero:SCREEN_WIDTH];
        self.contentView.backgroundColor = [UIColor colorWithHexString:TZ_TableView_Color alpha:1.0];
        self.quitLabel = [MYBaseView labelWithFrame:CGRectZero text:@"退出账号" textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter andFont:kFont(15)];
        [self.contentView addSubview:self.quitLabel];
        [self.quitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(15);
            make.center.equalTo(self.contentView);
            make.height.mas_equalTo(40);
        }];
        self.quitLabel.userInteractionEnabled = YES;
        self.quitLabel.backgroundColor = [UIColor colorWithHexString:TZ_LIGHT_RED alpha:1.0];
        self.quitLabel.layer.cornerRadius = 5;
        self.quitLabel.clipsToBounds = YES;
        [self.quitLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(quit:)]];
    }
    return self;
}

- (void)quit:(UITapGestureRecognizer *)sender{
    if (self.quitBlock) {
        self.quitBlock();
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
