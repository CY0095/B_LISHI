//
//  ClothDetailTableViewCell.h
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/19.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
#define ClothDetailViewCell_Identify @"ClothDetailViewCell_Identify"
#import "FLClothModel.h"

@interface ClothDetailTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *headImage;
@property (strong, nonatomic) IBOutlet UILabel *nickname;
@property (strong, nonatomic) IBOutlet UIImageView *clothImage;
@property (strong, nonatomic) IBOutlet UILabel *title;
@property (strong, nonatomic) IBOutlet UILabel *state;
@property (strong, nonatomic) IBOutlet UILabel *state1;
@property (strong, nonatomic) IBOutlet UILabel *startTime;
@property (strong, nonatomic) IBOutlet UILabel *visits;

@property (strong, nonatomic) FLClothModel *model;

@end
