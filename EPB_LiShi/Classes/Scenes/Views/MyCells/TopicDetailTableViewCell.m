//
//  TopicDetailTableViewCell.m
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/22.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "TopicDetailTableViewCell.h"

@implementation TopicDetailTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self drawView];
    }
    return self;
}
-(void)drawView{
    self.contextLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, WindownWidth - 20, 30)];
    self.contextLabel.font = [UIFont systemFontOfSize:15.0];
    
    [self.contentView addSubview:self.contextLabel];
    self.images = [[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.contextLabel.frame) + 10, WindownWidth, 200)];
    
    [self.contentView addSubview:self.images];
}

-(void)setModel:(TopicsDetailModel *)model{
    if (_model != model) {
        _model = nil;
        _model = model;
    }
    self.contextLabel.text = model.content;
    CGFloat dynamicHeight = [[self class] textHeightFromMode:model];
    // 设置label的高
    CGRect rect = self.contextLabel.frame;
    rect.size.height = dynamicHeight;
    self.contextLabel.frame = rect;
    
    self.contextLabel.numberOfLines = 0;
    // 注意：若自适应计算出高度重新赋值就不用在执行[self.contextLabel sizeToFit]方法
    // [self.contextLabel sizeToFit];
    if (model.images != nil) {
        [self.images setImageWithURL:[NSURL URLWithString:model.images]];
        // 设定照片的高
        if (model.images_width != 0 && model.images_height != 0) {
            CGFloat imageHeight = WindownWidth * model.images_height / model.images_width;
            CGRect imgRect = self.images.frame;
            imgRect.size.height = imageHeight;
            imgRect.origin.y = CGRectGetMaxY(self.contextLabel.frame) + 10;
            self.images.frame = imgRect;
        }else{
            [self.images removeFromSuperview];
        }
        
    }else{
        [self.images removeFromSuperview];
    }
    
}


- (void)awakeFromNib {
    // Initialization code
}


+(CGFloat)cellHeight:(TopicsDetailModel *)model{
    CGFloat staticHeight = 25;
    CGFloat dynamicHeight = [self textHeightFromMode:model];
    CGFloat imgHeight = 0;
    if (model.images_height != 0 && model.images_width != 0) {
        imgHeight = WindownWidth * model.images_height / model.images_width;
    }else{
        imgHeight = 0;
    }
    
    return dynamicHeight + staticHeight + imgHeight;
}

+(CGFloat)textHeightFromMode:(TopicsDetailModel *)model{
    CGRect rect = [model.content boundingRectWithSize:CGSizeMake(WindownWidth - 20, 736) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15.0]} context:nil];
    return rect.size.height;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
