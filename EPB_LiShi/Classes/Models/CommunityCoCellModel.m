//
//  CommunityCoCellModel.m
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/23.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "CommunityCoCellModel.h"

@implementation CommunityCoCellModel


- (NSString *)description {
    return [NSString stringWithFormat:@"%@ ===== %@",self.club_id,self.club_title];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
    if ([key isEqualToString:@"image"]) {
        _image = value;
    }
    
}


@end
