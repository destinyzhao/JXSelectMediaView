//
//  JXSelectMediaView.m
//  JXSelectMediaView
//
//  Created by Destiny on 2018/6/22.
//  Copyright © 2018年 Destiny. All rights reserved.
//

#import "JXSelectMediaView.h"
#import "UIView+JXExtend.h"
#import "JXMediaCell.h"

#define  JXMediaScreenWidth  [UIScreen mainScreen].bounds.size.width

@interface JXSelectMediaView ()<UICollectionViewDelegateFlowLayout, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, copy) JXMediaHeightBlock block;
@property (nonatomic, copy) JXAddMediaBlock addMediaBlock;
@property (nonatomic, copy) JXShowMediaBlock showMediaBlock;
@property (nonatomic, copy) JXDeleteMediaBlock deleteMediaBlock;

@end

@implementation JXSelectMediaView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.frame = CGRectMake(self.x, self.y, self.width, JXMediaScreenWidth/4);
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

///设置初始值
- (void)setup
{
    _showDelete = YES;
    _showAddButton = YES;
    _maxImageSelected = 9;
    _rowImageCount = 4;
    _lineSpacing = 10.0;
    _interitemSpacing = 10.0;
    _sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    [self configureCollectionView];
}

- (void)configureCollectionView
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    
    _collectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:layout];
    [_collectionView registerClass:[JXMediaCell class] forCellWithReuseIdentifier:NSStringFromClass([JXMediaCell class])];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = _backgroundColor;
    [self addSubview:_collectionView];
}

#pragma mark - setter
- (void)setRowImageCount:(NSInteger)rowImageCount {
    _rowImageCount = rowImageCount;
}

- (void)setLineSpacing:(CGFloat)lineSpacing {
    _lineSpacing = lineSpacing;
}

- (void)setInteritemSpacing:(CGFloat)interitemSpacing {
    _interitemSpacing = interitemSpacing;
}

- (void)setSectionInset:(UIEdgeInsets)sectionInset {
    _sectionInset = sectionInset;
}

- (void)setMediaArray:(NSMutableArray *)mediaArray
{
    _mediaArray = mediaArray;
    
    [self layoutCollection];
    
    [self.collectionView reloadData];
}

#pragma mark - public method
- (void)observeViewHeight:(JXMediaHeightBlock)value  addMedia:(JXAddMediaBlock)addMedia showMedia:(JXShowMediaBlock)showMedia deleteMedia:(JXDeleteMediaBlock)deleteMedia
{
    
    _block = value;
    _addMediaBlock = addMedia;
    _showMediaBlock = showMedia;
    _deleteMediaBlock = deleteMedia;
    
    [self layoutCollection];
}

#pragma mark -  Collection View DataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSInteger num = self.mediaArray.count < _maxImageSelected ? self.mediaArray.count : _maxImageSelected;
    //图片最大数不显示添加按钮
    if (num == _maxImageSelected) {
        return _maxImageSelected;
    }
    return _showAddButton ? num + 1 : num;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    JXMediaCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([JXMediaCell class]) forIndexPath:indexPath];
    if (indexPath.row == _mediaArray.count) {
       [cell showAddWithImage:self.addImage];
    }else{
        JXMediaModel *model = [[JXMediaModel alloc] init];
        model = _mediaArray[indexPath.row];
        
        if (model.imageUrlString) {
            [cell showIconWithUrlString:model.imageUrlString image:nil];
        }else {
            //这个地方可能会存在一个问题
            [cell showIconWithUrlString:nil image:model.image];
        }
      
        // 删除
        cell.JXMediaClickDeleteBlock = ^{
            
            if (self.deleteMediaBlock) {
                self.deleteMediaBlock(indexPath.row);
            }
        };
    }
    return cell;
}

#pragma mark - collection view delegate

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return self.lineSpacing;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return self.interitemSpacing;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat itemW = (self.width - self.sectionInset.left - (self.rowImageCount - 1) * self.interitemSpacing - self.sectionInset.right) / self.rowImageCount;
    return CGSizeMake(itemW, itemW);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return self.sectionInset;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    //点击的是添加媒体的按钮
    if (indexPath.row == _mediaArray.count) {
        if (self.addMediaBlock) {
            self.addMediaBlock();
        }
    }
    else{ //展示媒体
        if (self.showMediaBlock) {
            self.showMediaBlock(indexPath.row);
        }
    }
   
}

///计算高度，刷新collectionview，并返回相应的高度和数据
- (void)layoutCollection {
    NSInteger itemCount = _showAddButton ? _mediaArray.count + 1 : _mediaArray.count;
    //图片最大数也不显示添加按钮
    if (_mediaArray.count == _maxImageSelected && _showAddButton) {
        itemCount -= 1;
    }
    _collectionView.height = [self collectionHeightWithCount:itemCount];
    self.height = _collectionView.height;
    !_block ?  : _block(_collectionView.height);
    
    [_collectionView reloadData];
}

- (CGFloat)collectionHeightWithCount: (NSInteger)count
{
    NSInteger maxRow = count == 0 ? 0 : (count - 1) / self.rowImageCount + 1;
    CGFloat itemH = (self.width - self.sectionInset.left - (self.rowImageCount - 1) * self.interitemSpacing - self.sectionInset.right) / self.rowImageCount;
    CGFloat h = maxRow == 0 ? 0 : (maxRow * itemH + (maxRow - 1) * self.lineSpacing + self.sectionInset.top + self.sectionInset.bottom);
    return h;
}

@end
