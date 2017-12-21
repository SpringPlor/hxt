//
//  TZMineApplyCell.h
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/12/14.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TZMineApplyCell : UITableViewCell

@property (nonatomic,strong) UIImageView *applyImageView;
@property (nonatomic,copy) void (^tapBlock)();

@end
