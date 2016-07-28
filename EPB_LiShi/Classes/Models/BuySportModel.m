//
//  BuySportModel.m
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/25.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "BuySportModel.h"

@implementation BuySportModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"description"]) {
        _Sportdescription = value;
    }
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"title == %@,price == %ld,brandID == %@",_title,(long)_market_price,_brand_id];
}

@end
