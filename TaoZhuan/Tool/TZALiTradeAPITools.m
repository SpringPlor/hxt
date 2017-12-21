//
//  TZALiTradeAPITools.m
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/9/29.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "TZALiTradeAPITools.h"

@implementation TZALiTradeAPITools

+ (NSString *)fetchApiSin:(TZSearchModel *)model{
    NSDictionary *dic = [model mj_keyValues];
    NSArray *allKeys = [dic allKeys];
    NSArray *sortedArray = [allKeys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        //这里的代码可以参照上面compare:默认的排序方法，也可以把自定义的方法写在这里，给对象排序
        NSComparisonResult result = [obj1 compare:obj2];
        return result;
    }];
    
    NSMutableString *string = [NSMutableString string];
    [string appendString:AliTradeSDK_Secrect];
    for (int i = 0 ; i < sortedArray.count; i ++){
        [string appendString:sortedArray[i]];
        [string appendString:dic[sortedArray[i]]];
    }
    [string appendString:AliTradeSDK_Secrect];
    return [ZMUtils md5:string];
}

@end
