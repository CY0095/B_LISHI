//
//  CommunityTableViewCell.m
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/14.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "CommunityTableViewCell.h"

@implementation CommunityTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



//@property (weak, nonatomic) IBOutlet UILabel *replyNumLabel;

- (void)setModel:(CommunityListModel *)model {
    
    _model = model;
    self.titleLabel.text = model.title;
    self.nicknameLabel.text = model.nickname;
    [self.headiconImg setImageWithURL:[NSURL URLWithString:model.headicon] placeholderImage:nil];
    [self.communityImg setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:nil];
    self.replyNumLabel.text = [NSString stringWithFormat:@"%@则回复",model.reply_num];
    
}


@end
