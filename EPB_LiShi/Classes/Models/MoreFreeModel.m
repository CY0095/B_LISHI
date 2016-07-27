//
//  MoreFreeModel.m
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/23.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "MoreFreeModel.h"

@implementation MoreFreeModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        _tagID = value;
    }
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"name == %@,image == %@",_name,_tag_images];
}

@end
