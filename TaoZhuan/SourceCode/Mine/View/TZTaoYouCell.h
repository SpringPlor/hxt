//
//  TZTaoYouCell.h
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/10/14.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TZTaoYouModel.h"

@interface TZTaoYouCell : UITableViewCell

@property (nonatomic,strong) UILabel *timeLabel;
@property (nonatomic,strong) UILabel *nameLabel;

- (void)setCellInfoWithModel:(TZTaoYouModel *)model;

@end
