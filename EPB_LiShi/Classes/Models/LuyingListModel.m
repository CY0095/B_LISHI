//
//  LuyingListModel.m
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/18.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "LuyingListModel.h"

@implementation LuyingListModel

- (NSString *)description {
    
    return [NSString stringWithFormat:@"露营列表ID == %@,图片 == %@",self.list_id,self.images];
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
    if ([key isEqualToString:@"id"] ) {
        _list_id = value;
        
    }else if ([key isEqualToString:@"image"]){
        _images = value;
    }
    
}

@end
