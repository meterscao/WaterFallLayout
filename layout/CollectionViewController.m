//
//  ListViewController.m
//  layout
//
//  Created by meterscao on 16/5/23.
//  Copyright © 2016年 meters. All rights reserved.
//

#import "CollectionViewController.h"
#import "CollectionViewCell.h"
#import "WaterFallLayout.h"

@interface CollectionViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,WaterFallLayoutDelegate>
@property (nonatomic)UICollectionView *connectionView;

@property (nonatomic) NSMutableArray *heightList;

@end

@implementation CollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:1.f];
    // Do any additional setup after loading the view.
    
    
    // 包含了每一个元素高度的数据源
    self.heightList = [[NSMutableArray alloc]initWithCapacity:1];
    for (int index = 0; index < 20; index++) {
        [self.heightList addObject:@(arc4random()%200 + 100)];
    }

    
    WaterFallLayout *layout = [[WaterFallLayout alloc]init];
    layout.delegate = self;
    
    self.connectionView   =[[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
    self.connectionView.delegate = self;
    self.connectionView.dataSource = self;
    self.connectionView.backgroundColor =[UIColor clearColor];
    [self.view addSubview:self.connectionView];
    
    
    [self.connectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
        
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.connectionView.frame = self.view.bounds ;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.heightList.count;
    
}

-(CollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    
    CollectionViewCell *cell = (CollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    [cell setTitleLabelText:[NSString stringWithFormat:@"%ld",indexPath.row+1]];
    
    return cell;
    
}


#pragma mark - waterfall delegate

-(UIEdgeInsets)contentInsetsForCollectionView:(UICollectionView *)collectionView{

    return UIEdgeInsetsMake(20, 10, 10, 10);
}


-(CGFloat)horizontalGapForCollectionView:(UICollectionView *)collectionView{
    return 10.f;
}


-(CGFloat)verticalGapForCollectionView:(UICollectionView *)collectionView{
    return 10.f;
}

-(int)columenCountsForCollectionView:(UICollectionView *)collectionView{

    return 3;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView heightOfItemAtIndexPath:(NSIndexPath *)indexPath{
    return  [[self.heightList objectAtIndex:indexPath.row] floatValue];
}
@end
