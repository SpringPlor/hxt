//
//  TZMineAgentCell.h
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/12/14.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TZMinePartnerView.h"

@interface TZMineAgentCell : UITableViewCell

@property (nonatomic,strong) TZMinePartnerView *partnerModule;

@property (nonatomic,copy) void (^tapBlock)(NSInteger index);


@end
