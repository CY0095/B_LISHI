//
//  ShopDetailModel.h
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/27.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "BaseModel.h"

@interface ShopDetailModel : BaseModel

//商店展示的图片
@property (strong, nonatomic) NSArray *pic;
//商店的名称
@property (strong, nonatomic) NSString *title;
//地址
@property (strong, nonatomic) NSString *address;
//电话
@property (strong, nonatomic) NSString *phone;
//主营产品
@property (strong, nonatomic) NSString *product;
//商店的经度
@property (strong, nonatomic) NSString *gaode_longitude;
//商店的纬度
@property (strong, nonatomic) NSString *gaode_latitude;

@end
