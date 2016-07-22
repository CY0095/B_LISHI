//
//  ComDetailFirstCell.h
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/22.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommunityDetailModel.h"

#define ComDetailFirstCell_Identify @"ComDetailFirstCell_Identify"
@interface ComDetailFirstCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headicon;
@property (weak, nonatomic) IBOutlet UILabel *nickname;
@property (weak, nonatomic) IBOutlet UIButton *attenStatus;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *createtime;
@property (weak, nonatomic) IBOutlet UILabel *browsenums;

@property (nonatomic, strong) CommunityDetailModel *model;
@end
