//
//  UIGestureRecognizer+Block.h
//  RunTime
//
//  Created by PengJiawei on 16/5/9.
//  Copyright © 2016年 PengJiawei. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^NVMGestureBlock)(id);

@interface UIGestureRecognizer (Block)

+ (instancetype)nvm_gestureRecognizerWithActionBlock:(NVMGestureBlock)block;

@end
