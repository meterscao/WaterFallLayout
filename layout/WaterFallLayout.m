//
//  WaterFallLayout.m
//  layout
//
//  Created by meterscao on 16/5/23.
//  Copyright © 2016年 meters. All rights reserved.
//

#import "WaterFallLayout.h"
#import "CollectionViewCell.h"

@interface WaterFallLayout ()

@property (nonatomic) UIEdgeInsets contentInsets;

@property (nonatomic) int columnCounts;
@property (nonatomic) CGFloat columnWidth;

@property (nonatomic) CGFloat gapHorizontal;
@property (nonatomic) CGFloat gapVertical;

@property (nonatomic) NSMutableArray *YArray;

@property (nonatomic) CGFloat containerWidth;

@end

@implementation WaterFallLayout

#pragma mark - 基本实现
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}


-(void)prepareLayout{
    
    [super prepareLayout];
    
    [self initConfit];
    
    
    // 计算出各个尺寸
    self.containerWidth = self.collectionView.frame.size.width ;
    
    self.YArray =  [[NSMutableArray alloc]initWithCapacity:self.columnCounts];
    
    for (int index = 0; index < self.columnCounts; index ++) {
        self.YArray[index] = @(self.contentInsets.top);
    }
    
    self.columnWidth = ( self.containerWidth - self.contentInsets.left - self.contentInsets.right - self.gapHorizontal * (self.columnCounts - 1)) / self.columnCounts;
    
}

// 返回当前瀑布流视图整个内容区域的高度
-(CGSize)collectionViewContentSize{
    
    return CGSizeMake(self.containerWidth,
                      [self.YArray[[self indexOfMaxY]] floatValue] - self.gapVertical + self.contentInsets.bottom);
}

-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{

    NSMutableArray *layoutAttibutes = [[NSMutableArray alloc]init];
    
    for (int i = 0 ; i < [self.collectionView numberOfItemsInSection:0]; i ++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        [layoutAttibutes addObject:[self layoutAttributesForItemAtIndexPath:indexPath]];
    }
    
    return layoutAttibutes;

}

-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat x,y,itemWidth,itemHeight;
    
    int index = [self indexOfMinY];
    
    x = [self XOfColumn:index];
    y = [self.YArray[index] floatValue];
    itemWidth =  self.columnWidth;
    itemHeight = [self.delegate collectionView:self.collectionView heightOfItemAtIndexPath:indexPath];
    
    // 更新插入新的item之后，当前列的底部纵坐标
    self.YArray[index] = @(y + itemHeight + self.gapHorizontal);
   
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attributes.frame = CGRectMake(x, y, itemWidth, itemHeight);
    return attributes;

}


#pragma mark - 初始化
-(void)initConfit{
    // 初始化各项配置
    if ([self.delegate respondsToSelector:@selector(contentInsetsForCollectionView:)]) {
        self.contentInsets = [self.delegate contentInsetsForCollectionView:self.collectionView];
    }
    else{
        self.contentInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    }
    
    
    if ([self.delegate respondsToSelector:@selector(horizontalGapForCollectionView:)]) {
        self.gapHorizontal = [self.delegate horizontalGapForCollectionView:self.collectionView];
    }
    else{
        self.gapHorizontal = 10.f;
    }
    
    if ([self.delegate respondsToSelector:@selector(verticalGapForCollectionView:)]) {
        self.gapVertical = [self.delegate verticalGapForCollectionView:self.collectionView];
    }
    else{
        self.gapVertical = 10.f;
    }
    
    
    if ([self.delegate respondsToSelector:@selector(columenCountsForCollectionView:)]) {
        self.columnCounts = [self.delegate columenCountsForCollectionView:self.collectionView];
    }
    else{
        self.columnCounts = 2;
    }

}

#pragma mark - 工具函数

// 计算当前列的横坐标
-(CGFloat)XOfColumn:(int)index{
    
    return self.contentInsets.left + (self.columnWidth + self.gapHorizontal)*index;
    
}


// 筛选出当前纵坐标最小的列，用以确定新的item插入到哪一列
-(int)indexOfMinY{
    
    int resultIndex = 0;
    CGFloat minY = [self.YArray[0] floatValue];
    
    for (int index = 1; index < self.columnCounts; index ++ ) {
        if([self.YArray[index] floatValue] < minY ){
            minY = [self.YArray[index] floatValue];
            resultIndex = index;
        }
    }
    
    return resultIndex;
}


// 筛选出当前纵坐标最大的列，用以确定整个视图的高度
-(int)indexOfMaxY{
    int resultIndex = 0;
    CGFloat maxY = [self.YArray[0] floatValue];
    
    for (int index = 1; index < self.columnCounts; index ++ ) {
        if([self.YArray[index] floatValue] > maxY ){
            maxY = [self.YArray[index] floatValue];
            resultIndex = index;
        }
    }
    return resultIndex;
}


@end
