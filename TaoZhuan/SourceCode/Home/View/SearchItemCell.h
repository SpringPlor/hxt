//
//  SearchItemCell.h
//  MaiYou
//
//  Created by bm on 2017/4/5.
//  Copyright © 2017年 PengJiawei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchItemModel.h"

@interface SearchItemCell : UICollectionViewCell

@property (nonatomic,strong) UILabel *nameLabel;

- (void)setCellInfoWithModel:(SearchItemModel *)model;

- (CGFloat)cellItemWidth;

@end
