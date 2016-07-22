//
//  SportClothModel.m
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/20.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "SportClothModel.h"

@implementation SportClothModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        _ID = value;
    }
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"title == %@,picture == %@",_title,_thumb];
}

@end
