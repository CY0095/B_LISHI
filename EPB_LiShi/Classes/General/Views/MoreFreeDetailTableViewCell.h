//
//  MoreFreeDetailTableViewCell.h
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/23.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
#define moreFreeViewCell_Identify @"moreFreeViewCell_Identify"
#import "MoreFreeDetailModel.h"

@interface MoreFreeDetailTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UIImageView *headiconImg;
@property (strong, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *replytotalLabel;
@property (strong, nonatomic) IBOutlet UIImageView *img1;
@property (strong, nonatomic) IBOutlet UIImageView *img2;
@property (strong, nonatomic) IBOutlet UIImageView *img3;

@property (strong, nonatomic) MoreFreeDetailModel *model;

@end
