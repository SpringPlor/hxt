//
//  MYHomeSearchViewController.m
//  MaiYou
//
//  Created by bm on 2017/3/17.
//  Copyright © 2017年 PengJiawei. All rights reserved.
//

#import "TZHomeSearchView.h"
#import "SearchItemCell.h"
#import "SearchItemModel.h"
#import "SearchHeaderView.h"
#import "MYTitleView.h"
#import "EqualSpaceFlowLayoutEvolve.h"

@interface TZHomeSearchView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITextFieldDelegate>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) EqualSpaceFlowLayoutEvolve *flowLayout;
@property (nonatomic,strong) NSMutableArray *modelArray;
@property (nonatomic,strong) NSMutableArray *searchResultArray;
@property (nonatomic,assign) NSInteger pageSize;
@property (nonatomic,assign) NSInteger pageNo;
@property (nonatomic,copy)   NSString *keyWord;

@property(nonatomic,strong) UIImageView *noGoodsImageView;

@end

@implementation TZHomeSearchView

- (UICollectionView *)collectionView{
    if (_collectionView == nil) {
        _flowLayout = [[EqualSpaceFlowLayoutEvolve alloc] initWthType:AlignWithLeft];
        _flowLayout.betweenOfCell = 0;
        _flowLayout.minimumLineSpacing = 15;
        _flowLayout.minimumInteritemSpacing = 10;
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _flowLayout.headerReferenceSize = CGSizeMake(SCREEN_WIDTH, 34);
        _flowLayout.footerReferenceSize = CGSizeMake(SCREEN_WIDTH, 5);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64) collectionViewLayout:_flowLayout];
        [self addSubview:_collectionView];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[SearchItemCell class] forCellWithReuseIdentifier:NSStringFromClass([SearchItemCell class])];
        [_collectionView registerClass:[SearchHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([SearchHeaderView class])];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer"];
    }
    return _collectionView;
}

- (void)initSearchView{
    UIView *searchView = [MYBaseView viewWithFrame:CGRectZero backgroundColor:[UIColor colorWithHexString:@"#eeeeee" alpha:1.0]];
    [self addSubview:searchView];
    [searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.top.equalTo(self).offset(27);
        make.height.mas_equalTo(30);
        make.right.equalTo(self.mas_right).offset(-60);
    }];
    searchView.layer.cornerRadius = 15;
    
    UIImageView *searchImageView = [MYBaseView imageViewWithFrame:CGRectZero andImage:[UIImage imageNamed:@"组1"]];
    [searchView addSubview:searchImageView];
    [searchImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(searchView).offset(15);
        make.centerY.equalTo(searchView);
        make.width.height.mas_equalTo(15);
    }];
    
    UIButton *deleteButton = [MYBaseView buttonWithFrame:CGRectZero buttonType:UIButtonTypeCustom image:[UIImage imageNamed:@"椭圆1"] selectImage:nil];
    [searchView addSubview:deleteButton];
    [deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(searchView.mas_right).offset(-10);
        make.centerY.equalTo(searchView);
        make.width.height.mas_equalTo(14);
    }];
    [deleteButton addTarget:self action:@selector(deleteInput) forControlEvents:UIControlEventTouchUpInside];
    deleteButton.hitTestEdgeInsets = UIEdgeInsetsMake(0, 0, -20, -20);
    
    self.textfield = [MYBaseView textFieldWithFrame:CGRectZero text:nil textColor:[UIColor blackColor] textAlignment:NSTextAlignmentLeft andFontSize:13 placeholder:@"搜索商品" style:UITextBorderStyleNone];
    [searchView addSubview:self.textfield];
    [self.textfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(searchImageView.mas_right).offset(10);
        make.centerY.equalTo(searchView);
        make.right.equalTo(deleteButton.mas_left).offset(-5);
    }];
    self.textfield.returnKeyType = UIReturnKeySearch;
    self.textfield.delegate = self;
    
    UIButton *cancelBtn = [MYBaseView buttonWithFrame:CGRectZero buttonType:UIButtonTypeCustom title:@"取消" titleColor:[UIColor colorWithHexString:TZ_BLACK alpha:1.0] font:kFont(15)];
    [self addSubview:cancelBtn];
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self);
        make.centerY.equalTo(searchView);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(30);
    }];
    [cancelBtn addTarget:self action:@selector(cancelSearch) forControlEvents:UIControlEventTouchUpInside];
}

- (NSMutableArray *)modelArray{
    if (_modelArray == nil) {
        _modelArray = [NSMutableArray array];
        NSString *cachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
        NSString *filePath = [cachePath stringByAppendingString:@"searchProduct.plist"];
        NSMutableArray *keyWordArray = [NSMutableArray arrayWithContentsOfFile:filePath];
        for (int i = 0 ;i < keyWordArray.count; i++){
            SearchItemModel *model = [[SearchItemModel alloc] init];
            model.name = keyWordArray[i];
            CGSize  size = [keyWordArray[i] boundingRectWithSize:CGSizeMake(MAXFLOAT, 29)  options:(NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin)   attributes:@{NSFontAttributeName: kFont(12)} context:nil].size;
            model.width = size.width + 20;
            [_modelArray addObject:model];
        }
    }
    return _modelArray;
}

- (void)cancelSearch{
    [self.textfield resignFirstResponder];
    if (self.cancelBlock) {
        self.cancelBlock();
    }
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self initSearchView];
        [self modelArray];
        [self collectionView];
    }
    return self;
}

- (void)loadSearchRecord{
    [_modelArray removeAllObjects];
    NSString *cachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
    NSString *filePath = [cachePath stringByAppendingString:@"searchProduct.plist"];
    NSMutableArray *keyWordArray = [NSMutableArray arrayWithContentsOfFile:filePath];
    for (int i = 0 ;i < keyWordArray.count; i++){
        SearchItemModel *model = [[SearchItemModel alloc] init];
        model.name = keyWordArray[i];
        CGSize  size = [keyWordArray[i] boundingRectWithSize:CGSizeMake(MAXFLOAT, 29)  options:(NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin)   attributes:@{NSFontAttributeName: kFont(12)} context:nil].size;
        model.width = size.width + 20;
        [_modelArray addObject:model];
    }
    [_collectionView reloadData];
}

#pragma mark - collectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0) {
        return self.modelArray.count;
    }
    return self.modelArray.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    SearchItemModel *model = self.modelArray[indexPath.row];
    if (model.width) {
        if (model.width+10 >= SCREEN_WIDTH) {
            return CGSizeMake(SCREEN_WIDTH-10, 30);
        }
        return CGSizeMake(model.width+10, 30);
    }
    return CGSizeMake(50, 30);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(SCREEN_WIDTH, 50);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if (kind == UICollectionElementKindSectionHeader){
        SearchHeaderView *headerView = (SearchHeaderView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([SearchHeaderView class]) forIndexPath:indexPath];
        if (indexPath.section == 0) {
            headerView.titleLabel.text = @"历史搜索";
            headerView.iconButton.hidden = NO;
        }else{
            headerView.iconButton.hidden = YES;
            headerView.titleLabel.text = @"热门搜索";
        }
        [headerView setDeleteBlock:^{//删除搜索历史
            NSString *cachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
            NSString *filePath = [cachePath stringByAppendingString:@"searchProduct.plist"];
            NSMutableArray *keyWordArray = [NSMutableArray arrayWithContentsOfFile:filePath];
            [keyWordArray removeAllObjects];
            [keyWordArray writeToFile:filePath atomically:YES];
            [_modelArray removeAllObjects];
            [_collectionView reloadData];
        }];
        return headerView;
    }else{
        UICollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer" forIndexPath:indexPath];
        return footerView;
    }
    return nil;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SearchItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([SearchItemCell class]) forIndexPath:indexPath];
    [cell setCellInfoWithModel:self.modelArray[indexPath.row]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    SearchItemCell *itemCell = (SearchItemCell *)cell;
    SearchItemModel *model = self.modelArray[indexPath.row];
    model.width = [itemCell cellItemWidth];
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsZero;
}

#pragma mark - collectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self.textfield resignFirstResponder];
    SearchItemModel *model = self.modelArray[indexPath.row];
    if (self.searchBlock) {
        self.searchBlock(model.name);
    }
}

#pragma mark - textFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField.text.length == 0) {
        return YES;
    }
    _pageNo = 1;
    _pageSize = 20;
    _keyWord = self.textfield.text;
    [self.searchResultArray removeAllObjects];
    [textField resignFirstResponder];
    [self searchProductWithKeyWord:self.textfield.text];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self cacheKeyWord];
    });
    return YES;
}

- (void)searchProductWithKeyWord:(NSString *)keyWord{
    //BMRequest *request = [BMRequest requestWithPath:@"app/product/getAllProducts.htm" contentKey:@"products"];
    
    if (![keyWord isExist]){
        return;
    }
    if (self.searchBlock) {
        self.searchBlock(keyWord);
    }
}

- (void)deleteInput{
    self.textfield.text = @"";
}

- (void)cacheKeyWord{
    NSString *cachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
    NSString *filePath = [cachePath stringByAppendingString:@"searchProduct.plist"];
    NSMutableArray *keyWordArray = [NSMutableArray arrayWithContentsOfFile:filePath];
    if (keyWordArray != nil) {
        if (![keyWordArray containsObject:_keyWord]) {
            if (keyWordArray.count == 10) {
                [keyWordArray removeLastObject];
                [keyWordArray addObject:_keyWord];
            }else{
                [keyWordArray addObject:_keyWord];
            }
            [keyWordArray writeToFile:filePath atomically:YES];
        }
    }else{
        keyWordArray = [NSMutableArray array];
        [keyWordArray addObject:_keyWord];
        [keyWordArray writeToFile:filePath atomically:YES];
    }
}


@end
