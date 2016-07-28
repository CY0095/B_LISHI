//
//  ShopTableViewCell.m
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/26.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "ShopTableViewCell.h"

@implementation ShopTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(ShopModel *)model
{
    _model = model;
//    [self.shopImg setImageWithURL:[NSURL URLWithString:model.img]];
    self.titleLabel.text = model.title;
    self.addressLabel.text = model.address;
    self.distanceLabel.text = [NSString stringWithFormat:@"%@km",model.distance];
}

@end
