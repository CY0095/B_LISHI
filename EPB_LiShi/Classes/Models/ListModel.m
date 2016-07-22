//
//  ListModel.m
//  tools
//
//  Created by lanou3g on 16/7/13.
//  Copyright © 2016年 杨旭东. All rights reserved.
//

#import "ListModel.h"

@implementation ListModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        _ID = value;
    }
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"parentid = %ld, catname = %@",(long)self.parentid,self.catname];
}

@end
