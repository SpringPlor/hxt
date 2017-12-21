//
//  TZMineOrderCell.m
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/12/14.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "TZMineOrderCell.h"

@implementation TZMineOrderCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor colorWithHexString:TZ_TableView_Color alpha:1.0];
        self.orderModule = [[TZMineModuleView alloc] initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH-20, 138) title:@"返积分订单" iconArray:@[@"shenhez",@"jijiangdaoz",@"yidaoz",@"wuxiao"] itemTitle:@[@"审核中",@"即将到账",@"已到账",@"无效订单"]];
        self.orderModule.redView.image = [UIImage imageNamed:@"orderbiaoti"];
        self.orderModule.arrowImageView.hidden = NO;
        self.orderModule.orderButton.hidden = NO;
        self.orderModule.numLabel.hidden = YES;
        [self.contentView addSubview:self.orderModule];
        self.orderModule.layer.cornerRadius = 5;
        WeakSelf(self);
        [self.orderModule setTapItemBlock:^(NSInteger index) {
            if (weakSelf.tapBlock) {
                weakSelf.tapBlock(index);
            }
        }];
        /*[self.orderModule setTapItemBlock:^(NSInteger index){
            
        }];
        */
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
