//
//  TZReturnJFExchangeCell.h
//  ZhaoQuanWang
//
//  Created by 彭佳伟 on 2017/11/21.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TZJFProductModel.h"

@interface TZReturnJFExchangeCell : UICollectionViewCell

@property (nonatomic,strong) UIImageView *picImageView;
@property (nonatomic,strong) UIImageView *lineImageView;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *stockLabel;
@property (nonatomic,strong) UIView *garyView;
@property (nonatomic,strong) UIView *redView;
@property (nonatomic,strong) UILabel *jfLabel;
@property (nonatomic,strong) UILabel *priceLabel;

- (void)setCellInfoWithModel:(TZJFProductModel *)model;

@end
