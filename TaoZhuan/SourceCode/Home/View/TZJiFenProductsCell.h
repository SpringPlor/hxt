//
//  TZJiFenProductsCell.h
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/10/10.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TZJFProductModel.h"

@interface TZJiFenProductsCell : UITableViewCell

@property (nonatomic,strong) UIImageView *picImageView;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *jifenLabel;
@property (nonatomic,strong) UILabel *oriPriceLabel;
@property (nonatomic,strong) UIImageView *hotImageView;
@property (nonatomic,copy) void (^exchangeBlock)();

- (void)setCellInfoWithModel:(TZJFProductModel *)model;

@end
