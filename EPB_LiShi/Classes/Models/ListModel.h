//
//  ListModel.h
//  tools
//
//  Created by lanou3g on 16/7/13.
//  Copyright © 2016年 杨旭东. All rights reserved.
//

#import "BaseModel.h"

@interface ListModel : BaseModel

//服装类型
@property (nonatomic, strong) NSString *catname;
//父类的ID
@property (nonatomic, assign) NSInteger parentid;

@end
