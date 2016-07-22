//
//  CommunityHeaderCell.h
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/19.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommunityHeaderModel.h"

#define CommunityHeaderCell_Identify @"CommunityHeaderCell_Identify"
@interface CommunityHeaderCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *backImage;

@property (weak, nonatomic) IBOutlet UIImageView *images;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *descript;
@property (weak, nonatomic) IBOutlet UILabel *members;

@property (weak, nonatomic) IBOutlet UIImageView *headicon0;
@property (weak, nonatomic) IBOutlet UIImageView *headicon1;
@property (weak, nonatomic) IBOutlet UIImageView *headicon2;
@property (weak, nonatomic) IBOutlet UIImageView *headicon3;
@property (weak, nonatomic) IBOutlet UIImageView *headicon4;
@property (weak, nonatomic) IBOutlet UIImageView *headicon5;

@property (nonatomic, strong) NSString *club_id;


@property (nonatomic, strong) CommunityHeaderModel *model;

@end
