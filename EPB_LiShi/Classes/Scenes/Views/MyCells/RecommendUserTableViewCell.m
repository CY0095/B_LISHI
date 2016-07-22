//
//  RecommendUserTableViewCell.m
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/19.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "RecommendUserTableViewCell.h"

@implementation RecommendUserTableViewCell

- (void)awakeFromNib {
    self.backView.layer.cornerRadius = 10;
    self.backView.layer.masksToBounds = YES;
    self.headImg.layer.cornerRadius = 10;
    self.headImg.layer.masksToBounds = YES;
    self.attmentionBtn.layer.borderColor = [UIColor greenColor].CGColor;
}

-(void)setModel:(MyAttentionModel *)model{
    if (_model != model) {
        _model = nil;
        _model = model;
    }
    [self.headImg setImageWithURL:[NSURL URLWithString:model.headicon]];
    self.titleLabel.text = model.topic_title;
    self.nickName.text = model.nickname;
    self.cellID = model.user_id;
}

// 关注按钮方法
- (IBAction)attmentionAction:(id)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(recommendUserTableViewAttentionBtnClicked:)]) {
        [_delegate recommendUserTableViewAttentionBtnClicked:self];
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
