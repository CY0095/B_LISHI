//
//  sports_catesModel.m
//  tools
//
//  Created by lanou3g on 16/7/13.
//  Copyright © 2016年 杨旭东. All rights reserved.
//

#import "sports_catesModel.h"

@implementation sports_catesModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        _sportID = value;
    }
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"title == %@, sportID == %@,list == %@",_title,_sportID,_list];
}

@end
