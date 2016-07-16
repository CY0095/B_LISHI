//
//  ToolsModel.h
//  tools
//
//  Created by lanou3g on 16/7/13.
//  Copyright © 2016年 杨旭东. All rights reserved.
//

#import "BaseModel.h"
#import "ListModel.h"

@interface ToolsModel : BaseModel

//装备库
@property (nonatomic, strong) NSString *cateList;
//户外店
@property (nonatomic, strong) NSString *sports_cates;

////装备类型
//@property (nonatomic, strong) NSString *catname;
////id
//@property (nonatomic, strong) NSString *catnameID;
////装备类型的种类
//@property (nonatomic, strong) ListModel *listDetail;

@end
