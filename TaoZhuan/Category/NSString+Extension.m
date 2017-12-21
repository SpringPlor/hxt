//
//  NSString+Extension.m
//  DolphinCommunity
//
//  Created by PengJiawei on 16/5/25.
//  Copyright © 2016年 Chen Jianye. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)

+ (CGSize)stringHightWithString:(NSString *)string size:(CGSize)size font:(UIFont *)font lineSpacing:(CGFloat)LineSpacing{
    if (string == nil) {
        return CGSizeZero;
    }
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:LineSpacing];//调整行间距
    if (LineSpacing == defaultLineSpacing) {
        return [string boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
    }else{
        return [string boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font,NSParagraphStyleAttributeName:paragraphStyle} context:nil].size;
    }
}

+ (NSAttributedString *)stringWithString:(NSString *)string Range:(NSRange)range color:(UIColor *)color font:(UIFont *)font{
    NSMutableAttributedString *attriString = [[NSMutableAttributedString alloc] initWithString:string];
    if (color != nil) {
        [attriString addAttribute:NSForegroundColorAttributeName value:color range:range];
    }
    if (font != nil) {
        [attriString addAttribute:NSFontAttributeName value:font range:range];
    }
    return attriString;
}

+ (NSString *)URLStringWithServiceUrl:(NSString *)serviceUrl path:(NSString *)path{
    NSURL *fullURL = [NSURL URLWithString:serviceUrl];
    if (![path isEqualToString:@""]) {
        fullURL = [NSURL URLWithString:path relativeToURL:fullURL];
    }
    if (fullURL == nil) {
        
        return nil;
    }
    return [fullURL absoluteString];
}

+ (NSAttributedString *)stringWithString:(NSString *)string lineSpacing:(CGFloat)lineSpacing{
    NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString:string];
    
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    [paragraphStyle setLineSpacing:lineSpacing];
    
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [string length])];
    
    return attributedString;
}

+ (NSAttributedString *)addThroughLineWithString:(NSString *)string Color:(UIColor *)color{
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:string attributes:@{NSStrikethroughStyleAttributeName : @(NSUnderlineStyleSingle),NSStrikethroughColorAttributeName :color,NSBaselineOffsetAttributeName:@(0)}];
    return attributedString;
}


@end
