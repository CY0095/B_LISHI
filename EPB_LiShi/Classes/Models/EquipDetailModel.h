//
//  EquipDetailModel.h
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/18.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "BaseModel.h"

@interface EquipDetailModel : BaseModel

//衣服详情的描述
@property (strong, nonatomic) NSString *ID;
//衣服de名称
@property (strong, nonatomic) NSString *title;
//衣服的照片
@property (strong, nonatomic) NSString *thumb;

@end
