//
//  ShopModel.m
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/29.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "ShopModel.h"

@implementation ShopModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"title == %@,star == %ld",_title,(long)_star];
}
@end
