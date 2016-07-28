//
//  zhuangBeiPicModel.m
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/25.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "zhuangBeiPicModel.h"

@implementation zhuangBeiPicModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"picture == %@,height == %ld",_images,(long)_height];
}

@end
