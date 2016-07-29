//
//  ShopModel.h
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/29.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "BaseModel.h"

@interface ShopModel : BaseModel
//地址
@property (strong, nonatomic) NSString *address;
//星级
@property (assign, nonatomic) NSInteger star;
//商铺名称
@property (strong, nonatomic) NSString *title;
//商铺照片
@property (strong, nonatomic) NSString *img;
//距离
@property (assign, nonatomic) CGFloat distance;
//商铺的ID，传递使用
@property (strong, nonatomic) NSString *oid;
@end
