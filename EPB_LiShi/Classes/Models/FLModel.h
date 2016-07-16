//
//  FLModel.h
//  tools
//
//  Created by lanou3g on 16/7/15.
//  Copyright © 2016年 杨旭东. All rights reserved.
//

#import "BaseModel.h"

@interface FLModel : BaseModel

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *content;
@property (strong, nonatomic) NSString *images;
@property (strong, nonatomic) NSString *market_price;

@end
