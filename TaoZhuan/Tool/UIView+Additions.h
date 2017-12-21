//
//  UIView+Additions.h
//  Daci
//
//  Created by Frank Chen on 14-8-10.
//  Copyright (c) 2014年 qwy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Additions)

@property CGPoint origin;
@property CGSize size;

@property (readonly) CGPoint bottomLeft;
@property (readonly) CGPoint bottomRight;
@property (readonly) CGPoint topRight;

@property CGFloat height;
@property CGFloat width;

@property CGFloat top;
@property CGFloat left;

@property CGFloat bottom;
@property CGFloat right;

- (void) moveBy: (CGPoint) delta;
- (void) scaleBy: (CGFloat) scaleFactor;
- (void) fitInSize: (CGSize) aSize;

- (void)removeAllSubViewsByCategory;
- (id)getSuperViewWithClass:(Class)aClass;


//事件响应链
- (UIViewController *)viewController;

//shake动画
- (void)shakeWithCount:(int)count interval:(NSTimeInterval)interval;

//截图
- (UIImage *)re_screenshot;

@end

enum i7Rotate360TimingMode {
	i7Rotate360TimingModeEaseInEaseOut,
	i7Rotate360TimingModeLinear
};

@interface UIView (i7Rotate360)
- (void)rotate360WithDuration:(CGFloat)aDuration repeatCount:(CGFloat)aRepeatCount timingMode:(enum i7Rotate360TimingMode)aMode;
- (void)rotate360WithDuration:(CGFloat)aDuration timingMode:(enum i7Rotate360TimingMode)aMode;
- (void)rotate360WithDuration:(CGFloat)aDuration;
- (void)imageWithTransformAnimation:(float)scale andRotation:(float)rotation;
@end

//弹出框动画
@interface UIView (ShowWithAnimation)
- (void)showWithAnimation;
@end

