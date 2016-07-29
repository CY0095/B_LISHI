//
//  PicModel.m
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/28.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "PicModel.h"

@implementation PicModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"pic == %@",_th_pic];
}

@end
