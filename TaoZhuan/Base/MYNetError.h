//
//  MYNetError.h
//  ZebraLife_Merchant
//
//  Created by 彭佳伟 on 2017/8/8.
//  Copyright © 2017年 bm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MYNetError : NSObject

+ (void)ShowRequestErrorMessage:(NSError *)error;

@end
