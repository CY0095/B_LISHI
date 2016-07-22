//
//  EquipDetailCollectionViewCell.m
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/19.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "EquipDetailCollectionViewCell.h"

@implementation EquipDetailCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void) setModel:(EquipDetailModel *)model
{
    _model = model;
    self.DetailTitle.text = model.title;
    [self.DetailImage setImageWithURL:[NSURL URLWithString:model.thumb]];
}

- (void)setModel1:(SportClothModel *)model1
{
    _model1 = model1;
    self.DetailTitle.text = model1.title;
    [self.DetailImage setImageWithURL:[NSURL URLWithString:model1.thumb]];
}

@end
