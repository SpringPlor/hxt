//
//  ZMImageTool.h
//  ZebraLife_Merchant
//
//  Created by 彭佳伟 on 2017/8/23.
//  Copyright © 2017年 bm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SDImageCache.h"

@interface ZMImageTool : NSObject

+ (UIImage *)clipImage:(UIImage *)image toRect:(CGSize)size;

+ (void)downloadImageSizeWithURL:(id)imageURL imageSizeBlock:(void(^)(CGSize size))sizeBlock;

+ (UIImage *)drawQRCodeImageWithURL:(NSString *)imageUrl size:(CGFloat)size;

+ (UIImage *)imageFromView: (UIView *)theView atFrame:(CGRect)r;

@end
