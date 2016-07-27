//
//  BuySportTableViewCell.m
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/25.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "BuySportTableViewCell.h"

@implementation BuySportTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [self.backButton setImage:[UIImage imageNamed:@"左箭头"] forState:(UIControlStateNormal)];
    self.backButton.backgroundColor = [UIColor blackColor];
    self.backButton.alpha = 0.7;
    self.backButton.layer.cornerRadius = 15;
    self.backButton.layer.masksToBounds = YES;
    
    [self.shareButton setImage:[UIImage imageNamed:@"分享"] forState:(UIControlStateNormal)];
    self.shareButton.backgroundColor = [UIColor blackColor];
    self.shareButton.alpha = 0.7;
    self.shareButton.layer.cornerRadius = 15;
    self.shareButton.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)backClick:(id)sender {
    
    if (_delegate && [_delegate respondsToSelector:@selector(backButtonClick:)]) {
        [_delegate backButtonClick:self];
    }
}

- (IBAction)shareButtonClick:(id)sender {
    
    if (_shareDelegate && [_shareDelegate respondsToSelector:@selector(shareButtonClick:)]) {
        [_shareDelegate shareButtonClick:self];
    }
}


- (void)setModel:(BuySportModel *)model
{
    _model = model;
    [self.img setImageWithURL:[NSURL URLWithString:model.thumb]];
    self.title.text = model.title;
    self.price.text = [NSString stringWithFormat:@"市场价格:￥%0.2f",model.market_price];
    self.content.text = model.Sportdescription;
}

@end
