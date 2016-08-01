//
//  CommunityLuyingVideoCell.h
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/18.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LuyingListModel.h"

#define CommunityLuyingVideoCell_Identify @"CommunityLuyingVideoCell_Identify"
@interface CommunityLuyingVideoCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *update_time;
@property (weak, nonatomic) IBOutlet UILabel *nicknameLabel;
@property (weak, nonatomic) IBOutlet UIButton *contentBtn;
@property (weak, nonatomic) IBOutlet UIImageView *headiconImg;
@property (weak, nonatomic) IBOutlet UIImageView *videoimg;
@property (weak, nonatomic) IBOutlet UILabel *likeNum;
@property (nonatomic, assign) NSInteger videoid;
@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) LuyingListModel *model;

@end
