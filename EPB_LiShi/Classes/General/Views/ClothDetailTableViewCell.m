//
//  ClothDetailTableViewCell.m
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/19.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "ClothDetailTableViewCell.h"

@implementation ClothDetailTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(FLClothModel *)model
{
    _model = model;
    [self.headImage setImageWithURL:[NSURL URLWithString:model.headicon]];
    self.nickname.text = model.nickname;
    self.title.text = model.title;
    self.startTime.text = model.createdate;
    self.visits.text = [NSString stringWithFormat:@"%ld",(long)model.visits];
    if (model.days == 0) {
        self.state.text = @"已过期";
        self.state1.text = @"已截止";
    }else if(model.days != 0)
    {
        self.state.text = @"报名";
        self.state1.text = [NSString stringWithFormat:@"还有%ld天结束",(long)model.days];
    }
}

@end
