//
//  sports_catesModel.h
//  tools
//
//  Created by lanou3g on 16/7/13.
//  Copyright © 2016年 杨旭东. All rights reserved.
//

#import "BaseModel.h"
#import "sportList.h"

@interface sports_catesModel : BaseModel

//运动方式
@property (nonatomic, strong) NSString *title;
//运动ID
@property (nonatomic, strong) NSString *sportID;
//运动方式的种类
@property (nonatomic, strong) NSString *list;


@end
