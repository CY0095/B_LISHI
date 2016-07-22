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

@property (strong, nonatomic) IBOutlet UIImageView *activityTime;
@property (strong, nonatomic) IBOutlet UILabel *activityContent;
@property (strong, nonatomic) IBOutlet UIImageView *attendImage;
@property (strong, nonatomic) IBOutlet UILabel *attendContent;
@property (strong, nonatomic) IBOutlet UIImageView *attendShareImage;
@property (strong, nonatomic) IBOutlet UIImageView *awardTitleImage;
@property (strong, nonatomic) IBOutlet UILabel *awardContent;
@property (strong, nonatomic) IBOutlet UIImageView *awardImage;



@property (strong, nonatomic) JoinStyleModel *model;
@end
