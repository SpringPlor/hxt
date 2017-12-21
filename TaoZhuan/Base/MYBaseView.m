//
//  MYBaseView.m
//  MaiYou
//
//  Created by PengJiawei on 2017/1/10.
//  Copyright © 2017年 PengJiawei. All rights reserved.
//

#import "MYBaseView.h"

@implementation MYBaseView

+(MYBaseView*)shareManager{
    static MYBaseView *baceView = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        baceView = [[MYBaseView alloc] init];
    });
    return baceView;
}

#pragma mark 创建一个UILabel

+ (UILabel *)labelWithFrame:(CGRect)frame
                       text:(NSString *)text
                  textColor:(UIColor *)tColor
              textAlignment:(NSTextAlignment)alignment
                    andFont:(UIFont *)font
{
    UILabel *label = [[UILabel alloc] init];
    label.frame = frame;
    label.text = text;
    label.font = font;
    label.textColor = tColor;
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = alignment;
    return label;
}

#pragma mark 创建一个WebView

+ (UITextField *)textFieldWithFrame:(CGRect)frame
                               text:(NSString *)text
                          textColor:(UIColor *)tColor
                      textAlignment:(NSTextAlignment)alignment
                        andFontSize:(CGFloat)size
                        placeholder:(NSString *)placeholder
                              style:(UITextBorderStyle)style
{
    UITextField *textField = [[UITextField alloc] init];
    textField.frame = frame;
    textField.text = text;
    textField.font = [UIFont fontWithName: @"HelveticaNeue" size:size];
    textField.textColor = tColor;
    textField.backgroundColor = [UIColor clearColor];
    textField.textAlignment = alignment;
    textField.placeholder = placeholder;
    textField.borderStyle = style;
    return textField;
}


#pragma mark 创建一个UIImageView
+ (UIImageView *)imageViewWithFrame:(CGRect)frame
                           andImage:(UIImage *)image
{
    UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
    imageView.frame = frame;
    return imageView;
}

#pragma mark 创建一个UIButton
+ (UIButton *)buttonWithFrame:(CGRect)frame
                   buttonType:(UIButtonType)type
                        image:(UIImage *)image
                  selectImage:(UIImage *)sImage
{
    UIButton *button = [UIButton buttonWithType:type];
    button.frame = frame;
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:sImage forState:(UIControlStateSelected)];
    return button;
}
#pragma mark 创建一个UIButton
+ (UIButton *)buttonWithFrame:(CGRect)frame
                   buttonType:(UIButtonType)type
                        title:(NSString *) title
                   titleColor:(UIColor *) color
                         font:(UIFont *) font{
    UIButton *button = [UIButton buttonWithType:type];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor: color forState:UIControlStateNormal];
    button.titleLabel.font = font;
    return button;
}

#pragma mark 创建一个UIButton
+ (UIButton *)buttonWithFrame:(CGRect)frame
                        image:(UIImage *)image
                        title:(NSString *)title
                   titleColor:(UIColor *)color
                         font:(UIFont *)font{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor: color forState:UIControlStateNormal];
    button.titleLabel.font = font;
    [button setImage:image forState:UIControlStateNormal];
    return button;
}

#pragma mark 创建一个UITableView
+ (UITableView *)tableViewWithFrame:(CGRect)frame
                      tableViewType:(UITableViewStyle)type
{
    UITableView *tableView = [[UITableView alloc]initWithFrame:frame style:type];
    return tableView;
}

#pragma mark 创建一个UIView
+ (UIView *)viewWithFrame:(CGRect)frame
          backgroundColor:(UIColor *)color
{
    UIView *view = [[UIView alloc]initWithFrame:frame];
    view.backgroundColor = color;
    return view;
}

#pragma mark 创建一个WebView
+ (UIWebView *)webViewUseRequestWithFrame:(CGRect)frame
                                urlString:(NSString *)url
{
    UIWebView *webView = [[UIWebView alloc]initWithFrame:frame];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:url]];
    [webView loadRequest:request];
    return webView;
}

#pragma mark - 创建一个SegmentedControl
+ (UISegmentedControl *)segmentWithFrame:(CGRect)frame withTitles:(NSArray *)titles withTintColor:(UIColor *)tintColor withBackGroundColor:(UIColor *)backGroundColor withtarget:(id)target withSEL:(SEL)action{
    
    UISegmentedControl * segmentController = [[UISegmentedControl alloc]initWithItems:titles];
    segmentController.frame = frame;
    segmentController.selectedSegmentIndex = 0;
    segmentController.tintColor = tintColor;
    segmentController.backgroundColor = backGroundColor;
    [segmentController addTarget:target action:action forControlEvents:UIControlEventValueChanged];
    return segmentController;
}

@end
