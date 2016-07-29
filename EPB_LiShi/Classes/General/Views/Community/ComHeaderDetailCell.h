//
//  ComHeaderDetailCell.h
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/26.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommunityHeaderModel.h"

#define ComHeaderDetailCell_Identify @"ComHeaderDetailCell_Identify"
@interface ComHeaderDetailCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *images;

@property (weak, nonatomic) IBOutlet UILabel *title;

@property (nonatomic, strong) CommunityHeaderModel *model;

@end
