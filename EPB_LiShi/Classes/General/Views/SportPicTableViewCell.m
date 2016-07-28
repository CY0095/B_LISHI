//
//  SportPicTableViewCell.m
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/27.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "SportPicTableViewCell.h"

@implementation SportPicTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(zhuangBeiPicModel *)model
{
    _model = model;
    [self.Img setImageWithURL:[NSURL URLWithString:model.images]];
}

@end
