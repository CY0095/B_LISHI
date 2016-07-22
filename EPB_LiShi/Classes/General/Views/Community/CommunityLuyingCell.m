//
//  CommunityLuyingCell.m
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/18.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "CommunityLuyingCell.h"

#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@implementation CommunityLuyingCell

- (void)awakeFromNib {
    // Initialization code
    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(LuyingListModel *)model {
    
    _model = model;
    [self.headiconImg setImageWithURL:[NSURL URLWithString:model.headicon] placeholderImage:nil];
    self.nicknameLabel.text = model.nickname;
    self.titleLabel.text = model.title;
    self.contentLabel.text = model.content;
    self.update_time.text = model.update_time;
    self.likeNum.text = [NSString stringWithFormat:@"%ld",model.likeNum];

    NSArray *images = [NSArray arrayWithObjects:self.shareImg_0,self.shareImg_1,self.shareImg_2,self.shareImg_3,self.shareImg_4,self.shareImg_5, nil];
    for (int i = 0; i < model.images.count; i++) {
        
        [images[i] setImageWithURL:[NSURL URLWithString:[model.images[i] objectForKey:@"image"]] placeholderImage:nil];
        
    }
    
}



@end
