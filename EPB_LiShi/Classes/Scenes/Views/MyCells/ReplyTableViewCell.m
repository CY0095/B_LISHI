//
//  ReplyTableViewCell.m
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/22.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "ReplyTableViewCell.h"

@implementation ReplyTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)setModel:(ReplyModel *)model{
    if (_model != model) {
        _model = nil;
        _model = model;
    }
    [self.headImg setImageWithURL:[NSURL URLWithString:model.headicon]];
    self.nicknameLabel.text = model.nickname;
    self.creatDateLabel.text = model.createtime;
    self.contextLabel.text = model.content;
    self.foolLabel.text = [NSString stringWithFormat:@"%@楼",model.floor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
