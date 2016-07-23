//
//  ReplyTableViewCell.h
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/22.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReplyModel.h"
#define ReplyTableViewCell_Identify @"ReplyTableViewCell_Identify"
@interface ReplyTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImg;
@property (weak, nonatomic) IBOutlet UILabel *nicknameLabel;
@property (weak, nonatomic) IBOutlet UILabel *creatDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *foolLabel;
@property (weak, nonatomic) IBOutlet UILabel *contextLabel;

@property (strong, nonatomic) ReplyModel *model;


@end
