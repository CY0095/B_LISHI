//
//  FLClothModel.m
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/19.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "FLClothModel.h"

@implementation FLClothModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"visits == %ld, picture == %@, 状态 === %ld",(long)_visits,_topic_image,(long)_is_jion];
}
@end
