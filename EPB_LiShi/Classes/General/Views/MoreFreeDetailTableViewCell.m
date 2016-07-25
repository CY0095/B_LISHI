//
//  MoreFreeDetailTableViewCell.m
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/23.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "MoreFreeDetailTableViewCell.h"

@implementation MoreFreeDetailTableViewCell

- (void)awakeFromNib {
    // Initialization code
    // 设置账号标签的边框宽度为1
    self.img1.layer.borderWidth = 1;
    self.img2.layer.borderWidth = 1;
    self.img3.layer.borderWidth = 1;
    self.img1.layer.borderColor = [[UIColor grayColor]CGColor];
    self.img2.layer.borderColor = [[UIColor grayColor]CGColor];
    self.img3.layer.borderColor = [[UIColor grayColor]CGColor];
    // 设置账号标签边框的弧度为5
//    self.type.layer.cornerRadius = 15;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(MoreFreeDetailModel *)model
{
    _model = model;
    self.titleLabel.text = model.topic_title;
    [self.headiconImg setImageWithURL:[NSURL URLWithString:model.headicon]];
    self.nickNameLabel.text = model.nickname;
    self.replytotalLabel.text = [NSString stringWithFormat:@"%ld",(long)model.replytotal];
}



@end
