//
//  PostReplyViewCell.h
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/26.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PostReplyModel.h"
#define PostReplyViewCell_Identify @"PostReplyViewCell_Identify"
@interface PostReplyViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImg;
@property (weak, nonatomic) IBOutlet UILabel *nicknameLabel;
@property (weak, nonatomic) IBOutlet UILabel *creatTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *foolLabel;
@property (weak, nonatomic) IBOutlet UIView *replyView;
@property (weak, nonatomic) IBOutlet UILabel *reply_content;
@property (weak, nonatomic) IBOutlet UILabel *reply_fool;
@property (weak, nonatomic) IBOutlet UILabel *reply_nickname;

@property (strong, nonatomic) UIImageView *imgView;
@property (strong, nonatomic) UILabel *contentLabel;


@property (strong, nonatomic) PostReplyModel *model;

+(CGFloat)cellHeight:(PostReplyModel *)model;
@end
