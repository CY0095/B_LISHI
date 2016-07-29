//
//  PostReplyViewCell.m
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/26.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "PostReplyViewCell.h"

@implementation PostReplyViewCell

- (void)awakeFromNib {
    // Initialization code
    self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 60, WindownWidth - 20, 30)];
    self.contentLabel.font = [UIFont systemFontOfSize:15.0];
    [self.contentView addSubview:self.contentLabel];
    self.imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.contentLabel.frame) + 10, WindownWidth, WindownWidth * 6 / 8)];
    
    [self.contentView addSubview:self.imgView];
}

// model的setter方法
-(void)setModel:(PostReplyModel *)model{
    if (_model != model) {
        _model = nil;
        _model = model;
    }
    [self.headImg setImageWithURL:[NSURL URLWithString:model.headicon]];
    self.nicknameLabel.text = model.nickname;
    self.creatTimeLabel.text = model.createdate;
    self.foolLabel.text = [NSString stringWithFormat:@"%@楼",model.floor];
    self.club_id = model.club_id;
    self.replytopic_id = model.replytopic_id;
    if (model.reply_nickname.length != 0) {
        self.replyView.hidden = NO;
        self.reply_content.text = model.reply_content;
        self.reply_fool.text = [NSString stringWithFormat:@"%@楼",model.reply_floor];
        self.reply_nickname.text = [NSString stringWithFormat:@"@%@",model.reply_nickname];
        
        // 重新为contentLabel赋frame
        self.contentLabel.text = model.content;
        CGFloat dynamicHeight = [[self class] textHeightFromMode:model];
        self.contentLabel.frame = CGRectMake(10, CGRectGetMaxY(self.replyView.frame) + 10, WindownWidth - 20, dynamicHeight);
        self.contentLabel.numberOfLines = 0;
        
    }else{
        self.replyView.hidden = YES;
        self.contentLabel.text = model.content;
        // 重新为contentLabel赋frame
        CGFloat dynamicHeight = [[self class] textHeightFromMode:model];
        self.contentLabel.frame = CGRectMake(10, 60, WindownWidth - 20, dynamicHeight);
        self.contentLabel.numberOfLines = 0;
    }
    NSArray *imgArray = model.topic_image;
    NSString *images = [imgArray.firstObject objectForKey:@"image"];
    if (images.length !=0 ) {
        self.imgView.hidden = NO;
        self.imgView.frame = CGRectMake(0, CGRectGetMaxY(self.contentLabel.frame) + 10, WindownWidth, WindownWidth * 6 / 8);
        [self.imgView setImageWithURL:[NSURL URLWithString:images] placeholderImage:[UIImage imageNamed:@"imageLoad.jpg"]];
        
    }else{
        self.imgView.hidden = YES;
    }

    
    
}


+(CGFloat)cellHeight:(PostReplyModel *)model{
    CGFloat staticHeight = 130;
    CGFloat dynamicHeight = [self textHeightFromMode:model];
    CGFloat imgHeight = 0;
    NSArray *imgArray = model.topic_image;
    NSString *images = [imgArray.firstObject objectForKey:@"image"];
    if (images.length != 0) {
        imgHeight = WindownWidth * 6 / 8;
    }
    CGFloat replayHeight = 0;
    if (model.reply_nickname.length != 0) {
        replayHeight = 50;
    }
    return dynamicHeight + staticHeight + imgHeight + replayHeight;
}

+(CGFloat)textHeightFromMode:(PostReplyModel *)model{
    CGRect rect = [model.content boundingRectWithSize:CGSizeMake(WindownWidth - 20, 736) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15.0]} context:nil];
    return rect.size.height;
}
// 回复评论点击方法
- (IBAction)huifuAction:(id)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(PostReplyTableViewReplyBtnClicked:)]) {
        [_delegate PostReplyTableViewReplyBtnClicked:self];
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
