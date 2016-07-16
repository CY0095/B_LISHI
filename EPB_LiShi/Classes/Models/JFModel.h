//
//  FLModel.h
//  tools
//
//  Created by lanou3g on 16/7/15.
//  Copyright © 2016年 杨旭东. All rights reserved.
//

#import "BaseModel.h"

@interface JFModel : BaseModel

//商品的图片
@property (nonatomic, strong) NSString *images;
//商品是名称
@property (nonatomic, strong) NSString *title;
//商品的介绍
@property (nonatomic, strong) NSString *content;
//兑换需要的积分
@property (nonatomic, strong) NSString *integral;

@end
