//
//  JJVerticalButton.h
//  refresh
//
//  Created by myjawdrops on 16/11/29.
//  Copyright © 2016年 MyJawDrops. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MYVerticalButton : UIButton
@property (nonatomic, assign) CGFloat imageHeightRatio;
+ (instancetype)verticalButtonWithFrame:(CGRect)frame;
@end
