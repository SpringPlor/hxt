//
//  TZHomeSearchView.h
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/10/9.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TZHomeSearchView : UIView

@property (nonatomic,strong) UITextField *textfield;

@property (nonatomic,strong) void (^cancelBlock)();
@property (nonatomic,strong) void (^searchBlock)(NSString *keyWord);

- (void)loadSearchRecord;

@end
