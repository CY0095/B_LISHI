//
//  StarTimeTableViewCell.h
//  EPB_LiShi
//
//  Created by lanou3g on 16/8/2.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
#define StartTimeViewCell_Identify @"StartTimeViewCell_Identify"

@interface StarTimeTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *img;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;

@end
