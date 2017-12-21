//
//  TZJiFenExchangeTitleCell.h
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/10/10.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TZJiFenExchangeTitleCell : UITableViewCell<UIScrollViewDelegate>

@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIImageView *arrowImageView;

@property (nonatomic,copy) void (^tapBlcok)(NSInteger index);

- (void)setCellGuideTypeIndex:(NSInteger)index;

@end
