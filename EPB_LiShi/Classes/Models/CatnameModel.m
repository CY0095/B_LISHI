//
//  CatnameModel.m
//  tools
//
//  Created by lanou3g on 16/7/13.
//  Copyright © 2016年 杨旭东. All rights reserved.
//

#import "CatnameModel.h"

@implementation CatnameModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        _catnameID = value;
    }
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"catname == %@, list == %@",_catname,_list];
}

@end
