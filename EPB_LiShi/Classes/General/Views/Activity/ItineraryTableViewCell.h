//
//  ItineraryTableViewCell.h
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/23.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

#define ItineraryTableViewCell_Identify  @"ItineraryTableViewCell_Identify"
@interface ItineraryTableViewCell : UITableViewCell

@property(strong,nonatomic) UILabel *titleLabel;

@property(strong,nonatomic) UILabel *detailLabel;


+(CGFloat)cellHeightWithString:(NSString *)string;


@end
