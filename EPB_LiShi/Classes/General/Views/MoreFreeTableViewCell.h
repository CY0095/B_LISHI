//
//  MoreFreeTableViewCell.h
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/23.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MoreFreeModel.h"
#define moreFreeViewCell_Identify @"moreFreeViewCell_Identify"

@class MoreFreeTableViewCell;
@protocol freeDelegate <NSObject>

- (void)freeClickButton:(MoreFreeTableViewCell *)cell;

@end

@interface MoreFreeTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UIImageView *backImg;
@property (strong, nonatomic) IBOutlet UIButton *nextClick;

@property (strong,nonatomic) MoreFreeModel *model;
@property (weak, nonatomic) id<freeDelegate> delegate;

@end
