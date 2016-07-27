//
//  PostHeadViewCell.m
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/25.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "PostHeadViewCell.h"

@implementation PostHeadViewCell

- (void)awakeFromNib {
    // Initialization code
    self.contextLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 100, WindownWidth - 10, 30)];
    [self.contentView addSubview:self.contextLabel];
    self.imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WindownWidth, 100)];
    [self.contentView addSubview:self.imgView];
}

-(void)setModel:(PostHeadModel *)model{
    if (_model != model) {
        _model = nil;
        _model = model;
    }
    self.contextLabel.text = model.content;
    CGFloat dynamicHeight = [[self class] textHeightFromMode:model];
    
    self.contextLabel.frame = CGRectMake(5, 100, WindownWidth - 10, dynamicHeight);
    self.contextLabel.font = [UIFont systemFontOfSize:15.0];
    self.contextLabel.numberOfLines = 0;
    NSArray *imgArray = model.topic_image;
    NSString *images = [imgArray.firstObject objectForKey:@"image"];
    if (images.length !=0 ) {
        self.imgView.hidden = NO;
        self.imgView.frame = CGRectMake(0, CGRectGetMaxY(self.contextLabel.frame) + 10, WindownWidth, WindownWidth * 6 / 8);
        [self.imgView setImageWithURL:[NSURL URLWithString:images] placeholderImage:[UIImage imageNamed:@"imageLoad.jpg"]];
        
    }else{
        self.imgView.hidden = YES;
    }
    [self.headImg setImageWithURL:[NSURL URLWithString:model.headicon]];
    self.titleLabel.text = model.title;
    self.creatTimeLabel.text = model.createdate;
    self.chakanLabel.text = [NSString stringWithFormat:@"%ld",model.visits];
    self.nicknameLabel.text = model.nickname;
    
    
}
+(CGFloat)cellHeight:(PostHeadModel *)model{
    CGFloat staticHeight = 140;
    CGFloat dynamicHeight = [self textHeightFromMode:model];
    CGFloat imgHeight = 0;
    NSArray *imgArray = model.topic_image;
    NSString *images = [imgArray.firstObject objectForKey:@"image"];
    if (images.length != 0) {
        imgHeight = WindownWidth * 6 / 8;
    }
    return dynamicHeight + staticHeight + imgHeight;
}

+(CGFloat)textHeightFromMode:(PostHeadModel *)model{
    CGRect rect = [model.content boundingRectWithSize:CGSizeMake(WindownWidth - 20, 736) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15.0]} context:nil];
    return rect.size.height;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
