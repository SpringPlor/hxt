//
//  TZHomeRecommandCell.h
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/12/8.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TZServiceGoodsModel.h"

@interface TZHomeRecommandCell : UITableViewCell

@property (nonatomic,strong) UIImageView *pdtImageView;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *priceLabel;
@property (nonatomic,strong) UIButton *couponButton;
@property (nonatomic,strong) UILabel *noticeLabel;

- (void)setCellInfoWithModel:(TZServiceGoodsModel *)model;

@end
