//
//  ComDetailFirstCell.m
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/22.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "ComDetailFirstCell.h"

@implementation ComDetailFirstCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(CommunityDetailModel *)model {
    
    _model = model;
    [self.headicon setImageWithURL:[NSURL URLWithString:model.headicon] placeholderImage:nil];
    self.nickname.text = model.nickname;
    self.title.text = model.title;
    self.createtime.text = model.createtime;
    self.browsenums.text = [NSString stringWithFormat:@"%@人读过",model.browsenums];
    
    
}
// 关注按钮
- (IBAction)attenAction:(UIButton *)sender {
    
    if (self.model.attenStaus == 0) {
        self.model.attenStaus = 1;
    }else {
        self.attenStatus.titleLabel.text = @"已关注";
    }
    
}




@end
