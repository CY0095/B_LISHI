//
//  EquipDetailCollectionViewCell.h
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/19.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
#define EquipDetailViewCell_Identify @"EquipDetailViewCell_Identify"
#import "EquipDetailModel.h"
#import "SportClothModel.h"

@interface EquipDetailCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UIImageView *DetailImage;
@property (strong, nonatomic) IBOutlet UILabel *DetailTitle;


@property (strong, nonatomic) EquipDetailModel *model;
@property (strong, nonatomic) SportClothModel *model1;

@end
