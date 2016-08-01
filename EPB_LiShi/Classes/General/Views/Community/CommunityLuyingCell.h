//
//  CommunityLuyingCell.h
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/18.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LuyingListModel.h"

#define CommunityLuyingCell_Identify @"CommunityLuyingCell_Identify"
@interface CommunityLuyingCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *headiconImg;
@property (weak, nonatomic) IBOutlet UILabel *nicknameLabel;
@property (weak, nonatomic) IBOutlet UIButton *attentionBtn;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *shareImg_0;
@property (weak, nonatomic) IBOutlet UIImageView *shareImg_1;
@property (weak, nonatomic) IBOutlet UIImageView *shareImg_2;
@property (weak, nonatomic) IBOutlet UIImageView *shareImg_3;
@property (weak, nonatomic) IBOutlet UIImageView *shareImg_4;
@property (weak, nonatomic) IBOutlet UIImageView *shareImg_5;
@property (weak, nonatomic) IBOutlet UILabel *update_time;
@property (weak, nonatomic) IBOutlet UILabel *likeNum;
@property (weak, nonatomic) IBOutlet UIButton *likeBtn;
@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) LuyingListModel *model;
+ (CGFloat)cellHeight:(LuyingListModel *)model;
@end
