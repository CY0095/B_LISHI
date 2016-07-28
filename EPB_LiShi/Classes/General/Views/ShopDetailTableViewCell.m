//
//  ShopDetailTableViewCell.m
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/27.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "ShopDetailTableViewCell.h"

@implementation ShopDetailTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)clickButton:(id)sender {
    
    if (_delegate && [_delegate respondsToSelector:@selector(buttonClick:)]) {
        [_delegate buttonClick:self];
    }
}


- (void)setModel:(ShopDetailModel *)model
{
    _model = model;
    self.gaode_latitude = model.gaode_latitude;
    self.gaode_longitude = model.gaode_longitude;
    self.titleLabel.text = model.title;
    self.phone = model.phone;
    [self.addressButton setTitle:model.address forState:(UIControlStateNormal)];
}

@end
