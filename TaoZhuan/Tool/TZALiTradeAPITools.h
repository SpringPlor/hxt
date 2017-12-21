//
//  TZALiTradeAPITools.h
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/9/29.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TZSearchModel.h"

@interface TZALiTradeAPITools : NSObject

+ (NSString *)fetchApiSin:(TZSearchModel *)model;

@end
