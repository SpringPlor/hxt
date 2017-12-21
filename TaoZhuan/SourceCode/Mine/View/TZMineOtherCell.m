//
//  TZMineOtherCell.m
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/12/14.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "TZMineOtherCell.h"

@implementation TZMineOtherCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor colorWithHexString:TZ_TableView_Color alpha:1.0];
        self.otherModule = [[TZMineOtherView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 152+55*2)];
        [self.contentView addSubview:self.otherModule];
        WeakSelf(self);
        [self.otherModule setTapBlock:^(NSInteger index) {
            if (weakSelf.tapBlock) {
                weakSelf.tapBlock(index);
            }
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
