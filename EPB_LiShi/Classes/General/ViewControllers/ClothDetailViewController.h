//
//  ClothDetailViewController.h
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/19.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "BaseViewController.h"
#import "FLModel.h"
#import "FLClothModel.h"
#import "MoreFreeModel.h"

@interface ClothDetailViewController : BaseViewController

@property (strong, nonatomic) FLModel *model;
@property (strong, nonatomic) FLClothModel *flClothModel;
@property (strong, nonatomic) MoreFreeModel *freeModel;

@end
