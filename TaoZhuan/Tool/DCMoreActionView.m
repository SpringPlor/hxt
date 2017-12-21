//
//  DCMoreActionView.m
//  DolphinCommunity
//
//  Created by PengJiawei on 16/5/12.
//  Copyright © 2016年 Chen Jianye. All rights reserved.
//

#import "DCMoreActionView.h"

@interface DCMoreActionView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSArray *dataArray;

@property (nonatomic,assign) CGFloat rowHeight;

@end

@implementation DCMoreActionView

- (instancetype)initWithFrame:(CGRect)frame titleArray:(NSArray *)titleArray rowHeight:(CGFloat)rowHeight{
    if (self = [super initWithFrame:frame]) {
        _dataArray = titleArray;
        _rowHeight = rowHeight;
        self.backgroundColor = [UIColor clearColor];
        self.bgView = [MYBaseView viewWithFrame:self.bounds backgroundColor:[UIColor blackColor]];
        [self addSubview:self.bgView];
        [self.bgView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDown:)]];
        self.bgView.alpha = 0.3;
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH,rowHeight*(_dataArray.count+1)+5) style:UITableViewStylePlain];
        [self addSubview:_tableView];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.scrollEnabled = NO;
        [UIView animateWithDuration:0.25 animations:^{
            _tableView.frame = CGRectMake(0, SCREEN_HEIGHT-rowHeight*(_dataArray.count+1)-5, SCREEN_WIDTH, rowHeight*(_dataArray.count+1)+5);
        }];
    }
    return self;
}

- (void)tapDown:(UITapGestureRecognizer *)sender{
    self.moreBlock(nil);
}

- (void)hideViewWithCompleteBlock:(void (^)())completeBlock{
    [UIView animateWithDuration:0.25 animations:^{
        _tableView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, _rowHeight*(_dataArray.count+1)+5);
        self.bgView.alpha = 0;
    } completion:^(BOOL finished) {
        completeBlock();
    }];
}

#pragma mark - tableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return _dataArray.count;
    }else{
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return _rowHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }
    return 5;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor colorWithHexString:@"#999999" alpha:1.0];
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identify = @"identify";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    UILabel *titileLabel = [MYBaseView labelWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,_rowHeight) text:nil textColor:[UIColor colorWithHexString:@"#999999" alpha:1.0] textAlignment:NSTextAlignmentCenter andFont:kFont(15)];
    [cell.contentView addSubview:titileLabel];
    if (indexPath.section == 0) {
        titileLabel.text = _dataArray[indexPath.row];
        if ([_dataArray[indexPath.row] isEqualToString:@"删除"]) {
            titileLabel.textColor = [UIColor redColor];
        }else{
            titileLabel.textColor = [UIColor colorWithHexString:@"#999999" alpha:1.0];
        }
    }else{

        titileLabel.text = @"取消";
    }
    [cell setSeperatorInsetToZero:0];
    return cell;
}

#pragma mark - tableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        self.moreBlock(indexPath);
    }else{
        self.moreBlock(nil);
    }
}


- (void)saveImageWithImage:(UIImage *)image{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
       UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil); 
    });
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    
    if (error == nil) {
        
    }else{
    }
}


@end
