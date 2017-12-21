//
//  MYBaseViewModel.m
//  MaiYou
//
//  Created by PengJiawei on 2017/1/11.
//  Copyright © 2017年 PengJiawei. All rights reserved.
//

#import "MYBaseViewModel.h"

@implementation MYBaseViewModel

- (void)setBlockWithSuccessBlock:(SuccessBlock)successBlock WErrorBock:(ErrorBlock)errorBlock{
    _successBlock = successBlock;
    _errorBlock = errorBlock;
}

@end
