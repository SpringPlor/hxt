//
//  DCMoreActionView.h
//  DolphinCommunity
//
//  Created by PengJiawei on 16/5/12.
//  Copyright © 2016年 Chen Jianye. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DCMoreActionView : UIView

@property (nonatomic,strong)UIView *bgView;

@property (nonatomic,copy) void (^moreBlock)(NSIndexPath *indexPath);

- (instancetype)initWithFrame:(CGRect)frame titleArray:(NSArray *)titleArray rowHeight:(CGFloat)rowHeight;

- (void)hideViewWithCompleteBlock:(void (^)())completeBlock;

- (void)saveImageWithImage:(UIImage *)image;

@end
