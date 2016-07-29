//
//  AttentionDetailTableViewCell.m
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/21.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "AttentionDetailTableViewCell.h"

@implementation AttentionDetailTableViewCell

- (void)awakeFromNib {
    
    self.headImg.layer.cornerRadius = 10;
    self.headImg.layer.masksToBounds = YES;
    self.backView.layer.cornerRadius = 5;
    self.backView.layer.masksToBounds = YES;
    
}
-(void)setModel:(PostMessageModel *)model{
    if (_model != model) {
        _model = nil;
        _model = model;
    }
    if (model.image) {
        [self.headImg setImageWithURL:[NSURL URLWithString:model.image]];
    }
    self.titleLabel.text = model.topic_title;
    self.fromClubLabel.text = [NSString stringWithFormat:@"来自 %@",model.club_title];
    self.createdateLabel.text = model.createdate;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
