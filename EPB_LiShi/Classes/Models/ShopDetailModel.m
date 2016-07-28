//
//  ShopDetailModel.m
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/27.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "ShopDetailModel.h"

@implementation ShopDetailModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"title == %@,tel == %@",_title,_phone];
}

@end
