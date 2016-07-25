//
//  ActivityTableViewCell.h
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/15.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActivityModel.h"
#define ActivityTableViewCell_Identify  @"ActivityTableViewCell_Identify"
@interface ActivityTableViewCell : UITableViewCell

//@property (weak, nonatomic) IBOutlet UIImageView *activityImgView;
//
//
//@property (weak, nonatomic) IBOutlet UILabel *activityIntroduce;
//
//
//@property (weak, nonatomic) IBOutlet UILabel *activityTitle;


@property (weak, nonatomic) IBOutlet UIImageView *activityImgView;


@property (weak, nonatomic) IBOutlet UILabel *activityIntroduce;

@property (weak, nonatomic) IBOutlet UILabel *activityTitle;

@property(strong,nonatomic) ActivityModel *model;

@end
