//
//  LikeNumCollectionViewCell.h
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/22.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
#define likeNumViewCell_Identify @"likeNumViewCell_Identify"
#import "LikeListModel.h"

@interface LikeNumCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UIImageView *headImg;

@property (strong, nonatomic) LikeListModel *model;
@end
