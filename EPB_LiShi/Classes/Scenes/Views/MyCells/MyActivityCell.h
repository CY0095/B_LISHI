//
//  MyActivityCell.h
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/30.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActivityApplyModel.h"
#define MyActivityCell_Identify @"MyActivityCell_Identify"
@interface MyActivityCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *activityImg;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@property (strong, nonatomic) NSString *activityID;
@property (strong, nonatomic) ActivityApplyModel *model;
@end
