//
//  TZAddressDetailCell.m
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/10/10.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "TZAddressDetailCell.h"

@implementation TZAddressDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.titleLabel = [MYBaseView labelWithFrame:CGRectZero text:@"详细地址" textColor:[UIColor colorWithHexString:TZ_BLACK alpha:1.0] textAlignment:NSTextAlignmentLeft andFont:kFont(15)];
        [self.contentView addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(15);
            make.top.equalTo(self.contentView).offset(17);
        }];
        
        self.describeTextView = [[UITextView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:self.describeTextView];
        [self.describeTextView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-15);
            make.top.equalTo(self.titleLabel).offset(-8);
            make.left.equalTo(self.contentView).offset(95);
            make.centerY.equalTo(self.contentView);
        }];
        self.describeTextView.text = @"请输入您详细地址";
        self.describeTextView.textColor = rGB_Color(200, 200, 200);//[UIColor colorWithHexString:TZ_GRAY alpha:1.0];
        self.describeTextView.textAlignment = NSTextAlignmentLeft;
        self.describeTextView.font = kFont(15);
        self.describeTextView.scrollEnabled = YES;
        self.describeTextView.delegate = self;
    }
    return self;
}

#pragma mark - UITextViewDelegate
- (void)textViewDidEndEditing:(UITextView *)textView{
    if(textView.text.length < 1){
        textView.text = @"请输入您详细地址";
        textView.textColor = rGB_Color(240, 240, 240);//[UIColor colorWithHexString:TZ_GRAY alpha:1.0];
    }
}
- (void)textViewDidBeginEditing:(UITextView *)textView{
    if([textView.text isEqualToString:@"请输入您详细地址"]){
        textView.text = @"";
        textView.textColor = [UIColor colorWithHexString:TZ_BLACK alpha:1.0];
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
