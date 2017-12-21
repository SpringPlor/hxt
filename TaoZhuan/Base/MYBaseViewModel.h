//
//  MYBaseViewModel.h
//  MaiYou
//
//  Created by PengJiawei on 2017/1/11.
//  Copyright © 2017年 PengJiawei. All rights reserved.
//

//定义返回请求数据的block类型
typedef void (^SuccessBlock) (id response);

typedef void (^ErrorBlock) (NSError *error);

#import <Foundation/Foundation.h>

@interface MYBaseViewModel : NSObject

@property (strong, nonatomic) SuccessBlock successBlock;

@property (strong, nonatomic) ErrorBlock errorBlock;

- (void)setBlockWithSuccessBlock:(SuccessBlock)successBlock WErrorBock:(ErrorBlock)errorBlock;

@end
