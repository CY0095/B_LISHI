//
//  JoinStyleTableViewCell.h
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/21.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
#define joinStyleViewCell_Identify @"joinStyleViewCell_Identify"
#import "JoinStyleModel.h"

@interface JoinStyleTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *attendImage;
@property (strong, nonatomic) IBOutlet UILabel *attendContent;
@property (strong, nonatomic) IBOutlet UIImageView *attendShareImage;
@property (strong, nonatomic) IBOutlet UIView *bottomView;


@property (strong, nonatomic) JoinStyleModel *model;

//计算当前cell实际需要的高度
+(CGFloat)cellHeight:(JoinStyleModel *)model;

@end
