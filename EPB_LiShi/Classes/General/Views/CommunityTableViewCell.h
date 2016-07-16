//
//  CommunityTableViewCell.h
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/14.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommunityListModel.h"
#define CommunityTableViewCell_Identify @"CommunityTableViewCell_Identify"

@interface CommunityTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nicknameLabel;

@property (weak, nonatomic) IBOutlet UIImageView *headiconImg;

@property (weak, nonatomic) IBOutlet UIButton *attentionBtn;

@property (weak, nonatomic) IBOutlet UIImageView *communityImg;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *replyNumLabel;

@property (nonatomic, strong) CommunityListModel *model;

@end
