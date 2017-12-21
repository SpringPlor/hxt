//
//  TZDetailDescribeCell.h
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/10/11.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TZSearchProductModel.h"
#import "TZSearchResultModel.h"
#import "TZHomeBannerDetailModel.h"

@interface TZDetailDescribeCell : UITableViewCell

@property (nonatomic,strong) UIImageView *picImageView;

@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *infoLabel;

- (void)setCellInfoWithDWJModel:(TZSearchProductModel *)model;

- (void)setCellInfoWithTBModel:(TZTaoBaoProductModel *)model;

- (void)setCellInfoWithServiceModel:(TZHomeBannerDetailModel *)model;

@end
