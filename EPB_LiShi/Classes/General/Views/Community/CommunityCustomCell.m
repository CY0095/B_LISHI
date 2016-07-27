//
//  CommunityCustomCell.m
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/23.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "CommunityCustomCell.h"

@implementation CommunityCustomCell

- (void)awakeFromNib {
    // Initialization code
    self.image.layer.cornerRadius = 25;
    self.image.layer.masksToBounds = YES;
}

- (void)setModel:(CommunityCoCellModel *)model {
    
    _model = model;
    
    [self.image setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:nil];
    self.club_title.text = model.club_title;
    self.total.text = [NSString stringWithFormat:@"%@个话题",model.total];
    self.club_id = model.club_id;
    self.members = model.member;
    
}


@end
