//
//  TZBaseModel.h
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/12/7.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TZBaseModel : NSObject

@property (nonatomic,copy) NSString *code;
@property (nonatomic,copy) NSArray *data;
@property (nonatomic,copy) NSString *message;
@property (nonatomic,copy) NSString *success;

@end
