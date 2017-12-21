//
//  NSString+Extension.h
//  DolphinCommunity
//
//  Created by PengJiawei on 16/5/25.
//  Copyright © 2016年 Chen Jianye. All rights reserved.
//

#import <Foundation/Foundation.h>

static CGFloat defaultLineSpacing = 0;

@interface NSString (Extension)

+ (CGSize)stringHightWithString:(NSString *)string size:(CGSize)size font:(UIFont *)font lineSpacing:(CGFloat)LineSpacing;

+ (NSAttributedString *)stringWithString:(NSString *)string Range:(NSRange)range color:(UIColor *)color font:(UIFont *)font;

+ (NSString *)URLStringWithServiceUrl:(NSString *)serviceUrl path:(NSString *)path;

+ (NSAttributedString *)stringWithString:(NSString *)string lineSpacing:(CGFloat)lineSpacing;

+ (NSAttributedString *)addThroughLineWithString:(NSString *)string Color:(UIColor *)color;

@end
