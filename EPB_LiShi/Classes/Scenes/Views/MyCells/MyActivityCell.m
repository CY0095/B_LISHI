//
//  MyActivityCell.m
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/30.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "MyActivityCell.h"

@implementation MyActivityCell

- (void)awakeFromNib {
    // Initialization code
    self.activityImg.layer.cornerRadius = 10;
    self.activityImg.layer.masksToBounds = YES;
}

-(void)setModel:(ActivityApplyModel *)model{
    if (_model != model) {
        _model = nil;
        _model = model;
    }
    [self.activityImg setImageWithURL:[NSURL URLWithString:model.imageStr]];
    self.contentLabel.text = model.activityTitle;
    self.activityID = model.activityID;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
