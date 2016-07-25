//
//  CommunityCustomCell.h
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/23.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommunityCoCellModel.h"
#define CommunityCustomCell_Identify @"CommunityCustomCell_Identify"
@interface CommunityCustomCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *club_title;
@property (weak, nonatomic) IBOutlet UILabel *total;
@property (nonatomic, strong) NSString *club_id;
@property (nonatomic, strong) NSString *members;

@property (nonatomic, strong) CommunityCoCellModel *model;

@end
