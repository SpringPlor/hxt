//
//  TZMinePartnerView.h
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/12/4.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TZMinePartnerView : UIView

@property (nonatomic,strong) UIImageView *redView;

@property (nonatomic,strong) UIImageView *arrowImageView;

@property (nonatomic,strong) UIButton *orderButton;

@property (nonatomic,strong) UILabel *numLabel;

@property (nonatomic,copy) void (^tapItemBlock)(NSInteger index);

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title iconArray:(NSArray *)iconArray itemTitle:(NSArray *)itemArray;


@end
