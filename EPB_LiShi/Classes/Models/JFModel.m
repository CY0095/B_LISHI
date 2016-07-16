//
//  FLModel.m
//  tools
//
//  Created by lanou3g on 16/7/15.
//  Copyright © 2016年 杨旭东. All rights reserved.
//

#import "JFModel.h"

@implementation JFModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"title == %@,price == %@",_title,_integral];
}

@end
