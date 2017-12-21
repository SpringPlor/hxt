//
//  MYBaseModel.h
//  MaiYou
//
//  Created by PengJiawei on 2017/1/10.
//  Copyright © 2017年 PengJiawei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MYBaseModel : NSObject

@property (nonatomic,copy) NSString *code;
@property (nonatomic,copy) NSDictionary *data;
@property (nonatomic,copy) NSString *message;
@property (nonatomic,copy) NSString *success;

@end
