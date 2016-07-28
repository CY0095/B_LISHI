//
//  ShopProductTableViewCell.h
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/28.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
#define shopProductViewCell_Identify @"shopProductViewCell_Identify"
#import "ShopDetailModel.h"

@interface ShopProductTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *productLabel;

@property (strong, nonatomic) ShopDetailModel *model;

//计算当前cell实际需要的高度
+(CGFloat)cellHeight:(ShopDetailModel *)model;

@end
