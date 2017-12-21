//
//  TZNewVersionView.h
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/11/15.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TZNewVersionView : UIView

@property (nonatomic,strong) UIView *bgView;
@property (nonatomic,strong) UIImageView *versionView;
@property (nonatomic,strong) UILabel *versionLabel;

@property (nonatomic,copy) void(^tapBlock)(BOOL upgrade);

@end
