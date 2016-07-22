//
//  JoinStyleModel.m
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/21.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "JoinStyleModel.h"

@implementation JoinStyleModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"times === %@",_times];
}

@end
