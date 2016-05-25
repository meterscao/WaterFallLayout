//
//  CollectionViewCell.m
//  layout
//
//  Created by meterscao on 16/5/23.
//  Copyright © 2016年 meters. All rights reserved.
//

#import "CollectionViewCell.h"

@implementation CollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.titleLabel = [[UILabel alloc]init];
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.font = [UIFont systemFontOfSize:32.f];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.titleLabel];
        self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.5f];

        self.layer.cornerRadius = 3.f;
        self.layer.masksToBounds = YES;
    }
    return self;
}
-(void)setTitleLabelText:(NSString *)title{

    self.titleLabel.text = title;
    [self setNeedsLayout];
}
-(void)layoutSubviews{

    [self.titleLabel sizeToFit];
    self.titleLabel.frame = CGRectMake(0, (self.bounds.size.height  - self.titleLabel.frame.size.height)/2, self.frame.size.width, self.titleLabel.frame.size.height);
}
@end
