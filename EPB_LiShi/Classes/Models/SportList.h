//
//  SportList.h
//  tools
//
//  Created by lanou3g on 16/7/13.
//  Copyright © 2016年 杨旭东. All rights reserved.
//

#import "BaseModel.h"

@interface SportList : BaseModel

//运动方式的种类
@property (nonatomic, strong) NSString *title;
//运动服装的ID
@property (strong, nonatomic) NSString *ID;

@end
