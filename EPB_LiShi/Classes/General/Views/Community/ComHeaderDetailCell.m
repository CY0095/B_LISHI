//
//  ComHeaderDetailCell.m
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/26.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "ComHeaderDetailCell.h"

@implementation ComHeaderDetailCell

- (void)awakeFromNib {
    // Initialization code
    self.images.layer.cornerRadius = 25;
    self.images.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(CommunityHeaderModel *)model {
    
    _model = model;
    
    [self.images setImageWithURL:[NSURL URLWithString:model.images] placeholderImage:nil];
    self.title.text = model.title;
}


@end
