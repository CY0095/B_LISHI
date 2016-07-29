//
//  MapViewController.h
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/26.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "BaseViewController.h"
#import "ActivityDetailModel.h"
#import "ShopDetailModel.h"

@interface MapViewController : BaseViewController

@property(strong,nonatomic) ActivityDetailModel *model;
@property (strong, nonatomic) ShopDetailModel *model1;

@property(strong,nonatomic) NSString *longitude;

@property(strong,nonatomic) NSString *latitude;

@end
