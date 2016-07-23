//
//  TopicDetailTableViewCell.h
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/22.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopicsDetailModel.h"
#define TopicDetailTableViewCell_Identify @"TopicDetailTableViewCell_Identify"
@interface TopicDetailTableViewCell : UITableViewCell
@property (strong, nonatomic) UILabel *contextLabel;
@property (strong, nonatomic) UIImageView *images;

@property (strong, nonatomic) TopicsDetailModel *model;

+(CGFloat)cellHeight:(TopicsDetailModel *)model;

@end
