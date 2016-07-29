//
//  BuySportModel.h
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/25.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "BaseModel.h"

@interface BuySportModel : BaseModel

//商品的名称
@property (strong, nonatomic) NSString *title;
//商品的图片
@property (strong, nonatomic) NSString *thumb;
//商品的价格
@property (assign, nonatomic) CGFloat market_price;
//商品的描述
@property (strong, nonatomic) NSString *Sportdescription;
//商品详情的图片
@property (strong, nonatomic) NSArray *zhuangbeiimg;
//传送到商店的ID
@property (strong, nonatomic) NSString *brand_id;
//分享的网址
@property (strong, nonatomic) NSString *share_url;

@end
