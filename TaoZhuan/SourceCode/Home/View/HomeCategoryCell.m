//
//  HomeCategoryCell.m
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/9/30.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "HomeCategoryCell.h"

@implementation HomeCategoryCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.jhsIcon = [MYBaseView imageViewWithFrame:CGRectZero andImage:[UIImage imageNamed:@"jhsicon"]];
        [self.contentView addSubview:self.jhsIcon];
        [self.jhsIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.right.equalTo(self.contentView.mas_centerX).offset(-20);
            make.width.mas_equalTo(19.5);
            make.height.mas_equalTo(17.5);
        }];
        
        self.jhsImageView = [MYBaseView imageViewWithFrame:CGRectZero andImage:[UIImage imageNamed:@"聚划算"]];
        [self.contentView addSubview:self.jhsImageView];
        [self.jhsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.left.equalTo(self.jhsIcon.mas_right).offset(5);
            make.width.mas_equalTo(57);
            make.height.mas_equalTo(18);
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
