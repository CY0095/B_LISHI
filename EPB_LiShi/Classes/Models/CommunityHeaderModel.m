//
//  CommunityHeaderModel.m
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/20.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "CommunityHeaderModel.h"

@implementation CommunityHeaderModel

- (NSString *)description {
    return [NSString stringWithFormat:@"id == %@ title == %@",self.club_id,self.title];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
    
    
}


@end
