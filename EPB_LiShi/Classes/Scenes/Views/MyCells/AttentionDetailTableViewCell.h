//
//  AttentionDetailTableViewCell.h
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/21.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PostMessageModel.h"
#define AttentionDetailTableViewCell_Identify @"AttentionDetailTableViewCell_Identify"

@interface AttentionDetailTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIImageView *headImg;
@property (weak, nonatomic) IBOutlet UILabel *fromClubLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *createdateLabel;

@property (strong, nonatomic) PostMessageModel *model;
@end
