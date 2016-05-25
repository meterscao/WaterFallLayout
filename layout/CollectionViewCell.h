//
//  CollectionViewCell.h
//  layout
//
//  Created by meterscao on 16/5/23.
//  Copyright © 2016年 meters. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionViewCell : UICollectionViewCell
@property (nonatomic) UILabel *titleLabel;
-(void)setTitleLabelText:(NSString *)title;
@end
