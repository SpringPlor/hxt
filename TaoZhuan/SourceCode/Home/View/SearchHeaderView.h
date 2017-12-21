//
//  SearchHeaderView.h
//  MaiYou
//
//  Created by bm on 2017/4/6.
//  Copyright © 2017年 PengJiawei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchHeaderView : UICollectionReusableView

@property (nonatomic,strong) UIView *lineView;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UIButton *iconButton;
@property (nonatomic,copy)  void (^deleteBlock)();

@end
