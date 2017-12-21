//
//  TZPartnerCell.h
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/12/4.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TZPartnerModel.h"

@interface TZPartnerCell : UITableViewCell

@property (nonatomic,strong) UIImageView *headImageView;
@property (nonatomic,strong) UILabel *phoneLabel;
//@property (nonatomic,strong) UILabel *timeLabel;
@property (nonatomic,strong) UILabel *moneyLabel;

- (void)setCellInfoWithModel:(TZPartnerModel *)model;

@end
