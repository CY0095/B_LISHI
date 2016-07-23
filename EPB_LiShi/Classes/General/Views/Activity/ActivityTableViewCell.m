//
//  ActivityTableViewCell.m
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/15.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "ActivityTableViewCell.h"


@implementation ActivityTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(ActivityModel *)model{
    
    _model = model;
    
    self.activityIntroduce.text = [NSString stringWithFormat:@"%@·%@",model.harddesc,model.catename];
    self.activityTitle.text = model.title;
    
    [self.activityImgView setImageWithURL:[NSURL URLWithString:model.images]];
    
}





@end
