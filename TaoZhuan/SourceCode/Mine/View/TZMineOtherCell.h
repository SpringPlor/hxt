//
//  TZMineOtherCell.h
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/12/14.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TZMineOtherView.h"

@interface TZMineOtherCell : UITableViewCell

@property (nonatomic,strong) TZMineOtherView *otherModule;
@property (nonatomic,copy) void (^tapBlock)(NSInteger index);
@end
