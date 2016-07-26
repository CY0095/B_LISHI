//
//  TopicImagelistModel.m
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/23.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "TopicImagelistModel.h"

@implementation TopicImagelistModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"image == %@",_images];
}

@end
