//
//  WaterFallLayout.h
//  layout
//
//  Created by meterscao on 16/5/23.
//  Copyright © 2016年 meters. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WaterFallLayoutDelegate <NSObject>

@required
// 瀑布流视图每个元素的高度
// 必须实现的方法
-(CGFloat)collectionView:(UICollectionView *)collectionView heightOfItemAtIndexPath:(NSIndexPath *)indexPath;

@optional
// 瀑布流内容区域上下左右的边距
// 默认为 10,10,10,10
-(UIEdgeInsets)contentInsetsForCollectionView:(UICollectionView *)collectionView;

// 瀑布流视图需要展示的列数
// 默认为 2 列
-(int)columenCountsForCollectionView:(UICollectionView *)collectionView;;

// 瀑布流视图每列之间横向的间距
// 默认为 10
-(CGFloat)horizontalGapForCollectionView:(UICollectionView *)collectionView;

// 瀑布流视图每个元素之间纵向的间距
// 默认为 10
-(CGFloat)verticalGapForCollectionView:(UICollectionView *)collectionView;

@end



@interface WaterFallLayout : UICollectionViewLayout

@property (nonatomic) id<WaterFallLayoutDelegate> delegate;

@end
