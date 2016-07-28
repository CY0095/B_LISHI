//
//  SportPicTableViewCell.h
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/27.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
#define sportPicViewCell_Identify @"sportPicViewCell_Identify"
#import "zhuangBeiPicModel.h"

@interface SportPicTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *Img;

@property (strong, nonatomic) zhuangBeiPicModel *model;

@end
