//
//  UIView+Additions.m
//  Daci
//
//  Created by Frank Chen on 14-8-10.
//  Copyright (c) 2014年 qwy. All rights reserved.
//

#import "UIView+Additions.h"

@implementation UIView (Additions)

CGPoint CGRectGetCenter(CGRect rect)
{
    CGPoint pt;
    pt.x = CGRectGetMidX(rect);
    pt.y = CGRectGetMidY(rect);
    return pt;
}

CGRect CGRectMoveToCenter(CGRect rect, CGPoint center)
{
    CGRect newrect = CGRectZero;
    newrect.origin.x = center.x-CGRectGetMidX(rect);
    newrect.origin.y = center.y-CGRectGetMidY(rect);
    newrect.size = rect.size;
    return newrect;
}

// Retrieve and set the origin
- (CGPoint) origin
{
	return self.frame.origin;
}

- (void) setOrigin: (CGPoint) aPoint
{
	CGRect newframe = self.frame;
	newframe.origin = aPoint;
	self.frame = newframe;
}


// Retrieve and set the size
- (CGSize) size
{
	return self.frame.size;
}

- (void) setSize: (CGSize) aSize
{
	CGRect newframe = self.frame;
	newframe.size = aSize;
	self.frame = newframe;
}

// Query other frame locations
- (CGPoint) bottomRight
{
	CGFloat x = self.frame.origin.x + self.frame.size.width;
	CGFloat y = self.frame.origin.y + self.frame.size.height;
	return CGPointMake(x, y);
}

- (CGPoint) bottomLeft
{
	CGFloat x = self.frame.origin.x;
	CGFloat y = self.frame.origin.y + self.frame.size.height;
	return CGPointMake(x, y);
}

- (CGPoint) topRight
{
	CGFloat x = self.frame.origin.x + self.frame.size.width;
	CGFloat y = self.frame.origin.y;
	return CGPointMake(x, y);
}


// Retrieve and set height, width, top, bottom, left, right
- (CGFloat) height
{
	return self.frame.size.height;
}

- (void) setHeight: (CGFloat) newheight
{
	CGRect newframe = self.frame;
	newframe.size.height = newheight;
	self.frame = newframe;
}

- (CGFloat) width
{
	return self.frame.size.width;
}

- (void) setWidth: (CGFloat) newwidth
{
	CGRect newframe = self.frame;
	newframe.size.width = newwidth;
	self.frame = newframe;
}

- (CGFloat) top
{
	return self.frame.origin.y;
}

- (void) setTop: (CGFloat) newtop
{
	CGRect newframe = self.frame;
	newframe.origin.y = newtop;
	self.frame = newframe;
}

- (CGFloat) left
{
	return self.frame.origin.x;
}

- (void) setLeft: (CGFloat) newleft
{
	CGRect newframe = self.frame;
	newframe.origin.x = newleft;
	self.frame = newframe;
}

- (CGFloat) bottom
{
	return self.frame.origin.y + self.frame.size.height;
}

- (void) setBottom: (CGFloat) newbottom
{
	CGRect newframe = self.frame;
	newframe.origin.y = newbottom - self.frame.size.height;
	self.frame = newframe;
}

- (CGFloat) right
{
	return self.frame.origin.x + self.frame.size.width;
}

- (void) setRight: (CGFloat) newright
{
	CGFloat delta = newright - (self.frame.origin.x + self.frame.size.width);
	CGRect newframe = self.frame;
	newframe.origin.x += delta ;
	self.frame = newframe;
}

// Move via offset
- (void) moveBy: (CGPoint) delta
{
	CGPoint newcenter = self.center;
	newcenter.x += delta.x;
	newcenter.y += delta.y;
	self.center = newcenter;
}

// Scaling
- (void) scaleBy: (CGFloat) scaleFactor
{
	CGRect newframe = self.frame;
	newframe.size.width *= scaleFactor;
	newframe.size.height *= scaleFactor;
	self.frame = newframe;
}

// Ensure that both dimensions fit within the given size by scaling down
- (void) fitInSize: (CGSize) aSize
{
	CGFloat scale;
	CGRect newframe = self.frame;
	
	if (newframe.size.height && (newframe.size.height > aSize.height))
	{
		scale = aSize.height / newframe.size.height;
		newframe.size.width *= scale;
		newframe.size.height *= scale;
	}
	
	if (newframe.size.width && (newframe.size.width >= aSize.width))
	{
		scale = aSize.width / newframe.size.width;
		newframe.size.width *= scale;
		newframe.size.height *= scale;
	}
	
	self.frame = newframe;
}

- (UIViewController *)viewController
{
    // 下一个响应者
    UIResponder *next = [self nextResponder];
    do {
        if ([next isKindOfClass:[UIViewController class]] ) {
            return (UIViewController *)next;
        }
        
        next = [next nextResponder];
    } while (next != nil);
    
    return nil;
}


- (void)removeAllSubViewsByCategory
{
    for (NSInteger i = [self.subviews count]; i>0; i--) {
        UIView *view = [self.subviews objectAtIndex:i-1];
        [view removeFromSuperview];
        view = nil;
    }
}

- (id)getSuperViewWithClass:(Class)aClass
{
    UIResponder *next = [self nextResponder];
    do {
        if ([next isKindOfClass:aClass]) {
            return next;
        }
        
        next = [next nextResponder];
    } while (next != nil);
    
    return nil;
}

- (void)shakeWithCount:(int)count interval:(NSTimeInterval)interval {
    NSDictionary *info = [NSDictionary dictionaryWithObjectsAndKeys:
                          [NSNumber numberWithDouble:interval], @"interval",
                          [NSNumber numberWithInt:count],@"count",
                          [NSValue valueWithCGPoint:self.center],@"center",
                          nil];
	[NSTimer scheduledTimerWithTimeInterval:interval target:self
								   selector:@selector(shaking:)
								   userInfo:info repeats:NO];
}

- (void)shaking:(NSTimer *)aTimer {
    NSMutableDictionary *info = [NSMutableDictionary dictionaryWithDictionary:[aTimer userInfo]];
    [aTimer invalidate];
    aTimer = nil;
    int shakeCnt = [[info objectForKey:@"count"] intValue];
    CGPoint orgCenter = [[info objectForKey:@"center"] CGPointValue];
	CGPoint to;
	if (shakeCnt % 2 == 0 && shakeCnt > 0) {
		to = CGPointMake(orgCenter.x + floor(random() % shakeCnt) - shakeCnt / 2,
						 orgCenter.y + floor(random() % shakeCnt) - shakeCnt / 2);
	}else {
		to = orgCenter;
	}
    
	[self setCenter:to];
	shakeCnt--;
	if (shakeCnt > 0) {
        [info setObject:[NSNumber numberWithInt:shakeCnt] forKey:@"count"];
        [NSTimer scheduledTimerWithTimeInterval:[[info objectForKey:@"interval"] doubleValue]
                                         target:self
                                       selector:@selector(shaking:)
                                       userInfo:info repeats:NO];
    }
}

- (UIImage *)re_screenshot
{
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, [UIScreen mainScreen].scale);
    
    if ([self respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)]) {
        
        NSInvocation* invoc = [NSInvocation invocationWithMethodSignature:
                               [self methodSignatureForSelector:
                                @selector(drawViewHierarchyInRect:afterScreenUpdates:)]];
        [invoc setTarget:self];
        [invoc setSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)];
        CGRect arg2 = self.bounds;
        BOOL arg3 = YES;
        [invoc setArgument:&arg2 atIndex:2];
        [invoc setArgument:&arg3 atIndex:3];
        [invoc invoke];
    } else {
        [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


@end

@implementation UIView (i7Rotate360)

- (void)rotate360WithDuration:(CGFloat)aDuration repeatCount:(CGFloat)aRepeatCount timingMode:(enum i7Rotate360TimingMode)aMode {
	CAKeyframeAnimation *theAnimation = [CAKeyframeAnimation animation];
	theAnimation.values = [NSArray arrayWithObjects:
						   [NSValue valueWithCATransform3D:CATransform3DMakeRotation(0, 0,0,1)],
						   [NSValue valueWithCATransform3D:CATransform3DMakeRotation(3.13, 0,0,1)],
						   [NSValue valueWithCATransform3D:CATransform3DMakeRotation(6.26, 0,0,1)],
						   nil];
	theAnimation.cumulative = YES;
	theAnimation.duration = aDuration;
	theAnimation.repeatCount = aRepeatCount;
	theAnimation.removedOnCompletion = YES;
	
	if(aMode == i7Rotate360TimingModeEaseInEaseOut) {
		theAnimation.timingFunctions = [NSArray arrayWithObjects:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn],
										[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut],
										nil
										];
	}
	[self.layer addAnimation:theAnimation forKey:@"transform"];
}

- (void)rotate360WithDuration:(CGFloat)aDuration timingMode:(enum i7Rotate360TimingMode)aMode {
	[self rotate360WithDuration:aDuration repeatCount:1 timingMode:aMode];
}

- (void)rotate360WithDuration:(CGFloat)aDuration {
	[self rotate360WithDuration:aDuration repeatCount:4 timingMode:i7Rotate360TimingModeLinear];
}

- (void)imageWithTransformAnimation:(float)scale andRotation:(float)rotation
{
    self.transform = CGAffineTransformRotate(CGAffineTransformMakeScale(scale, scale),M_PI*rotation);
}


@end

@implementation UIView (ShowWithAnimation)

//动画弹出来
- (void)showWithAnimation
{
    UIView *this = self;
    [UIView animateWithDuration:0.2 animations:
     ^(void){
         this.transform = CGAffineTransformScale(CGAffineTransformIdentity,1.1f, 1.1f);
     }
                     completion:^(BOOL finished){
                         [this bounceOutAnimationStoped];
                     }];
}

- (void)bounceOutAnimationStoped
{
    UIView *this = self;
    [UIView animateWithDuration:0.1 animations:
     ^(void){
         this.transform = CGAffineTransformScale(CGAffineTransformIdentity,0.9, 0.9);
     }
                     completion:^(BOOL finished){
                         [this bounceInAnimationStoped];
                     }];
}

- (void)bounceInAnimationStoped
{
    UIView *this = self;
    [UIView animateWithDuration:0.1 animations:
     ^(void){
         this.transform = CGAffineTransformScale(CGAffineTransformIdentity,1, 1);
     }
                     completion:^(BOOL finished){
                         
                     }];
}

@end
