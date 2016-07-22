//
//  LikeListModel.m
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/21.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "LikeListModel.h"

@implementation LikeListModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        _userID = value;
    }
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"nickname = %@,id == %@",_nickname,_userID];
}

@end
