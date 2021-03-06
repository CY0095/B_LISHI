//
//  ToolsTableViewCell.m
//  tools
//
//  Created by lanou3g on 16/7/14.
//  Copyright © 2016年 杨旭东. All rights reserved.
//

#import "ToolsTableViewCell.h"


@implementation ToolsTableViewCell

- (void)awakeFromNib {
    // Initialization code
    // 设置账号标签的边框宽度为1
    self.type.layer.borderWidth = 1;
    // 设置账号标签边框的弧度为5
    self.type.layer.cornerRadius = 15;
    //设置边框的颜色
    self.type.layer.borderColor = [UIColor blackColor].CGColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//- (IBAction)clickButton:(id)sender {
//    
//    if (_delegate && [_delegate respondsToSelector:@selector(toolClickButton:)]) {
//        [_delegate toolClickButton:self];
//    }
//    
//}

- (void)setJfmodel:(JFModel *)jfmodel
{
    _jfmodel = jfmodel;
    self.title.text = jfmodel.title;
    self.content.text = jfmodel.content;
    [self.ImgView setImageWithURL:[NSURL URLWithString:jfmodel.images]];
    self.price.text = [NSString stringWithFormat:@"%@积分",jfmodel.integral];
    self.price.textAlignment = NSTextAlignmentCenter;
    self.type.text = @"申请兑换";
    self.type.textColor = [UIColor blueColor];
}

- (void)setFlmodel:(FLModel *)flmodel
{
    _flmodel = flmodel;
    self.title.text = flmodel.title;
    self.content.text = flmodel.content;
    [self.ImgView setImageWithURL:[NSURL URLWithString:flmodel.images]];
    self.price.text = [NSString stringWithFormat:@"市场价:%@元",flmodel.market_price];
    self.type.text = @"免费使用";
    self.type.textColor = [UIColor blueColor];
}

@end
