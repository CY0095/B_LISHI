//
//  EquipDetailModel.m
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/18.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "EquipDetailModel.h"

@implementation EquipDetailModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        _ID = value;
    }
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"title == %@,ID == %@",_title,_ID];
}

@end
