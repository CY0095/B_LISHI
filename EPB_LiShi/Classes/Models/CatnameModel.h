//
//  CatnameModel.h
//  tools
//
//  Created by lanou3g on 16/7/13.
//  Copyright © 2016年 杨旭东. All rights reserved.
//

#import "BaseModel.h"
#import "ListModel.h"
@interface CatnameModel : BaseModel

//服装类型名称
@property (nonatomic, strong) NSString *catname;
//服装类型ID
@property (nonatomic, strong) NSString *catnameID;
//服装类型的种类
@property (nonatomic, strong) ListModel *list;

@end
