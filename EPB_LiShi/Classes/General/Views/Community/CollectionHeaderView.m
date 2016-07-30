//
//  CollectionHeaderView.m
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/30.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "CollectionHeaderView.h"

@implementation CollectionHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 100, 20)];
        
        [self addSubview:_titleLabel];
    }
    return self;
}


@end
