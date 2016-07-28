//
//  CommunityHeaderCell.m
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/19.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "CommunityHeaderCell.h"

@implementation CommunityHeaderCell

- (void)awakeFromNib {
    // Initialization code
    self.images.layer.cornerRadius = 25;
    self.images.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(CommunityHeaderModel *)model {
    
    _model = model;
    NSLog(@"%@",model.images);
    
    
    [self.images setImageWithURL:[NSURL URLWithString:model.images] placeholderImage:nil];
    self.club_id = model.club_id;
    self.title.text = model.title;
    self.members.text = [NSString stringWithFormat:@"%ld",model.members];
    self.descript.text = model.descript;
    NSArray *images = [NSArray arrayWithObjects:self.headicon0,self.headicon1,self.headicon2,self.headicon3,self.headicon4,self.headicon5, nil];
    for (int i = 0; i < model.moderator_list.count; i++) {
        
        [images[i] setImageWithURL:[NSURL URLWithString:[model.moderator_list[i] objectForKey:@"headicon"]] placeholderImage:nil];
        
    }
    
    
}


@end
