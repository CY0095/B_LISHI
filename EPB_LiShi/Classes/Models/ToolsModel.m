//
//  ToolsModel.m
//  tools
//
//  Created by lanou3g on 16/7/13.
//  Copyright © 2016年 杨旭东. All rights reserved.
//

#import "ToolsModel.h"

@implementation ToolsModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"catname = %@,sports = %@",_cateList,_sports_cates];
}

@end
