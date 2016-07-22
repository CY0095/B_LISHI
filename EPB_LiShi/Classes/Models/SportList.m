//
//  SportList.m
//  tools
//
//  Created by lanou3g on 16/7/13.
//  Copyright © 2016年 杨旭东. All rights reserved.
//

#import "SportList.h"

@implementation SportList

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        _ID = value;
    }
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"+++++title == %@",_title];
}

@end
