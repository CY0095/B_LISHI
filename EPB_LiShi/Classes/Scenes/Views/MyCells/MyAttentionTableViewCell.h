//
//  MyAttentionTableViewCell.h
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/19.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyAttentionModel.h"
#define MyAttentionTableViewCell_Identify @"MyAttentionTableViewCell_Identify"
@interface MyAttentionTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImg;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (strong, nonatomic) MyAttentionModel *model;

@end
