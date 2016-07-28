//
//  ComMiddleDetailCell.h
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/27.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommunityHeaderModel.h"

#define ComMiddleDetailCell_Identify @"ComMiddleDetailCell_Identify"
@interface ComMiddleDetailCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *citynameLabel;
@property (weak, nonatomic) IBOutlet UILabel *catenameLabel;
@property (weak, nonatomic) IBOutlet UILabel *createdateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *initheadicon;
@property (weak, nonatomic) IBOutlet UILabel *initnickname;

@property (weak, nonatomic) IBOutlet UIImageView *headicon_0;
@property (weak, nonatomic) IBOutlet UIImageView *headicon_1;
@property (weak, nonatomic) IBOutlet UIImageView *headicon_2;
@property (weak, nonatomic) IBOutlet UIImageView *headicon_3;
@property (weak, nonatomic) IBOutlet UIImageView *headicon_4;
@property (weak, nonatomic) IBOutlet UIImageView *headicon_5;

@property (weak, nonatomic) IBOutlet UILabel *nickname_0;
@property (weak, nonatomic) IBOutlet UILabel *nickname_1;
@property (weak, nonatomic) IBOutlet UILabel *nickname_2;
@property (weak, nonatomic) IBOutlet UILabel *nickname_3;
@property (weak, nonatomic) IBOutlet UILabel *nickname_4;
@property (weak, nonatomic) IBOutlet UILabel *nickname_5;

@property (weak, nonatomic) IBOutlet UILabel *descriptLabel;

@property (nonatomic, strong) CommunityHeaderModel *model;
/**
 *  cell自适应高度
 */
+ (CGFloat)cellHeight:(CommunityHeaderModel *)model;
@end
