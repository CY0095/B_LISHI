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

//计算cell整体的高度
+ (CGFloat)cellHeight:(LuyingListModel *)model {
    
    // cell固定部分的高度（代指实际开发中不要自适应，有固定高度的控件和间隙所共同占有高度的总和）
    CGFloat staticHeight = 166;
    // cell不固定部分的高度（需要自适应，因内容而变换的控件的高度）
    CGFloat dynamicHeight = ((kScreenWidth - 40)/3.0)*2;
    // cell的高度等于固定的部分 + 变化的部分
    return staticHeight + dynamicHeight;
    
}

@end
