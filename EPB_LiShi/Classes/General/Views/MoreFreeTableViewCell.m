//
//  MoreFreeTableViewCell.m
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/23.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "MoreFreeTableViewCell.h"

@implementation MoreFreeTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    self.nameLabel.alpha = 0.7;
    self.nextClick.alpha = 0.7;
    [self.nextClick setImage:[UIImage imageNamed:@"左箭头"]forState:(UIControlStateNormal)];
    self.nextClick.layer.cornerRadius = 15;
    self.nextClick.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)buttonClick:(id)sender {
    
    if (_delegate && [_delegate respondsToSelector:@selector(freeClickButton:)]) {
        [_delegate freeClickButton:self];
    }
    
}


- (void)setModel:(MoreFreeModel *)model
{
    _model = model;
    [self.backImg setImageWithURL:[NSURL URLWithString:model.tag_images]];
    self.nameLabel.text = model.name;
}

@end
