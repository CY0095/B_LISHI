//
//  CommunityLuyingVideoCell.m
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/18.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "CommunityLuyingVideoCell.h"

@implementation CommunityLuyingVideoCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(LuyingListModel *)model {
    
    _model = model;
    [self.headiconImg setImageWithURL:[NSURL URLWithString:model.headicon] placeholderImage:nil];
    self.nicknameLabel.text = model.nickname;
    self.titleLabel.text = model.title;
    self.contentLabel.text = model.content;
    [self.videoimg setImageWithURL:[NSURL URLWithString:model.videoimg] placeholderImage:nil];
    self.update_time.text = model.update_time;
    self.videoid = model.videoid;
    self.likeNum.text = [NSString stringWithFormat:@"%ld",model.likeNum];
    
}


@end
