//
//  CommunityListModel.m
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/15.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "CommunityListModel.h"

@implementation CommunityListModel

- (NSString *)description {
    return [NSString stringWithFormat:@"活动ID == %@，活动title == %@",self.topic_id,self.title];
}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
    if ([key isEqualToString:@"id"]) {
        _ID = value;
    }
    
}




@end
