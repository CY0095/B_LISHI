//
//  ShopModel.h
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/26.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "BaseModel.h"

@interface ShopModel : BaseModel

//地址
@property (strong, nonatomic) NSString *address;
//星级
@property (strong, nonatomic) NSString *star;
//商铺名称
@property (strong, nonatomic) NSString *title;
//商铺照片
@property (strong, nonatomic) NSString *img;
//距离
@property (strong, nonatomic) NSString *distance;

@end
