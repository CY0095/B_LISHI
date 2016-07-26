//
//  LikeNumCollectionViewCell.m
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/22.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "LikeNumCollectionViewCell.h"

@implementation LikeNumCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
    self.headImg.layer.cornerRadius = 11;
    self.headImg.layer.masksToBounds = YES;
}

- (void)setModel:(LikeListModel *)model
{
    [self.headImg setImageWithURL:[NSURL URLWithString:model.headicon]];
}

@end
