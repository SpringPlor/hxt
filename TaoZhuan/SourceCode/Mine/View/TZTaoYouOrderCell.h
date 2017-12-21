//
//  TZTaoYouOrderCell.h
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/12/6.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TZTaoYouOrderModel.h"

@interface TZTaoYouOrderCell : UITableViewCell

@property (nonatomic,strong) UILabel *orderNumLabel;
@property (nonatomic,strong) UILabel *orderTimeLabel;
@property (nonatomic,strong) UIImageView *picImageView;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) TZOrderImageModel *imgeModel;

- (void)setCellInfoWithModel:(TZTaoYouOrderModel *)model;

@end
