//
//  ShopDetailTableViewCell.h
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/27.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
#define shopDetailViewCell_Identify @"shopDetailViewCell_Identify"
#import "ShopDetailModel.h"
@class ShopDetailTableViewCell;

@protocol ShopDetailDelegate <NSObject>

- (void)buttonClick:(ShopDetailTableViewCell *)cell;

@end

@interface ShopDetailTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UIButton *addressButton;
//商店的经度
@property (strong, nonatomic) NSString *gaode_longitude;
//商店的纬度
@property (strong, nonatomic) NSString *gaode_latitude;
//电话
@property (strong, nonatomic) NSString *phone;

@property (strong, nonatomic) ShopDetailModel *model;

@property (weak, nonatomic) id<ShopDetailDelegate>delegate;

@end
