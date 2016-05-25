## WaterFallLayout

`WaterFallLayout`是一个轻量的，用来为`UICollectionView`生成瀑布流视图样式的布局框架。

![alt tag](https://github.com/hellometers/WaterFallLayout/images/waterfall-screenshot.png)

### 使用方法

初始化`UICollectionView`的布局：

	WaterFallLayout *waterfallLayout = [[WaterFallLayout alloc]init];
    waterfallLayout.delegate = self;

为`UICollectionView`指定其布局的框架：
	
    self.connectionView   =[[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:waterfallLayout];


须要在代码里面为`UICollectionView`实现以下委托：

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


