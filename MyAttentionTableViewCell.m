//
//  MyAttentionTableViewCell.m
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/19.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "MyAttentionTableViewCell.h"

@implementation MyAttentionTableViewCell

- (void)awakeFromNib {
    self.backView.layer.cornerRadius = 10;
    self.backView.layer.masksToBounds = YES;
    self.headImg.layer.cornerRadius = 10;
    self.headImg.layer.masksToBounds = YES;
}

-(void)setModel:(MyAttentionModel *)model{
    if (_model != model) {
        _model = nil;
        _model = model;
    }

    [self.headImg setImageWithURL:[NSURL URLWithString:model.headicon]];
    self.titleLabel.text = model.topic_title;
    self.nickNameLabel.text = model.nickname;
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
