//
//  CommunityDetailListModel.m
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/22.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "CommunityDetailListModel.h"

@implementation CommunityDetailListModel

- (NSString *)description {
    return [NSString stringWithFormat:@"content == %@,image == %@, videoimg == %@",self.content,self.images,self.videoimg];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
    
    
}



@end
