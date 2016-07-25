//
//  ActivityIntroduceTableViewCell.h
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/21.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActivityIntroduceModel.h"


#define ActivityIntroduceTableViewCell_Identify  @"ActivityIntroduceTableViewCell_Identify"

@interface ActivityIntroduceTableViewCell : UITableViewCell

@property(strong,nonatomic) UILabel *titleLabel;
@property(strong,nonatomic) UIImageView *introduceImgView;

@property(strong,nonatomic) ActivityIntroduceModel *model;
// 计算当前cell实际需要的高度
+(CGFloat)cellHeight:(ActivityIntroduceModel *)model;

@end
