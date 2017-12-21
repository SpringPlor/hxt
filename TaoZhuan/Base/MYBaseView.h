//
//  MYBaseView.h
//  MaiYou
//
//  Created by PengJiawei on 2017/1/10.
//  Copyright © 2017年 PengJiawei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MYBaseView : NSObject

+ (MYBaseView*)shareManager;

+ (UILabel *)labelWithFrame:(CGRect)frame
                       text:(NSString *)text
                  textColor:(UIColor *)tColor
              textAlignment:(NSTextAlignment)alignment
                    andFont:(UIFont *)font;

+ (UIImageView *)imageViewWithFrame:(CGRect)frame
                           andImage:(UIImage *)image;

+ (UIButton *)buttonWithFrame:(CGRect)frame
                   buttonType:(UIButtonType)type
                        image:(UIImage *)image
                  selectImage:(UIImage *)sImage;

+ (UIButton *)buttonWithFrame:(CGRect)frame
                   buttonType:(UIButtonType)type
                        title:(NSString *) title
                   titleColor:(UIColor *) color
                         font:(UIFont *) font;
+ (UIButton *)buttonWithFrame:(CGRect)frame
                        image:(UIImage *)image
                        title:(NSString *) title
                   titleColor:(UIColor *) color
                         font:(UIFont *) font;

+ (UITableView *)tableViewWithFrame:(CGRect)frame
                      tableViewType:(UITableViewStyle)type;

+ (UIView *)viewWithFrame:(CGRect)frame
          backgroundColor:(UIColor *)color;

+ (UIWebView *)webViewUseRequestWithFrame:(CGRect)frame
                                urlString:(NSString *)url;

+ (UITextField *)textFieldWithFrame:(CGRect)frame
                               text:(NSString *)text
                          textColor:(UIColor *)tColor
                      textAlignment:(NSTextAlignment)alignment
                        andFontSize:(CGFloat)size
                        placeholder:(NSString *)placeholder
                              style:(UITextBorderStyle)style;

+ (UISegmentedControl *)segmentWithFrame:(CGRect)frame
                              withTitles:(NSArray *)titles
                           withTintColor:(UIColor *)tintColor
                     withBackGroundColor:(UIColor *)backGroundColor
                              withtarget:(id)target
                                 withSEL:(SEL)action;

@end
