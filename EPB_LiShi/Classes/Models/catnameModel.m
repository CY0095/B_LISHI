//
//  catnameModel.m
//  tools
//
//  Created by lanou3g on 16/7/13.
//  Copyright © 2016年 杨旭东. All rights reserved.
//

#import "catnameModel.h"

@implementation catnameModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        _catnameID = value;
    }else if ([key isEqualToString:@"list"])
    {
        ListModel *model = [[ListModel alloc] init];
        [model setValuesForKeysWithDictionary:value];
        _list = model;
    }
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"catname == %@, list == %@",_catname,_list];
}

@end
