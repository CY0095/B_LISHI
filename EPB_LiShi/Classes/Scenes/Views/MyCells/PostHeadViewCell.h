//
//  PostHeadViewCell.h
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/25.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PostHeadModel.h"
#define PostHeadViewCell_Identify @"PostHeadViewCell_Identify"
@interface PostHeadViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImg;
@property (weak, nonatomic) IBOutlet UILabel *nicknameLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (strong, nonatomic) UILabel *contextLabel;
@property (strong, nonatomic) UIImageView *imgView;

@property (weak, nonatomic) IBOutlet UILabel *creatTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *chakanLabel;

@property (strong, nonatomic) PostHeadModel *model;


+(CGFloat)cellHeight:(PostHeadModel *)model;
@end
