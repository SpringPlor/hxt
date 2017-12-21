//
//  TZKeyChain.h
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/10/24.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

static NSString * const kUUIDKeyChainKey = @"com.taozhuan.keychainKey";

#import <Foundation/Foundation.h>
#import <Security/Security.h>

@interface TZKeyChain : NSObject

+ (void)save:(NSString *)service data:(id)data;
+ (id)load:(NSString *)service;
+ (void)delete:(NSString *)service;

@end
