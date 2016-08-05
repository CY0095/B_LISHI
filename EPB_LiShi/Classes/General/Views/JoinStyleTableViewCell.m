//
//  JoinStyleTableViewCell.m
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/21.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "JoinStyleTableViewCell.h"

@implementation JoinStyleTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    self.attendContent.numberOfLines = 0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(JoinStyleModel *)model
{
    if (_model != model) {
        _model = nil;
        _model = model;
    }
    self.attendContent.text = model.activeDesc;
    [self.attendShareImage setImageWithURL:[NSURL URLWithString:model.activeFileUrl]];
    
    //获取当前model的hobby属性在给定条件下的高度
    //动态高度
    CGFloat dynamicHeight = [[self class]textHeightFroMode:model];
    
    //UI控件位置和大小的结构体无法整体赋值，所以可以通过中间变量来转化
    CGRect rect = self.attendContent.frame;
    rect.size.height = dynamicHeight;
    self.attendContent.frame = rect;
}

//计算cell整体的高度
+(CGFloat)cellHeight:(JoinStyleModel *)model
{
    //cell固定部分的高度（代指实际开发中不要自适应，有固定高度的控件和间隙所共同占有的高度总和）
    CGFloat staticHeight = 30;
    //cell不固定部分的高度（需要自适应，因内容而变换控件的高）
    CGFloat dynamicHeight = [self textHeightFroMode:model];
    //cell的高度等于固定的部分 + 变化的部分
    return staticHeight + dynamicHeight;
    
}

//计算文本高度
+(CGFloat)textHeightFroMode:(JoinStyleModel *)model
{
    
    //参数
    //size:第一个值是表示在文本给定的宽度条件下计算，第二个值是到达给定值以后不再自适应
    //option: 固定参数NSStringDrawingUsesLineFragmentOrigin
    //attributes:一个字典，存储着字符串的属性，影响高度 的计算只有字体大小，所以这里传一个描述字体的字典（系统默认字体为17.0）
    //context: nil，不许需要任何参数
    
    CGRect rect = [model.activeDesc boundingRectWithSize:CGSizeMake(WindownWidth - 20,500) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:17.0]} context:nil];
    //返回计算的高度
    return rect.size.height;
    
}



@end
