//
//  JoinStyleTableViewCell.m
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/21.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "JoinStyleTableViewCell.h"

@implementation JoinStyleTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(JoinStyleModel *)model
{
    _model = model;
    self.activityContent.text = model.times;
    self.attendContent.text = model.activeDesc;
    [self.attendShareImage setImageWithURL:[NSURL URLWithString:model.activeFileUrl]];
    self.awardContent.text = model.activeAward;
    [self.awardImage setImageWithURL:[NSURL URLWithString:model.awardFileUrl]];
}

@end
