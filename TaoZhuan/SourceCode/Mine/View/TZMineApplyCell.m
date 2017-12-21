//
//  TZMineApplyCell.m
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/12/14.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "TZMineApplyCell.h"

@implementation TZMineApplyCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor colorWithHexString:TZ_TableView_Color alpha:1.0];
        self.applyImageView = [MYBaseView imageViewWithFrame:CGRectMake(10*kScale, 0, 355*kScale, 115*kScale) andImage:[UIImage imageNamed:@"申请代理"]];
        [self.contentView  addSubview:_applyImageView];
        _applyImageView.userInteractionEnabled = YES;
        [_applyImageView addGestureRecognizer:[UITapGestureRecognizer nvm_gestureRecognizerWithActionBlock:^(id sender) {
            if (self.tapBlock) {
                self.tapBlock();
            }
        }]];
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
